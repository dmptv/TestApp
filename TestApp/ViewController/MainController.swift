//
//  MainController.swift
//  TestApp
//
//  Created by 123 on 12.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit
import VK_ios_sdk
import SDWebImage

class MainController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let imageView = UIImageView()
    var userLabel: UILabel!
    
    let service: Service = Service()
    var user: Friend!
    var friends: [Friend] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        let instance = VKSdk.initialize(withAppId: App.String.VKAppId)
        instance?.register(self)
        instance?.uiDelegate = self

        requests()
    }
    
    fileprivate func setupViews() {
        setupNavBar()
        setupTableView()
        setupHeaderImageView()
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(logOut))
        navigationController?.hidesBarsOnSwipe = true
    }
    
    private func setupTableView() {
        tableView.estimatedRowHeight = 83
        tableView.contentInset = UIEdgeInsets(top: 300, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = UIColor.darkGray
    }
    
    private func setupHeaderImageView() {
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 300)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        userLabel = UILabel(frame: CGRect(x: imageView.frame.minX + 20, y: imageView.frame.maxY - 12, width: imageView.bounds.size.width, height: 30))
        userLabel.textColor = UIColor.white
        imageView.addSubview(userLabel)
        if let user = user {
            imageView.sd_setImage(with: user.photo200Url, completed: nil)
            userLabel.text = user.firstName + " " + user.lastName
        } else {
            imageView.image = UIImage.init(named: "dummy")
            userLabel.text = ""
        }
    }
    
    func requests() {
        service.getData { [weak self] result in
            if let user = result, let strongSelf = self {
                strongSelf.user = user
                DispatchQueue.main.async {
                    strongSelf.imageView.sd_setImage(with: user.photo200Url, completed: nil)
                    strongSelf.userLabel.text = user.firstName + " " + user.lastName
                }
            }
        }
        
        service.getFriends { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.friends = result as! [Friend]
            strongSelf.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

    }
    
    @objc func logOut() {
        print("logged out")
        
        defaults.set(false, forKey: "UserIsLoggedIn")
        
        VKSdk.forceLogout()
        
        let loginStoryboard = UIStoryboard.storyboard(.login)
        let loginController: LoginController = loginStoryboard.instantiateViewController()
        
        present(loginController, animated: true, completion: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
}

extension MainController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.defaultReuseIdentifier, for: indexPath) as! CustomTableViewCell
        
        let friend = friends[indexPath.row]
        
        cell.contentView.backgroundColor = UIColor.black
        cell.titleLabel.text = friend.firstName + " " + friend.lastName
        cell.titleLabel.textColor = .white
        
        cell.userImageView.alpha = 0
        cell.userImageView.sd_setImage(with: friend.photoUrl, completed: { (image, error, cache, url) in
            cell.userImageView.image = image
            UIView.animate(withDuration: 0.2, animations: {
                cell.userImageView.alpha = 1.0
            })
        })
        
        if indexPath.row == 5 {
            tableView.layoutIfNeeded()
        }
        
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 300 - (scrollView.contentOffset.y + 300)
        let height = min(max(y, 60), 400)
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
    }
    
}

extension MainController: VKSdkDelegate, VKSdkUIDelegate {
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print("vkSdkShould Present")
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print("vkSdkAccessAuthorization Finished")
    }
    
    func vkSdkUserAuthorizationFailed() {
        print("vkSdkUserAuthorization Failed")
    }
    
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print("captcha Error", captchaError)
    }
    
    
}
