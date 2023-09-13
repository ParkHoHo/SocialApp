//
//  ImageUploader.swift
//  SocialApp
//
//  Created by 박경호 on 2023/09/11.
//

import FirebaseStorage

struct ImageUploader {
    static func upLoadImage(image: UIImage,completion : @escaping(String)-> Void){
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        ref.putData(imageData,metadata: nil) { FIRStorage,error in
            if let erorr = error {
                print("DEBUG: Failed upload image \(error?.localizedDescription)")
                return
            }
            
            ref.downloadURL { URL, error in
                guard let imageUrl = URL?.absoluteString else { return }
                completion(imageUrl)
            }
        }
        
        
    }
}

