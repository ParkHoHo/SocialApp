//
//  MainTabBarController.swift
//  SocialApp
//
//  Created by 박경호 on 2023/09/02.
//

import UIKit
import Firebase

class MainTabBarController : UITabBarController {
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        configureViewController()
        checkIfUserLogin()
//        logout()
        
    }
    
    //MARK: - API
    func checkIfUserLogin(){
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginViewController()
                let navigation = UINavigationController(rootViewController: controller)
                navigation.modalPresentationStyle = .fullScreen
                self.present(navigation, animated: true,completion: nil)
                
            }
        }
    }
    
    func logout(){
        do {
            try Auth.auth().signOut()
        } catch {
            print("DEBUG: Failed log out!")
        }
        
    }
    
    
    //MARK: - Helpers
    func configureViewController() {
        view.backgroundColor = .white
        
        tabBar.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        
        // #imageLiteral() <- 팝업으로 이미지를 넣을 수 있음.
        let feed = tabBarNavigationController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedController(collectionViewLayout: layout))
        
        let notification = tabBarNavigationController(unselectedImage: #imageLiteral(resourceName: "love"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationController())
        
        let image = tabBarNavigationController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "add2"), rootViewController: ImageSelectorController())
        
        let search = tabBarNavigationController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchController())
        
        let ProfileLayout = UICollectionViewFlowLayout()
        let profile = tabBarNavigationController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: ProfileController(collectionViewLayout: ProfileLayout))
        
        viewControllers = [feed,notification,image,search,profile]
    }
    
    func tabBarNavigationController(unselectedImage : UIImage, selectedImage : UIImage,rootViewController : UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .black
        
        return nav
    }
}
