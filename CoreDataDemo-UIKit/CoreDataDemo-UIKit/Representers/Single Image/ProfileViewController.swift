//
//  ProfileViewController.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 9/8/25.
//

import UIKit
import CoreData

final class ProfileViewController: UIViewController {
    
    let viewModel = ProfileImageViewModel()
    let profileView = ProfileView()
    let context: NSManagedObjectContext = CoreDataStack.shared.viewContext
    
    private lazy var picker: UIImagePickerController = {
        let picker = UIImagePickerController()
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = profileView
        profileView.addProfileImageButton.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
        profileView.setImage(viewModel.loadProfileImage() ?? UIImage(systemName: "person.circle")!)
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
        viewModel.saveProfileImage(image)
        profileView.setImage(image)
        dismiss(animated: true, completion: nil)
    }
    
}
