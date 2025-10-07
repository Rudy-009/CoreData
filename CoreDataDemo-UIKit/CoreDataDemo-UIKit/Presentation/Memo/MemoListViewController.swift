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
    private let memoListView = MemoListView()
    private let input: PassthroughSubject<MemoViewModel.Input, Never> = .init()
    private var cancellables: Set<AnyCancellable> = []
    
    init(memoViewModel: MemoViewModelProtocol) {
        self.memoViewModel = memoViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
        self.view = memoListView
        self.bind()
        input.send(.fetchMemoList)
        memoListView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func addButtonTapped() {
        input.send(.addMemoButtonTapped)
    }
    
    func bind() {
        let output = memoViewModel.transform(input: input.eraseToAnyPublisher())
        output.receive(on: DispatchQueue.main)
        .sink { [weak self] event in
            guard let self else { return }
            switch event {
            case .showAddMemoViewController :
                self.navigationController?.pushViewController (MemoViewController(viewModel: self.memoViewModel, mode: .add) , animated: true)
            case .showEditMemoViewController(let memo) :
                self.navigationController?.pushViewController(MemoViewController(viewModel: self.memoViewModel, mode: .edit(memo: memo)) , animated: true)
            case .fetchMemoListSuccess(let memoList) :
                guard let cell = memoListView.previewTableView.dequeueReusableCell(withIdentifier: MemoPreviewCell.reuseIdentifier, for: IndexPath(row: 0, section: 0)) as? MemoPreviewCell else { return }
            default :
                memoListView.previewTableView.reloadData()
                break
            }
        }
        .store(in: &cancellables)
    }

}
