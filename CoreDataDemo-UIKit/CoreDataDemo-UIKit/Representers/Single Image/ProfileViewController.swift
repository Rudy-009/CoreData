//
//  ProfileViewController.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 9/8/25.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    let profileView = ProfileView()
    
    private lazy var picker: UIImagePickerController = {
        let picker = UIImagePickerController()
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = profileView
        profileView.addProfileImageButton.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
        picker.delegate = self
    }
    
    @objc
    private func editProfile() {
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        present(picker, animated: true, completion: nil)
    }
    
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        profileView.setImage(image)
        dismiss(animated: true, completion: nil)
    }
    
}
