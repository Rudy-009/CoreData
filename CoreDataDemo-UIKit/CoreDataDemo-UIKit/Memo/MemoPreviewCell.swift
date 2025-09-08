//
//  MemoPreviewCell.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 9/5/25.
//

import UIKit

protocol MemoPreviewCellDelegate {
    func likedPressed(_ memo: Memo)
}

final class MemoPreviewCell: UITableViewCell {
    
    private var memo: Memo?
    private var delegate: MemoPreviewCellDelegate?
    static let reuseIdentifier = "MemoPreviewCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var contentPreviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 1
        return label
    }()
    
    public lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart") , for: .normal)
        return button
    }()
    
    func configure(with memo: Memo, delegate: MemoPreviewCellDelegate) {
        self.memo = memo
        self.delegate = delegate
        titleLabel.text = memo.title
        guard let content = memo.content else { contentPreviewLabel.text = nil; return }
        guard content.count > 30 else { contentPreviewLabel.text = content; return }
        let index = content.index(content.startIndex, offsetBy: 30)
        contentPreviewLabel.text = String(content[..<index]) + "..."
        likeButton.setImage( memo.liked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart") , for: .normal)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // Add subviews
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentPreviewLabel)
        contentView.addSubview(likeButton)

        // Disable autoresizing mask
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentPreviewLabel.translatesAutoresizingMaskIntoConstraints = false

        // Constraints
        NSLayoutConstraint.activate([
            // Content Height
            contentView.heightAnchor.constraint(equalToConstant: 100),
            
            // Like button constraints
            likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            likeButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            likeButton.widthAnchor.constraint(equalToConstant: 70),
            likeButton.heightAnchor.constraint(equalToConstant: 70),
            
            // Title label constraints
            titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: -11),
            
            // Content preview label constraints
            contentPreviewLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            contentPreviewLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            contentPreviewLabel.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: -12),
        ])
        
        likeButton.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func handleLike() {
        delegate?.likedPressed(self.memo!)
    }
    
}
