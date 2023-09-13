//
//  AuthenticationViewModel.swift
//  SocialApp
//
//  Created by 박경호 on 2023/09/10.
//

import UIKit

protocol FormViewModel {
    func updateForm() 
}

protocol AuthenticationViewModel {
    var formIsValid: Bool { get }
    var buttonBackgroundColor: UIColor { get }
    var buttonTitleColor : UIColor { get }
}

struct LoginViewModel : AuthenticationViewModel {
    var email : String?
    var password : String?
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    var buttonBackgroundColor: UIColor {
        return formIsValid ? #colorLiteral(red: 0.9872437119, green: 0.512082994, blue: 0.997698009, alpha: 1) : #colorLiteral(red: 0.5937161446, green: 0.1135662571, blue: 0.9941397309, alpha: 1).withAlphaComponent(0.5)
    }
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.7)
    }
}

struct RegisterViewModel : AuthenticationViewModel {
    var email : String?
    var password : String?
    var fullname : String?
    var username : String?
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false && fullname?.isEmpty == false && username?.isEmpty == false
    }
    var buttonBackgroundColor: UIColor {
        return formIsValid ? #colorLiteral(red: 0.9872437119, green: 0.512082994, blue: 0.997698009, alpha: 1) : #colorLiteral(red: 0.5937161446, green: 0.1135662571, blue: 0.9941397309, alpha: 1).withAlphaComponent(0.5)
    }
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.7)
    }
}

struct ResetPasswordViewModel: AuthenticationViewModel {
    var email : String?
    var formIsValid: Bool { return email?.isEmpty == false }
    
    var buttonBackgroundColor: UIColor {
        formIsValid ? #colorLiteral(red: 0.9872437119, green: 0.512082994, blue: 0.997698009, alpha: 1) : #colorLiteral(red: 0.5937161446, green: 0.1135662571, blue: 0.9941397309, alpha: 1).withAlphaComponent(0.5)
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.7)
    }
    
}
