//
//  MainTabBarController.swift
//  Xomo
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: Configure TabBarController
    
    private func configure() {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 18)
        
        let newsNavigation = NavigationController(rootViewController: NewsViewController())
        let currenciesNavigation = NavigationController(rootViewController: CurrenciesViewController())
        let homeNavigation = NavigationController(rootViewController: HomeViewController())
        let historyNavigation = NavigationController(rootViewController: HistoryViewController())
        let profileNavigation = NavigationController(rootViewController: ProfileViewController())
        
        newsNavigation.tabBarItem = UITabBarItem(title: Resources.MenuTitle.news, image: UIImage(systemName: "doc.plaintext.fill", withConfiguration: largeConfig), tag: 0)
        currenciesNavigation.tabBarItem = UITabBarItem(title: Resources.MenuTitle.currencies, image: UIImage(systemName: "bitcoinsign.circle.fill", withConfiguration: largeConfig), tag: 0)
        homeNavigation.tabBarItem = UITabBarItem(title: Resources.MenuTitle.home, image: UIImage(systemName: "arrow.left.arrow.right", withConfiguration: largeConfig), tag: 0)
        historyNavigation.tabBarItem = UITabBarItem(title: Resources.MenuTitle.history, image: UIImage(systemName: "clock.fill", withConfiguration: largeConfig), tag: 0)
        profileNavigation.tabBarItem = UITabBarItem(title: Resources.MenuTitle.profile, image: UIImage(systemName: "person.fill", withConfiguration: largeConfig), tag: 0)
        
        setViewControllers([newsNavigation, currenciesNavigation, homeNavigation, historyNavigation, profileNavigation], animated: false)
        
        selectedViewController = viewControllers![2]
    }
    
    // MARK: Appearance TabBarController
    
    private func appearanceTabBarController() {
        tabBar.backgroundColor = .secondarySystemBackground
        tabBar.unselectedItemTintColor = Resources.tabBarItemLight
        tabBar.itemPositioning = .automatic
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
