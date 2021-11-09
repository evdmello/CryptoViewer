//
//  AboutCoinTableViewCell.swift
//  CryptoViewer
//
//  Created by Errol on 03/11/21.
//

import UIKit

final class AboutCoinTableViewCell: UITableViewCell {
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    static var identifier: String {
        String(describing: self)
    }

    static var nib: UINib {
        UINib(nibName: identifier, bundle: Bundle(for: self))
    }

    func configure(with viewModel: AboutCoinCellViewModel) {
        primaryLabel.attributedText = viewModel.title
        secondaryLabel.text = viewModel.subtitle
    }
}
