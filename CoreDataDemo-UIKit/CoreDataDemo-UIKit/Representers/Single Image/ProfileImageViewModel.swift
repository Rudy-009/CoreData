//
//  ProfileImageUseCase.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 9/8/25.
//

import CoreData
import UIKit

final class ProfileImageViewModel {
    
    private let viewContext = CoreDataStack.shared.persistentContainer.viewContext
    static let shared = ProfileImageViewModel()
    var profileImage: UIImage?
    
    func saveProfileImage(_ image: UIImage) {
        let fetchRequest: NSFetchRequest<ProfileImageEntity> = ProfileImageEntity.fetchRequest()
        
        if let profile = try? viewContext.fetch(fetchRequest).first {
            profile.data = image.jpegData(compressionQuality: 0.9)
        } else {
            let newProfile = ProfileImageEntity(context: viewContext)
            newProfile.data = image.jpegData(compressionQuality: 0.9)
        }
        try? viewContext.save()
    }
    
    func loadProfileImage() -> UIImage? {
        let fetchRequest: NSFetchRequest<ProfileImageEntity> = ProfileImageEntity.fetchRequest()
        
        if let profile = try? viewContext.fetch(fetchRequest).first,
           let data = profile.data {
            return UIImage(data: data)
        }
        return nil
    }
    
}
