//
//  FeedCell.swift
//  SocialApp
//
//  Created by 박경호 on 2023/09/04.
//

import UIKit

class FeedCell : UICollectionViewCell {
    
    //MARK: - Property
    
    private let profileImageView : UIImageView = {
       let pf = UIImageView()
        pf.contentMode = .scaleAspectFill
        pf.clipsToBounds = true
        pf.isUserInteractionEnabled = true
        // pf.backgroundColor = .black
        pf.image = #imageLiteral(resourceName: "boston-feat")
        return pf
    }()
    
    private lazy var userName : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ryan", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.isEnabled = true
        button.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        return button
    }()
    
    private let feedImage : UIImageView = {
       let fd = UIImageView()
        fd.contentMode = .scaleAspectFill
        fd.clipsToBounds = true
        fd.isUserInteractionEnabled = true
        
        fd.image = #imageLiteral(resourceName: "boston-feat")
        return fd
    }()
    
    private lazy var like : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "love"), for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    private lazy var caption : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "speech-bubble"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var shareButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "send"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        return button
    }()
    
    private let likesLabel : UILabel = {
        let label = UILabel()
        label.text = "7 likes"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .black
        
        return label
    }()
    
    private let captionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.text = "오늘 날씨가 참 좋아"
        label.textColor = .black
        return label
    }()
    
    private let timeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.text = "1 day ago"
        label.textColor = .black
        return label
    }()
    
    // var let vs lazy - 필요할 때만 가져오게 된다. 지연시키고 있다가 필요할 때 호출.
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(profileImageView)
        profileImageView.setDimension(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 40/2
        
        addSubview(userName)
        userName.centerY(inview: profileImageView,leftAnchor: profileImageView.rightAnchor,paddingLeft: 10)
        
        addSubview(feedImage)
        feedImage.anchor(top:profileImageView.bottomAnchor,left: leftAnchor,right: rightAnchor,paddingTop: 8 )
        
        feedImage.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        configureButtons()
        
        addSubview(likesLabel)
        likesLabel.anchor(top: like.bottomAnchor,left : leftAnchor,paddingTop: -4,paddingLeft: 8)
        addSubview(captionLabel)
        captionLabel.anchor(top: likesLabel.bottomAnchor,left: leftAnchor,paddingTop: 8,paddingLeft: 8)
        addSubview(timeLabel)
        timeLabel.anchor(top: captionLabel.bottomAnchor,left: leftAnchor,paddingTop: 8,paddingLeft: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    @objc func tappedButton() {
        // 해당 유저의 피드로 이동하게 될 것!
        
        print("DEBUG: User Touched button!!")
    }
    
    @objc func shareTapped() {
        print("DEBUG: User Touched button!!")
    }
    
    func configureButtons() {
        let stackView = UIStackView(arrangedSubviews: [like,caption,shareButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.anchor(top: feedImage.bottomAnchor,width: 100,height: 50)
    }
    
}
