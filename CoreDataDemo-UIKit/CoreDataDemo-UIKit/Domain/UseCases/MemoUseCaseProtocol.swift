//
//  MemoModelProtocol.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 9/5/25.
//

import Foundation
import Combine

public protocol MemoUseCaseProtocol {
    
    func addMemo(title: String, content: String) -> Result<Bool, CoreDataError>
    
    func editMemo(memo: Memo) -> Result<Bool, CoreDataError>
    
    func deleteMemo(memo: Memo) -> Result<Bool, CoreDataError>
    
    func fetchMemos() -> Result<[Memo], CoreDataError>
    
    func toggleLike(memo: Memo) -> Result<Bool, CoreDataError>
    
    func searchMemos(keyword: String, memoList: [Memo]) -> [Memo]
}
