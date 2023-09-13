//
//  ProfileCell.swift
//  SocialApp
//
//  Created by 박경호 on 2023/09/12.
//

import UIKit

class ProfileCell : UICollectionViewCell {
    
    //MARK: - Properties
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
