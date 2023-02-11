//
//  AuthService.swift
//  Ios_version3
//
//  Created by taichi endo on 2/11/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

import FirebaseCore



class AuthService {
    
    public static let shared = AuthService()
    private init() {}
    
    
    
    
    public func registerUser(with userRequest: RegisterUserRequest, completion:
        @escaping (Bool, Error?)->Void){
        
        let username = userRequest.username
        let email = userRequest.email
        let password = userRequest.password
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let resultUser = result?.user else {
                completion(false, nil)
                return
            }
            
            let db = Firestore.firestore()
            
            db.collection("users")
                .document(resultUser.uid)
                .setData([
                    "username": username,
                    "email": email
                ]) { error in
                    if let error = error {
                        completion(false, error)
                        return
                    }
                    
                    completion(true, nil)
                }
            
                
        }
    }
}





