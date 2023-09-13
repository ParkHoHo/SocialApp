//
//  AuthService.swift
//  SocialApp
//
//  Created by 박경호 on 2023/09/11.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password : String
    let fullname : String
    let username : String
    let profileImage : UIImage
}

struct AuthService {
    static func logUserIn(withEmail email:String,password: String,completion : @escaping(AuthDataResult?,Error?)->Void) {
        Auth.auth().signIn(withEmail: email, password: password,completion: completion)
    }
    
    static func registerUser(withCredential credential: AuthCredentials,completion: @escaping(Error?)-> Void) {
        ImageUploader.upLoadImage(image: credential.profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: credential.email, password: credential.password) { result, error in
                if let error = error {
                    print("DEBUG: Failed to register user \(error.localizedDescription)")
                    return
                }
                
                guard let uid = result?.user.uid else { return }
                
                var data : [String: Any] = ["email":credential.email,
                                            "fullname":credential.fullname,
                                            "profile":imageUrl,
                                            "uid":uid,
                                            "username":credential.username]
                
                Firestore.firestore().collection("Users").document(uid).setData(data,completion: completion)
            }
        }
    }
}
