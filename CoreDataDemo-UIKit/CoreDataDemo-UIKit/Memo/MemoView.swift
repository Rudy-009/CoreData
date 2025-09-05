//
//  MemoView.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 9/5/25.
//

import UIKit

final class MemoView: UIView {

    // 제목 입력
    let titleTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "제목을 입력하세요"
        tf.borderStyle = .roundedRect
        return tf
    }()

    // 내용 입력
    let contentTextView: UITextView = {
        let tv = UITextView()
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.lightGray.cgColor
        tv.layer.cornerRadius = 8
        tv.font = UIFont.systemFont(ofSize: 16)
        return tv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        addSubview(titleTextField)
        addSubview(contentTextView)

        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        contentTextView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleTextField.heightAnchor.constraint(equalToConstant: 44),

            contentTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 12),
            contentTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            contentTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
