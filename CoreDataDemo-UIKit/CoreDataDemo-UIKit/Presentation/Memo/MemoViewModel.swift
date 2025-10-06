//
//  MemoViewModel.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 9/5/25.
//

import Combine
import Foundation

final class MemoViewModel: ObservableObject {
    
    private var useCase: MemoUseCaseProtocol
    
    init(useCase: MemoUseCaseProtocol) {
        self.useCase = useCase
    }
    
}
