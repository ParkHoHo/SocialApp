//
//  ProfileHeader.swift
//  SocialApp
//
//  Created by 박경호 on 2023/09/12.
//

import UIKit
import Firebase

class ProfileHeader : UICollectionReusableView {
    
    //MARK: - Properties
    private let profileImageView : UIImageView = {
        let pl = UIImageView()
        pl.image =  #imageLiteral(resourceName: "boston-feat")
        pl.contentMode = .scaleAspectFill
        pl.clipsToBounds = true
        return pl
    }()
    
    private let usernameLabel : UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 12)
        lb.text = Auth.auth().currentUser?.email
        lb.textColor = .black
        return lb
    }()
    
    private let profileEditButton : UIButton = {
        let bt = UIButton()
        bt.setTitle("프로필 편집", for: .normal)
        bt.setTitleColor(.black, for: .normal)
        bt.layer.borderWidth = 2
        bt.layer.borderColor = UIColor.lightGray.cgColor
        bt.layer.cornerRadius = 5
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        bt.addTarget(self, action: #selector(didTappedEditButton), for: .touchUpInside)
        return bt
    }()
    
    private lazy var postLabel : UILabel = {
        let pl = UILabel()
        pl.numberOfLines = 0
        pl.textAlignment = .center
        pl.attributedText = attributedText(value: 5, label: "게시물")
        return pl
    }()
    
    private lazy var FollowerLabel : UILabel = {
        let pl = UILabel()
        pl.numberOfLines = 0
        pl.textAlignment = .center
        pl.attributedText = attributedText(value: 39, label: "팔로워")
        return pl
    }()
    
    private lazy var FollowingLabel : UILabel = {
        let pl = UILabel()
        pl.numberOfLines = 0
        pl.textAlignment = .center
        pl.attributedText = attributedText(value: 14, label: "팔로잉")
        return pl
    }()
    
    
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor,left: leftAnchor,paddingTop: 13,paddingLeft: 13)
        profileImageView.setDimension(height: 70, width: 70)
        profileImageView.layer.cornerRadius = 70 / 2
        
        addSubview(usernameLabel)
        usernameLabel.anchor(top: profileImageView.bottomAnchor,left: leftAnchor,paddingTop: 12,paddingLeft: 12)
        
        addSubview(profileEditButton)
        profileEditButton.anchor(top: usernameLabel.bottomAnchor,left: leftAnchor,right: rightAnchor,paddingTop: 15,paddingLeft: 15,paddingRight: 24)
        
        let stackView = UIStackView(arrangedSubviews: [postLabel,FollowerLabel,FollowingLabel])
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.centerY(inview: profileImageView)
        stackView.anchor(left: profileImageView.rightAnchor,right: rightAnchor,paddingLeft: 13,paddingRight: 13,height: 50)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    @objc func didTappedEditButton() {
        print("DEBUG: Edit Button is Tapped.")
        
    }
    
    //MARK: - Helpers
    func attributedText(value : Int, label : String) -> NSAttributedString {
        let attr = NSMutableAttributedString(string: "\(value)\n ",attributes: [.font:UIFont.boldSystemFont(ofSize: 13),.foregroundColor : UIColor.black])
        
        attr.append(NSMutableAttributedString(string: label,attributes: [.font:UIFont.systemFont(ofSize: 14),.foregroundColor:UIColor.gray]))
        
        return attr
        
    }
}

