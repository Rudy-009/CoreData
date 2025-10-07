//
//  MemoViewController.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 9/5/25.
//

import UIKit

final class MemoViewController: UIViewController {
    private let memoView = MemoView()
    private let viewModel: MemoViewModel
    private let mode: MemoMode
    
    init(viewModel: MemoViewModel, mode: MemoMode) {
        self.viewModel = viewModel
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = memoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupDataIfNeeded()
    }
    
    private func setupNavigation() {
        switch mode {
        case .add:
            navigationItem.title = "새 메모"
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "저장",
                style: .done,
                target: self,
                action: #selector(savePressed)
            )
        case .edit:
            navigationItem.title = "메모 편집"
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "수정",
                style: .done,
                target: self,
                action: #selector(editPressed)
            )
        }
    }
    
    private func setupDataIfNeeded() {
        if case let .edit(memo) = mode {
            memoView.titleTextField.text = memo.title
            memoView.contentTextView.text = memo.content
        }
    }
    
    @objc private func savePressed() {
        let title = memoView.titleTextField.text ?? ""
        let content = memoView.contentTextView.text ?? ""
        
        
        dismiss(animated: true)
    }
    
    @objc private func editPressed() {
        if case let .edit(memo) = mode {
            let title = memoView.titleTextField.text ?? ""
            let content = memoView.contentTextView.text ?? ""
            
            
        }
        dismiss(animated: true)
    }
}
