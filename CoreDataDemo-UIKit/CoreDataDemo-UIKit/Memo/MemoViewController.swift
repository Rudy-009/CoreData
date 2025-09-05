//
//  MemoViewController.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 9/5/25.
//

import UIKit
import Combine

class MemoViewController: UIViewController {
    
    private let memoView = MemoView()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        self.view = memoView
        self.memoView.previewTableView.delegate = self
        self.memoView.previewTableView.dataSource = self
        
        memoView.memoViewModel.listPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] list in
                self?.memoView.previewTableView.reloadData()
            }
            .store(in: &cancellables)
    }

}

extension MemoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoView.memoViewModel.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = memoView.previewTableView.dequeueReusableCell(withIdentifier: MemoPreviewCell.reuseIdentifier) as! MemoPreviewCell
        cell.configure(with: memoView.memoViewModel.list[indexPath.row])
        return cell
    }
    
}
