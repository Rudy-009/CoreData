//
//  MemoViewModel.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 9/5/25.
//

import Combine
import Foundation

protocol MemoViewModelProtocol: AnyObject {
    
}

final class MemoViewModel: ObservableObject {
    
    private var useCase: MemoUseCaseProtocol
    
    @Published var memos: [Memo] = []
    
    init(useCase: MemoUseCaseProtocol) {
        self.useCase = useCase
        self.memos = useCase.fetchMemos() ?? []
    }
    
}
