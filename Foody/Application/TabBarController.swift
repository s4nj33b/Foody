//
//  TabBarController.swift
//  Foody
//
//  Created by Sanjeeb on 14/04/21.
//

import UIKit

class TabBarController: UITabBarController {
    var rootNav: UINavigationController = UINavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootNav.navigationBar.isHidden = true
        
        tabBar.barTintColor = .white
        tabBar.isTranslucent = false
        tabBar.unselectedItemTintColor = UIColor(red: 0.18, green: 0.21, blue: 0.56, alpha: 1.00)
        tabBar.tintColor = UIColor(red: 0.95, green: 0.13, blue: 0.47, alpha: 1.00)
        tabBar.backgroundImage = UIImage(named: "tabBg")
        tabBar.shadowImage = UIImage(named: "tabShadow")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let firstItem = tabBar.items!.first!
        tabBar(tabBar, didSelect: firstItem)
        //CacheManager.shared.clearMemoryCache()
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
//        if item.tag == 2 {
//            let scanVC = ScanViewController()
//            scanVC.modalPresentationStyle = .overFullScreen
//            present(scanVC, animated: true) { [weak self] in
//                self?.selectedIndex = 1
//            }
//        }
    }
    

}
