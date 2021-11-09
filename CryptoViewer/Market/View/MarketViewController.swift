//
//  MarketViewController.swift
//  CryptoViewer
//
//  Created by Errol on 03/11/21.
//

import UIKit

final class MarketViewController: UIViewController {

    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    private var coins: [MarketCoinTableViewCellViewModel] = []
    private var viewModel: MarketViewModel!

    func initialize(with viewModel: MarketViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bindToViewModel()
    }

    private func configureView() {
        title = "Crypto Viewer"
        configureTableView()
    }

    private func configureTableView() {
        tableView.register(MarketCoinTableViewCell.nib, forCellReuseIdentifier: MarketCoinTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .secondarySystemBackground

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    @objc private func refresh(_ sender: UIRefreshControl) {
        if sender.isRefreshing {
            loadMarket()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMarket()
    }

    private func loadMarket() {
        DispatchQueue.main.async {
            self.tableView.refreshControl?.beginRefreshing()
        }
        viewModel.load()
    }

    private func bindToViewModel() {
        viewModel.coins.bind { [weak self] coins in
            DispatchQueue.main.async {
                self?.coins = coins
                self?.tableView.refreshControl?.endRefreshing()
                self?.tableView.reloadData()
            }
        }

        viewModel.totalMarketCap.bind { [weak self] value in
            DispatchQueue.main.async {
                self?.capacityLabel.text = value
            }
        }

        viewModel.total24hVolume.bind { [weak self] value in
            DispatchQueue.main.async {
                self?.volumeLabel.text = value
            }
        }

        viewModel.loadError.bind { [weak self] value in
            guard let self = self, let value = value else { return }
            self.showAlert(message: value)
            DispatchQueue.runOnMainIfNeeded {
                self.tableView.refreshControl?.endRefreshing()
            }
            self.tableView.showErrorMessage(value)
        }
    }
}

extension MarketViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coins.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MarketCoinTableViewCell.identifier, for: indexPath) as? MarketCoinTableViewCell else {
            NSLog("Could not dequeue cell", MarketCoinTableViewCell.identifier)
            return UITableViewCell()
        }
        cell.configure(with: coins[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        coins[indexPath.row].select()
    }
}
