//
//  MemoCoreData.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 9/5/25.
//

import CoreData
import Foundation

protocol MemoCoreDataProtocol {
    func fetchMemos() -> Result<[Memo], CoreDataError>
    func saveMemo(_ memo: Memo) -> Result<Bool, CoreDataError>
    func deleteMemo(_ memo: Memo) -> Result<Bool, CoreDataError>
}

class MemoCoreData: MemoCoreDataProtocol {
    private let viewContext: NSManagedObjectContext
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
    
    func fetchMemos() -> Result<[Memo], CoreDataError> {
        let fetchRequest: NSFetchRequest<MemoEntity> = MemoEntity.fetchRequest()
        do {
            let result = try viewContext.fetch(fetchRequest)
            let memoList: [Memo] = result.compactMap { memoEntity in
                guard let id = memoEntity.id, let title = memoEntity.title, let createdAt = memoEntity.createdAt,
                      let editedAt = memoEntity.editedAt, let lastReadAt = memoEntity.lastReadAt else {
                      return nil }
                return Memo(id: id, title: title, content: memoEntity.content, createdAt: createdAt,
                                editedAt: editedAt, lastReadAt: lastReadAt, liked: memoEntity.liked)
            }
            return .success(memoList)
        } catch {
            return .failure(CoreDataError.fetchFailed("MemoEntity"))
        }
    }
    
    func saveMemo(_ memo: Memo) -> Result<Bool, CoreDataError> {
        guard let entity = NSEntityDescription.entity(forEntityName: "MemoEntity", in: viewContext) else {
            return .failure(CoreDataError.EntityNotFound("MemoEntity"))
        }
        let memoObject = NSManagedObject(entity: entity, insertInto: viewContext)
        memoObject.setValue(memo.id, forKey: "id")
        memoObject.setValue(memo.title, forKey: "title")
        memoObject.setValue(memo.content, forKey: "content")
        memoObject.setValue(memo.createdAt, forKey: "createdAt")
        memoObject.setValue(memo.editedAt, forKey: "editedAt")
        memoObject.setValue(memo.lastReadAt, forKey: "lastReadAt")
        memoObject.setValue(memo.liked, forKey: "liked")
        
        do {
            try viewContext.save()
            return .success(true)
        } catch {
            return .failure(CoreDataError.saveFailed("MemoEntity"))
        }
    }
    
    func deleteMemo(_ memo: Memo) -> Result<Bool, CoreDataError> {
        let fetchRequest: NSFetchRequest<MemoEntity> = MemoEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", memo.id.uuidString)
        
        do {
            let result = try viewContext.fetch(fetchRequest)
            result.forEach { memoEntity in
                viewContext.delete(memoEntity)
            }
            try viewContext.save()
            return .success(true)
        } catch {
            return .failure(CoreDataError.fetchFailed("MemoEntity"))
        }
    }
    
}

public enum CoreDataError: Error {
    case fetchFailed(String)
    case EntityNotFound(String)
    case saveFailed(String)
    case deleteFailed(String)
}
