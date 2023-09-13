//
//  FeedController.swift
//  SocialApp
//
//  Created by 박경호 on 2023/09/02.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"
class FeedController : UICollectionViewController {
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    //MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .yellow
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }
    
    //MARK: - Actions
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
            let controller = LoginViewController()
            let navigation = UINavigationController(rootViewController: controller)
            navigation.modalPresentationStyle = .fullScreen
            self.present(navigation, animated: true,completion: nil)
        } catch {
            print("DEBUG: failed to sign out")
        }
    }
    
}



//MARK: - UICollectionView DataSource
extension FeedController  {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        
        return cell
    }
}

extension FeedController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 50
        height += 60
        
        
        
        return CGSize(width: width, height: height)
    }
}
