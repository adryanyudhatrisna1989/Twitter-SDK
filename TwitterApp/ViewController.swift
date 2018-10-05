//
//  ViewController.swift
//  TwitterApp
//
//  Created by Haditrisna on 10/4/18.
//  Copyright © 2018 YudhatrisnaProduction. All rights reserved.
//

import UIKit
import TwitterKit

class ViewController: UIViewController {
    
    @IBOutlet weak var photoImgView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func login(_ sender: Any) {
        TWTRTwitter.sharedInstance().logIn { (session, error) in
            if session != nil {
                if let userId = session?.userID {
                    let client = TWTRAPIClient(userID: userId)
                    client.loadUser(withID: userId, completion: { (user, error) in
                        if error == nil {
                            let name = user?.name
                            let username = user?.screenName
                            
                            self.usernameLabel.text = username
                            self.nameLabel.text = name
                            
                            guard let urlString = user?.profileImageLargeURL else {
                                return
                            }
                            guard let url = URL(string: urlString) else {
                                return
                            }
                            guard let data = try? Data(contentsOf: url) else {
                                return
                            }
                            let image = UIImage(data: data)
                            self.photoImgView.image = image
                        }
                    })
                }
            }
        }
    }
    
}

