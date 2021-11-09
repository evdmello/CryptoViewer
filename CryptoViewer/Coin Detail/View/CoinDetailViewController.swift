//
//  CoinDetailViewController.swift
//  CryptoViewer
//
//  Created by Errol on 03/11/21.
//

import UIKit

final class CoinDetailViewController: UIViewController {
    @IBOutlet weak var variationImage: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var variation: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var graphView: UIView!
    private var lineColor: UIColor = .clear
    private var viewModel: CoinDetailViewModel!

    func initialize(with viewModel: CoinDetailViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bindToViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        load()
    }

    private func load() {
        tableView.refreshControl?.beginRefreshing()
        viewModel.load()
    }

    private func bindToViewModel() {
        viewModel.price.bind { [weak self] price in
            DispatchQueue.runOnMainIfNeeded {
                self?.price.text = price
            }
        }

        viewModel.variation.bind { [weak self] value in
            DispatchQueue.runOnMainIfNeeded {
                self?.variation.text = value
            }
        }

        viewModel.isVariationPositive.bind { [weak self] value in
            guard let self = self else { return }
            DispatchQueue.runOnMainIfNeeded {
                self.lineColor = value ? .systemGreen : .systemRed
                self.variationImage.image = value ? .upTriangleArrow : .downTriangleArrow
                self.variationImage.tintColor = self.lineColor
            }
        }

        viewModel.normalizedSparkline.bind { [weak self] values in
            guard let self = self else { return }
            let linePath = self.makeLinePath(points: values, view: self.graphView)
            let shapeLayer = self.makeLineShapeLayer(path: linePath, lineColor: self.lineColor)
            DispatchQueue.runOnMainIfNeeded {
                self.graphView.layer.sublayers = nil
                self.graphView.layer.addSublayer(shapeLayer)
            }
        }

        viewModel.tableSections.bind { [weak self] value in
            guard let self = self else { return }
            DispatchQueue.runOnMainIfNeeded {
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }

        viewModel.loadError.bind { [weak self] value in
            guard let self = self, let value = value else { return }
            DispatchQueue.runOnMainIfNeeded {
                self.tableView.refreshControl?.endRefreshing()
            }
            self.tableView.showErrorMessage(value)
            self.showAlert(message: value)
        }
    }

    private func configureView() {
        configureNavigationBar(title: viewModel.name, symbol: viewModel.symbol, iconName: viewModel.imageName)
        configureGraphView()
        configureTableView()
    }

    private func configureGraphView() {
        graphView.clipsToBounds = true
        graphView.layer.borderColor = UIColor.gray.cgColor
        graphView.layer.borderWidth = 1.0
    }

    private func configureTableView() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.register(AboutCoinTableViewCell.nib, forCellReuseIdentifier: AboutCoinTableViewCell.identifier)
        tableView.dataSource = self
    }

    @objc private func refresh(_ sender: UIRefreshControl) {
        if sender.isRefreshing {
            load()
        }
    }

    private func configureNavigationBar(title: String, symbol: String, iconName: String) {
        let navigationRightView = UIStackView()
        let imageView = UIImageView(image: UIImage(named: iconName))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        let label = UILabel()
        label.text = symbol
        navigationRightView.addArrangedSubview(imageView)
        navigationRightView.addArrangedSubview(label)
        navigationRightView.spacing = 5.0
        let button = UIBarButtonItem(customView: navigationRightView)
        navigationItem.setRightBarButton(button, animated: false)
        self.title = title
    }
}

extension CoinDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.tableSections.value.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tableSections.value[section].items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AboutCoinTableViewCell.identifier, for: indexPath) as? AboutCoinTableViewCell else {
            return UITableViewCell()
        }
        let cellViewModel = viewModel.tableSections.value[indexPath.section].items[indexPath.row]
        cell.configure(with: cellViewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.tableSections.value[section].title
    }
}

// MARK: - Draw line graph using normalized points.
extension CoinDetailViewController {
    /// Helper method to get the bezier path of the line using normalized values.
    /// - Parameters:
    ///   - points: Normalized price values - (0.0 ... 1.0)
    ///   - view: The view on which you want to draw the line graph
    /// - Returns: UIBezierPath of the line
    private func makeLinePath(points: [Double], view: UIView) -> UIBezierPath {
        let linePath = UIBezierPath()
        for (index, point) in points.enumerated() {
            let xPos = (view.bounds.size.width) / CGFloat(points.count - 1) * CGFloat(index)
            let yPos = (1 - point) * (view.bounds.size.height - 2)
            if index == 0 {
                linePath.move(to: CGPoint(x: xPos, y: yPos))
            }
            linePath.addLine(to: CGPoint(x: xPos, y: yPos))
        }
        return linePath
    }

    private func makeLineShapeLayer(path: UIBezierPath, lineColor: UIColor) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 2.0
        shapeLayer.position = CGPoint(x: 0.0, y: 0.0)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = lineColor.cgColor
        return shapeLayer
    }
}
