//
//  MemoViewController.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 9/5/25.
//

import UIKit
import Combine
import CoreData

class MemoListViewController: UIViewController {
    
    var memoViewModel: MemoViewModelProtocol
    private let memoView = MemoListView()
    private var cancellables: Set<AnyCancellable> = []
    
    init(memoViewModel: MemoViewModelProtocol) {
        self.memoViewModel = memoViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view = memoView
        
    }
    
    @objc
    private func addButtonTapped() {
        
    }

}
