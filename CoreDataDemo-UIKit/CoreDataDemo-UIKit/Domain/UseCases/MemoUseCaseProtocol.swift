//
//  MemoModelProtocol.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 9/5/25.
//

import Foundation
import Combine

public protocol MemoUseCaseProtocol {
    
    func addMemo(title: String, content: String)
    
    func editMemo(memo: Memo)
    
    func deleteMemo(memo: Memo)
    
    func fetchMemos() -> [Memo]?
    
    func toggleLike(memo: Memo)
    
    func searchMemos(keyword: String, memoList: [Memo]) -> [Memo]
}
