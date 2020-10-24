//
//  ViewController.swift
//  SocialMediaLogin
//
//  Created by Akshansh Gusain on 24/10/20.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit

class ViewController: UIViewController, GIDSignInDelegate, LoginButtonDelegate{
   
    
    
   //Google Sign - Go to project->Info -> url and add this url scheme: com.googleusercontent.apps.326869503055-pntc4fjkbfgs551qhdhd3h7ufake5oaa
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.delegate = self
        
    
        //Check if the FB user is logged in
        if let token = AccessToken.current,!token.isExpired {
            let token = token.tokenString
            
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["field": "email,name"], tokenString: token, version: nil, httpMethod: .get)
            request.start(completionHandler: {connection, result, error in
                print("\(result)")
            })
        }else{
            //faceBook Button
            let loginButton = FBLoginButton()
            loginButton.center = view.center
            loginButton.delegate = self
            loginButton.permissions = ["public_profile", "email"]
            view.addSubview(loginButton)
        }
        
    }

    @IBAction func goggleSignIn(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    
    
    //GIDSignInDelegate - Delegate Method
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil{
            print("userId:  ->  ")
            print(user.userID!)
        }
    }
    
    
    //FaceBook Login - Delegate Methods
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["field": "email,name"], tokenString: token, version: nil, httpMethod: .get)
        request.start(completionHandler: {connection, result, error in
            print("\(result)")
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("User logged out")
    }
}

