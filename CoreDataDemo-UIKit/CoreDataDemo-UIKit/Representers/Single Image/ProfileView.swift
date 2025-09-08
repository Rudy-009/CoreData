//
//  ProfileView.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 9/8/25.
//

import UIKit

final class ProfileView: UIView {
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 80
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    public var addProfileImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus.app"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        addSubview(profileImageView)
        addSubview(addProfileImageButton)
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        addProfileImageButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 160),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 160),
            profileImageView.widthAnchor.constraint(equalToConstant: 160),
            
            addProfileImageButton.heightAnchor.constraint(equalToConstant: 100),
            addProfileImageButton.widthAnchor.constraint(equalToConstant: 100),
            addProfileImageButton.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 40),
            addProfileImageButton.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 40),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
