//
//  ProfileViewController.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 9/8/25.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    let profileView = ProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = profileView
        profileView.addProfileImageButton.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
    }
    
    @objc
    private func editProfile() {
        print("edit profile")
    }
    
}
