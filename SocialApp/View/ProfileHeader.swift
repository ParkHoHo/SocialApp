//
//  ProfileHeader.swift
//  SocialApp
//
//  Created by 박경호 on 2023/09/12.
//

import UIKit

class ProfileHeader : UICollectionReusableView {
    
    //MARK: - Properties
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .magenta
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

