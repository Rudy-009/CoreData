//
//  MemoViewController.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 9/5/25.
//

import UIKit
import Combine

final class MemoViewController: UIViewController {
    private let memoView = MemoView()
    private let memoViewModel: MemoViewModelProtocol
    private let mode: MemoMode
    private var memo: Memo?
    
    private let input: PassthroughSubject<MemoViewModel.Input, Never> = .init()
    private var cancellables: Set<AnyCancellable> = []
    
    init(viewModel: MemoViewModelProtocol, mode: MemoMode) {
        self.memoViewModel = viewModel
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
        self.hideKeyboardWhenTappedAround()
        self.view.backgroundColor = .white
        self.bind()
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
            navigationItem.rightBarButtonItem = UIBarButtonItem( title: "저장", style: .done, target: self, action: #selector(savePressed)
            )
        case .edit:
            navigationItem.title = "메모 편집"
            navigationItem.rightBarButtonItem = UIBarButtonItem( title: "수정", style: .done, target: self, action: #selector(editPressed)
            )
        }
    }
    
    private func setupDataIfNeeded() {
        if case let .edit(memo) = mode {
            self.memo = memo
            memoView.titleTextField.text = memo.title
            memoView.contentTextView.text = memo.content
        }
    }
    
    @objc private func savePressed() {
        let title = memoView.titleTextField.text ?? ""
        let content = memoView.contentTextView.text ?? ""
        input.send(.addMemo(Memo(title: title, content: content)))
        dismiss(animated: true)
    }
    
    @objc private func editPressed() {
        if case let .edit(memo) = mode {
            let title = memoView.titleTextField.text ?? ""
            let content = memoView.contentTextView.text ?? ""
            self.memo?.edit(title: title, content: content)
            guard let newMemo = self.memo else { return }
            input.send(.eidtMemo(newMemo))
        }
        
        dismiss(animated: true)
    }
    
    func bind() {
        let output = memoViewModel.transform(input: input.eraseToAnyPublisher())
        output.receive(on: DispatchQueue.main)
            .sink { event in
            switch event {
            default :
                break
            }
        }
        .store(in: &cancellables)
    }
}
