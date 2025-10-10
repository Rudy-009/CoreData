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
    
    var memoViewModel: MemoViewModel
    private let memoListView = MemoListView()
    private let input: PassthroughSubject<MemoViewModel.Input, Never> = .init()
    private var cancellables: Set<AnyCancellable> = []
    
    init(memoViewModel: MemoViewModel) {
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
        memoListView.previewTableView.dataSource = self
        memoListView.previewTableView.delegate = self
        memoListView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func addButtonTapped() {
        input.send(.addMemoButtonTapped)
    }
    
    func bind() {
        let output = memoViewModel.transform(input: input.eraseToAnyPublisher())
        output
        .receive(on: DispatchQueue.main)
        .sink { [weak self] event in
            guard let self else { return }
            switch event {
            case .showAddMemoViewController :
                self.navigationController?.pushViewController (MemoViewController(viewModel: self.memoViewModel, mode: .add) , animated: true)
            case .showEditMemoViewController(let memo) :
                self.navigationController?.pushViewController(MemoViewController(viewModel: self.memoViewModel, mode: .edit(memo: memo)) , animated: true)
            default :
                // memoListView.previewTableView.reloadData()
                break
            }
        }
        .store(in: &cancellables)
        
        memoViewModel.$memoList
        .receive(on: DispatchQueue.main)
        .sink { [weak self] _ in
            guard let self else { return }
            self.memoListView.previewTableView.reloadData()
        }
        .store(in: &cancellables)
    }

}

extension MemoListViewController: UITableViewDelegate, UITableViewDataSource, MemoPreviewCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoViewModel.memoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemoPreviewCell.reuseIdentifier, for: indexPath) as! MemoPreviewCell
        cell.configure(with: memoViewModel.memoList[indexPath.row], delegate: self)
        return cell
    }
    
    func likedPressed(_ memo: Memo) {
        self.input.send(.likeMemo(Memo.likedMemo(memo: memo)))
    }
    
}
