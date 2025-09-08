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
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var memoCoreData: MemoCoreDataProtocol = MemoCoreData()
    lazy var memoViewModel: MemoUseCaseProtocol = MemoViewModel(memoCoreData: memoCoreData)
    private let memoView = MemoListView()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        self.view = memoView
        self.memoView.previewTableView.delegate = self
        self.memoView.previewTableView.dataSource = self
        
        let _  = memoViewModel.fetchMemos()
        memoView.setViewModel(memoViewModel)
        memoViewModel.listPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] list in
                self?.memoView.previewTableView.reloadData()
            }
            .store(in: &cancellables)
        memoView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func addButtonTapped() {
        let vc = MemoViewController(viewModel: memoViewModel, mode: .add)
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }

}

extension MemoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoViewModel.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = memoView.previewTableView.dequeueReusableCell(withIdentifier: MemoPreviewCell.reuseIdentifier) as! MemoPreviewCell
        cell.configure(with: memoViewModel.list[indexPath.row], delegate: self)
        return cell
    }
    
}

extension MemoListViewController: MemoPreviewCellDelegate {
    
    func likedPressed(_ memo: Memo) {
        memoViewModel.toggleLike(id: memo.id)
    }
    
}
