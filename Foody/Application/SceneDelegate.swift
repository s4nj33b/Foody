//
//  SceneDelegate.swift
//  Foody
//
//  Created by Sanjeeb on 13/04/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private var homeVC: HomeViewController {
        let vc = HomeViewController()
        let tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(named: "home"),
            selectedImage: UIImage(named: "home")
        )
        tabBarItem.tag = 0
        vc.tabBarItem = tabBarItem
        return vc
    }
    
    private var searchVC: SearchViewController {
        let vc = SearchViewController()
        let tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(named: "search"),
            selectedImage: UIImage(named: "search")
        )
        tabBarItem.tag = 1
        vc.tabBarItem = tabBarItem
        return vc
    }
    
    private var scanVC: ScanViewController {
        let vc = ScanViewController()
        let tabBarItem = UITabBarItem(
            title: "Scan QR",
            image: UIImage(systemName: "plus.rectangle.fill"),
            selectedImage: UIImage(systemName: "plus.rectangle.fill")
        )
        tabBarItem.tag = 2
        vc.tabBarItem = tabBarItem
        return vc
    }
    
    private var rewardsVC: RewardsViewController {
        let vc = RewardsViewController()
        let tabBarItem = UITabBarItem(
            title: "Rewards",
            image: UIImage(named: "gift"),
            selectedImage: UIImage(named: "gift")
        )
        tabBarItem.tag = 3
        vc.tabBarItem = tabBarItem
        return vc
    }
    
    private var profileVC: AccountViewController {
        let vc = AccountViewController()
        let tabBarItem = UITabBarItem(
            title: "Account",
            image: UIImage(named: "account"),
            selectedImage: UIImage(named: "account")
        )
        tabBarItem.tag = 4
        vc.tabBarItem = tabBarItem
        return vc
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let tabBarController = TabBarController()
        tabBarController.viewControllers = [homeVC, searchVC, scanVC, rewardsVC, profileVC]
        
        let nav = UINavigationController(rootViewController: tabBarController)
        nav.navigationBar.isHidden = true
       
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = nav
    
        self.window = window
        window.makeKeyAndVisible()
    }

    /*
     func sceneDidDisconnect(_ scene: UIScene) {
         // Called as the scene is being released by the system.
         // This occurs shortly after the scene enters the background, or when its session is discarded.
         // Release any resources associated with this scene that can be re-created the next time the scene connects.
         // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
     }

     func sceneDidBecomeActive(_ scene: UIScene) {
         // Called when the scene has moved from an inactive state to an active state.
         // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
     }

     func sceneWillResignActive(_ scene: UIScene) {
         // Called when the scene will move from an active state to an inactive state.
         // This may occur due to temporary interruptions (ex. an incoming phone call).
     }

     func sceneWillEnterForeground(_ scene: UIScene) {
         // Called as the scene transitions from the background to the foreground.
         // Use this method to undo the changes made on entering the background.
     }

     func sceneDidEnterBackground(_ scene: UIScene) {
         // Called as the scene transitions from the foreground to the background.
         // Use this method to save data, release shared resources, and store enough scene-specific state information
         // to restore the scene back to its current state.
     }

     */
    

}

