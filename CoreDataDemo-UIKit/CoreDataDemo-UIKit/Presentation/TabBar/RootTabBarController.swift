//
//  RootTabBarController.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 9/5/25.
//

import UIKit

class RootTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        self.selectedIndex = 0
    }
        
    private let memoListVC: MemoListViewController
    
    init(memoListVC: MemoListViewController) {
        self.memoListVC = memoListVC
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTabs() {
        let memoVC = UINavigationController(rootViewController: memoListVC)
        memoVC.tabBarItem = UITabBarItem(
            title: "memo",
            image: UIImage(systemName: "square.and.pencil.circle"),
            selectedImage: UIImage(systemName: "square.and.pencil.circle.fill")
        )
        
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem = UITabBarItem(
            title: "profile",
            image: UIImage(systemName: "person.crop.circle"),
            selectedImage: UIImage(systemName: "person.crop.circle.fill")
        )
        
        // 탭에 넣기
        viewControllers = [memoVC, profileVC]
    }
}
