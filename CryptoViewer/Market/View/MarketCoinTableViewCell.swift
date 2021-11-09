//
//  MarketCoinTableViewCell.swift
//  CryptoViewer
//
//  Created by Errol on 03/11/21.
//

import UIKit

final class MarketCoinTableViewCell: UITableViewCell {
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var variation: UILabel!
    @IBOutlet weak var cellBackground: UIView!
    @IBOutlet weak var variationImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }

    static var identifier: String {
        String(describing: self)
    }

    static var nib: UINib {
        UINib(nibName: identifier, bundle: Bundle(for: self))
    }

    func configure(with viewModel: MarketCoinTableViewCellViewModel) {
        name.text = viewModel.name
        price.text = viewModel.price
        symbol.text = viewModel.symbol
        variation.text = viewModel.variation
        coinImage.image = UIImage(named: viewModel.imageName)
        variationImage.image = viewModel.isVariationPositive ? .upTriangleArrow : .downTriangleArrow
        variationImage.tintColor = viewModel.isVariationPositive ? .systemGreen : .systemRed
        cellBackground.backgroundColor = viewModel.isVariationPositive ? .lightGreenBackground : .lightRedBackground
    }

    private func configureView() {
        cellBackground.layer.cornerRadius = 8.0
        cellBackground.clipsToBounds = true
        contentView.backgroundColor = .secondarySystemBackground
    }
}
