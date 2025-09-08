//
//  MemoModelProtocol.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 9/5/25.
//

import Foundation
import Combine

public protocol MemoUseCaseProtocol {
    
    var listPublisher: AnyPublisher<[Memo], Never> { get }
    var list: [Memo] { get }
    
    func addMemo(title: String, content: String)
    
    func editMemo(id: UUID, title: String?, content: String?)
    
    func deleteMemo(id: UUID)
    
    func fetchMemos() -> [Memo]?
    
    func toggleLike(id: UUID)
    
    func searchMemos(keyword: String) -> [Memo]
}
