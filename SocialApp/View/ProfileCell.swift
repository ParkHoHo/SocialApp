//
//  ProfileCell.swift
//  SocialApp
//
//  Created by 박경호 on 2023/09/12.
//

import UIKit

class ProfileCell : UICollectionViewCell {
    
    //MARK: - Properties
    private let postImageView : UIImageView = {
        let pl = UIImageView()
        pl.image = #imageLiteral(resourceName: "boston-feat")
        pl.contentMode = .scaleAspectFill
        pl.clipsToBounds = true
        return pl
    }()
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        addSubview(postImageView)
        postImageView.fillSuperView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
