//
//  MainTabBarController.swift
//  Xomo
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        generateTabBar()
        setTabBarAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.selectedViewController = self.viewControllers![2]
    }
    
    private func generateTabBar() {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20)
        
        viewControllers = [
            generateVC(viewController: CurrenciesViewController(), title: "Валюты", image: UIImage(systemName: "personalhotspot.circle.fill", withConfiguration: largeConfig)),
            generateVC(viewController: NewsViewController(), title: "Новости", image: UIImage(systemName: "doc.plaintext.fill", withConfiguration: largeConfig)),
            generateVC(viewController: HomeViewController(), title: "Обменники", image: UIImage(systemName: "location.fill", withConfiguration: largeConfig)),
            generateVC(viewController: FavoritesViewController(), title: "Сохранено", image: UIImage(systemName: "bookmark.fill", withConfiguration: largeConfig)),
            generateVC(viewController: MenuViewController(), title: "Профиль", image: UIImage(systemName: "person.fill", withConfiguration: largeConfig))
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        
        return viewController
    }
    
    private func setTabBarAppearance() {
        let width = tabBar.bounds.width
        let height = tabBar.bounds.height + 40
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: 0, y: tabBar.bounds.minY - 10, width: width, height: height), cornerRadius: 10)
        
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.mainColor.cgColor
        tabBar.tintColor = .tabBarItemAccent
        tabBar.unselectedItemTintColor = .tabBarItemLight
    }
}
