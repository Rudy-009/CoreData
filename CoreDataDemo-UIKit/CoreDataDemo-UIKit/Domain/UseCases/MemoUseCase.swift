//
//  MemoUseCase.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 10/6/25.
//

import Foundation

class MemoUseCase: MemoUseCaseProtocol {
    
    private var memoCoreDatarepository: MemoCoreDataRepositoryProtocol
    
    init(memoCoreData: MemoCoreDataRepositoryProtocol) {
        self.memoCoreDatarepository = memoCoreData
    }
    
    func addMemo(title: String, content: String) -> Result<Bool, CoreDataError> {
        let memo = Memo(title: title, content: content)
        return memoCoreDatarepository.saveMemo(memo)
    }
    
    func editMemo(memo: Memo) -> Result<Bool, CoreDataError> {
        return memoCoreDatarepository.editMemo(memo)
    }
    
    func deleteMemo(memo: Memo) -> Result<Bool, CoreDataError> {
        return memoCoreDatarepository.deleteMemo(memo)
    }
    
    func fetchMemos() -> Result<[Memo], CoreDataError> {
        return memoCoreDatarepository.getAllMemos()
    }
    
    func toggleLike(newStateMemo: Memo) -> Result<Bool, CoreDataError> {
        return memoCoreDatarepository.editMemo(newStateMemo)
    }
    
    func searchMemos(keyword: String, memoList: [Memo]) -> [Memo] {
        return memoList.filter { $0.title.contains(keyword) || $0.content?.contains(keyword) ?? false }
    }
    
}
