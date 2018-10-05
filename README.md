# Twitter-SDK
Login with Twitter authentication
### Code Example
```Swift

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
