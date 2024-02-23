//
//  TabBarController.swift
//  E-Commerce
//
//  Created by Fatih on 15.02.2024.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        self.tabBar.barTintColor = .bg
        self.tabBar.tintColor = .main
        self.tabBar.unselectedItemTintColor = .darkGray
        
    }
    
    private func setupTabs() {
        let home = self.createNav(title: "Home", image: .home, vc: HomeController())
        let basket = self.createNav(title: "Basket", image: .basket, vc: BasketController())
        let profile = self.createNav(title: "Profile", image: .person, vc: UserProfileController())
        let favorite = self.createNav(title: "Favorite", image: .favorite, vc: FavoriteController())
        let search = self.createNav(title: "Search", image: .search, vc: SearchController())
        self.setViewControllers([home, favorite, search, basket, profile], animated: true)
    }
    
    private func createNav(title: String, image: UIImage, vc: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
//        nav.viewControllers.first?.navigationItem.title = title + " Controller"
//        nav.viewControllers.first?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: nil, action: nil)
        
        
        return nav
    }

}
