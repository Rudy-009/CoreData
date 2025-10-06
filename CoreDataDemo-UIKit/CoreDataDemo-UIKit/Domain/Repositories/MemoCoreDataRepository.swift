//
//  MemoCoreDataRepository.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 9/5/25.
//

import CoreData
import Foundation
import UIKit

protocol MemoCoreDataRepositoryProtocol {
    func getAllMemos() -> Result<[Memo], CoreDataError>
    func saveMemo(_ memo: Memo) -> Result<Bool, CoreDataError>
    func deleteMemo(_ memo: Memo) -> Result<Bool, CoreDataError>
    func editMemo(_ memo: Memo) -> Result<Bool, CoreDataError>
}

class MemoCoreDataRepository: MemoCoreDataRepositoryProtocol {
    
    private let viewContext: NSManagedObjectContext = CoreDataStack.shared.viewContext
    
    init() { }
    
    func getAllMemos() -> Result<[Memo], CoreDataError> {
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
        let memoEntity = MemoEntity(context: viewContext)
        memoEntity.id = memo.id
        memoEntity.title = memo.title
        memoEntity.content = memo.content
        memoEntity.createdAt = memo.createdAt
        memoEntity.editedAt = memo.editedAt
        memoEntity.lastReadAt = memo.lastReadAt
        memoEntity.liked = memo.liked
        
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
    
    func editMemo(_ memo: Memo) -> Result<Bool, CoreDataError> {
        let fetchRequest: NSFetchRequest<MemoEntity> = MemoEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", memo.id.uuidString)
        
        do {
            let result = try viewContext.fetch(fetchRequest)
            result.forEach { memoEntity in
                memoEntity.title = memo.title
                memoEntity.content = memo.content
                memoEntity.createdAt = memo.createdAt
                memoEntity.editedAt = memo.editedAt
                memoEntity.lastReadAt = memo.lastReadAt
                memoEntity.liked = memo.liked
            }
            try viewContext.save()
            return .success(true)
        } catch {
            return .failure(CoreDataError.fetchFailed("MemoEntity"))
        }
    }
    
}
