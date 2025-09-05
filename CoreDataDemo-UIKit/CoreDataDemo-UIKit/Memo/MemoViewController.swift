//
//  MemoViewController.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 9/5/25.
//

import UIKit
import Combine

class MemoViewController: UIViewController {
    
    private let memoViewModel: MemoModelProtocol = MemoViewModel()
    private let memoView = MemoView()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        self.view = memoView
        self.memoView.previewTableView.delegate = self
        self.memoView.previewTableView.dataSource = self
        
        memoView.setViewModel(memoViewModel)
        memoViewModel.listPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] list in
                self?.memoView.previewTableView.reloadData()
            }
            .store(in: &cancellables)
    }

}

extension MemoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoViewModel.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = memoView.previewTableView.dequeueReusableCell(withIdentifier: MemoPreviewCell.reuseIdentifier) as! MemoPreviewCell
        cell.configure(with: memoViewModel.list[indexPath.row], delegate: self)
        return cell
    }
    
}

extension MemoViewController: MemoPreviewCellDelegate {
    
    func likedPressed(_ memo: Memo) {
        memoViewModel.toggleLike(id: memo.id)
    }
    
}
