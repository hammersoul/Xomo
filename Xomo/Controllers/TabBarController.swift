//
//  MainTabBarController.swift
//  Xomo
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.selectedViewController = self.viewControllers![4]
    }
    
    // MARK: Configure TabBarController
    
    private func configure() {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20)
        
        let currenciesController = CurrenciesViewController()
        let newsController = NewsViewController()
        let homeController = HomeViewController()
        let favoritesController = FavoritesViewController()
        let profileController = ProfileViewController()
        
        let currenciesNavigation = NavigationController(rootViewController: currenciesController)
        let newsNavigation = NavigationController(rootViewController: newsController)
        let homeNavigation = NavigationController(rootViewController: homeController)
        let favoritesNavigation = NavigationController(rootViewController: favoritesController)
        let profileNavigation = NavigationController(rootViewController: profileController)
        
        currenciesNavigation.tabBarItem = UITabBarItem(title: Resources.MenuTitle.currencies, image: UIImage(systemName: "bitcoinsign.circle.fill", withConfiguration: largeConfig), tag: 0)
        newsNavigation.tabBarItem = UITabBarItem(title: Resources.MenuTitle.news, image: UIImage(systemName: "doc.plaintext.fill", withConfiguration: largeConfig), tag: 0)
        homeNavigation.tabBarItem = UITabBarItem(title: Resources.MenuTitle.home, image: UIImage(systemName: "location.fill", withConfiguration: largeConfig), tag: 0)
        favoritesNavigation.tabBarItem = UITabBarItem(title: Resources.MenuTitle.favorites, image: UIImage(systemName: "bookmark.fill", withConfiguration: largeConfig), tag: 0)
        profileNavigation.tabBarItem = UITabBarItem(title: Resources.MenuTitle.profile, image: UIImage(systemName: "person.fill", withConfiguration: largeConfig), tag: 0)
        
        setViewControllers([
            currenciesNavigation,
            newsNavigation,
            homeNavigation,
            favoritesNavigation,
            profileNavigation
        ], animated: false)
    }
    
    // MARK: Appearance TabBarController
    
    private func appearanceTabBarController() {
        let width = tabBar.bounds.width
        let height = tabBar.bounds.height + 40
        let roundLayer = CAShapeLayer()
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: 0, y: tabBar.bounds.minY - 10, width: width, height: height), cornerRadius: 10)
        
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemPositioning = .centered
        
        if self.traitCollection.userInterfaceStyle == .dark {
            roundLayer.fillColor = UIColor.mainColor.cgColor
        } else {
            roundLayer.fillColor = UIColor.white.cgColor
        }
        
        tabBar.unselectedItemTintColor = .tabBarItemLight
    }
    
    // MARK: Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        configure()
        appearanceTabBarController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
