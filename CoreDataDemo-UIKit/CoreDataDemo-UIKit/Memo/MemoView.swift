//
//  MemoView.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 9/5/25.
//

import UIKit
import Combine

class MemoView: UIView {
    
    private lazy var memoViewModel: MemoModelProtocol = MemoViewModel()
    
    public lazy var previewTableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    override init(frame: CGRect) {
        previewTableView.delegate = self
        previewTableView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MemoView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoViewModel.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
