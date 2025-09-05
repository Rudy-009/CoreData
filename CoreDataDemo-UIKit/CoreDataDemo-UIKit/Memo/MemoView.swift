//
//  MemoView.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 9/5/25.
//

import UIKit
import Combine

class MemoView: UIView {
    
    lazy var memoViewModel: MemoModelProtocol = MemoViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    public lazy var previewTableView: UITableView = {
        let table = UITableView()
        table.register(MemoPreviewCell.self, forCellReuseIdentifier: MemoPreviewCell.reuseIdentifier)
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubview(previewTableView)
        previewTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            previewTableView.topAnchor.constraint(equalTo: self.topAnchor),
            previewTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            previewTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            previewTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
