//
//  LoginViewController.swift
//  MimoiOSCodingChallenge
//
//  Created by Charles Burnett on 5/31/17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func signup(_ sender: Any) {
        view.endEditing(true)

        if let email = emailField.text, !email.isEmpty, let password = passwordField.text, !password.isEmpty {
        
        
        let json: [String: String] =
            
            ["email": email,
             "client_id": "PAn11swGbMAVXVDbSCpnITx5Utsxz1co",
             "password": password,
             "connection": "Username-Password-Authentication"]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        let url = URL(string: "https://mimo-test.auth0.com/dbconnections/signup")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                if let error = responseJSON["error"] {
                    print("Signup failed: reason - \(error)")
                }
                else{
                    let svc = SettingsViewController()
                    self.present(svc, animated: true, completion: nil)
                }
            }
        }
        
        task.resume()
        }
        
        else {
            print("invalid auth")
        }
    }
    
    @IBAction func login(_ sender: Any) {
        
        view.endEditing(true)

        if let email = emailField.text, !email.isEmpty, let password = passwordField.text, !password.isEmpty {
            
            
            let json: [String: String] =
                
            ["client_id": "PAn11swGbMAVXVDbSCpnITx5Utsxz1co",
            "username": email,
            "password": password,
            "connection": "Username-Password-Authentication"]
            
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            
            // create post request
            let url = URL(string: "https://mimo-test.auth0.com/oauth/ro")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // insert json data to the request
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    if let error = responseJSON["error"] {
                        print("Login failed: reason - \(error)")
                    }
                    else{
                        let svc = SettingsViewController()
                        svc.emailText = email;
                        self.present(svc, animated: true, completion: nil)
                    }
                }
            }
            
            task.resume()
        }
        
        else {
            print("invalid auth")
        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
