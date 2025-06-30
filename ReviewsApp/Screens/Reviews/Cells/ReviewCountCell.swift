//
//  ReviewCountCell.swift
//  ReviewsApp
//
//  Created by Илья Малинов on 30.06.2025.
//

import UIKit

struct ReviewCountCellConfig {
    static let reuseId = String(describing: ReviewCountCellConfig.self)
    
    let reviewCountText: NSAttributedString
    
    fileprivate let layout = ReviewCountCellLayout()
}

extension ReviewCountCellConfig: TableCellConfig {
    
    func update(cell: UITableViewCell) {
        guard let cell = cell as? ReviewCountCell else { return }
        cell.reviewCountLabel.attributedText = reviewCountText
        cell.config = self
    }
    
    func height(with size: CGSize) -> CGFloat {
        layout.height(config: self, maxWidth: size.width)
    }
    
    
}

final class ReviewCountCell: UITableViewCell {
    
    fileprivate var config: Config?
        
    fileprivate var reviewCountLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(reviewCountLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let layout = config?.layout else { return }
        reviewCountLabel.frame = layout.reviewCountLabelFrame
    }
}

private final class ReviewCountCellLayout {
    fileprivate static let height: CGFloat = 44.0
    
    private(set) var reviewCountLabelFrame = CGRect.zero
    
    private let insets = UIEdgeInsets(top: 9.0, left: 12.0, bottom: 9.0, right: 12.0)
    
    func height(config: ReviewCountCellConfig, maxWidth: CGFloat) -> CGFloat {
        let width = maxWidth - insets.left - insets.right
        let labelSize = config.reviewCountText.boundingRect(width: width).size
        
        reviewCountLabelFrame = CGRect(
            x: insets.left + (width - labelSize.width) / 2 ,
            y: (Self.height - labelSize.height) / 2,
            width: labelSize.width,
            height: labelSize.height
        )
        
        return Self.height
    }
}
// MARK: - Typealias

fileprivate typealias Config = ReviewCountCellConfig
fileprivate typealias Layout = ReviewCountCellLayout
