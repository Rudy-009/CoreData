//
//  MemoView.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 9/5/25.
//

import UIKit
import Combine

class MemoView: UIView {
    
    var memoViewModel: MemoModelProtocol?
    private var cancellables: Set<AnyCancellable> = []
    
    public lazy var previewTableView: UITableView = {
        let table = UITableView()
        table.register(MemoPreviewCell.self, forCellReuseIdentifier: MemoPreviewCell.reuseIdentifier)
        return table
    }()
    
    public lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "square.and.pencil.circle"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubview(previewTableView)
        addSubview(addButton)
        previewTableView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            previewTableView.topAnchor.constraint(equalTo: self.topAnchor),
            previewTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            previewTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            previewTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            addButton.widthAnchor.constraint(equalToConstant: 50),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100),
            addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func addButtonTapped() {
        print("show add memo view")
    }
    
    func setViewModel(_ viewModel: MemoModelProtocol) {
        self.memoViewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
