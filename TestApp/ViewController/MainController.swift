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
import Photos

class MainController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let imageView = UIImageView()
    var userLabel: UILabel!
    
    //TODO: - inject service
    let service: Service = Service()
    
    var user: Friend? {
        didSet {
            updateHeaderViews()
        }
    }
    
    var friends: [Friend] = []
    
    var indexPathToReload: IndexPath?
    
    func setupImage(user: Friend, imageView: UIImageView) {
        imageView.sd_setImage(with: user.photo200Url, completed: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        let instance = VKSdk.initialize(withAppId: App.String.VKAppId)
        instance?.register(self)
        instance?.uiDelegate = self

        requests()
    }
    
    
    //TODO: - abstarct views
    fileprivate func setupViews() {
        setupNavBar()
        setupTableView()
        setupHeaderImageView()
        setupRefreshControl()
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(logOut))
        navigationController?.hidesBarsOnSwipe = true
    }
    
    private func setupTableView() {
        tableView.estimatedRowHeight = CGFloat(App.Int.heightMainCell)
        tableView.contentInset = UIEdgeInsets(top: 300, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = UIColor.darkGray
        
        let cellNib = UINib(nibName: CustomTableViewCell.defaultReuseIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: CustomTableViewCell.defaultReuseIdentifier)
    }
    
    private func setupHeaderImageView() {
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 300)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        userLabel = UILabel(frame: CGRect(x: imageView.frame.minX + 20, y: imageView.frame.maxY - 12, width: imageView.bounds.size.width, height: 30))
        userLabel.textColor = UIColor.white
        imageView.addSubview(userLabel)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
    }
    
    @objc func handleTap() {
        //TODO: - move it to RxFlow
        let detailStoryboard = UIStoryboard.storyboard(.detail)
        let detailController: DetailController = detailStoryboard.instantiateViewController()
        detailController.user = user
        self.show(detailController, sender: self)
    }
    
    private func setupRefreshControl() {
        let refreshCtrl = UIRefreshControl()
        refreshCtrl.addTarget(self, action: #selector(updateFriends), for: .valueChanged)
        refreshCtrl.tintColor = UIColor.white
        tableView.refreshControl = refreshCtrl
        tableView.refreshControl?.bounds = CGRect(x: tableView.refreshControl!.bounds.origin.x, y: -50, width: tableView.refreshControl!.bounds.size.width, height: tableView.refreshControl!.bounds.size.height)
    }
    
    @objc func updateFriends() {
        if !tableView.refreshControl!.isRefreshing {
            tableView.refreshControl!.beginRefreshing()
        }
        
        service.getFriends { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.friends = result as! [Friend]
            strongSelf.tableView.reloadData()
            if strongSelf.tableView.refreshControl!.isRefreshing {
                strongSelf.tableView.refreshControl!.endRefreshing()
            }
        }
    }
    
    func requests() {
        service.getData { [weak self] result in
            if let user = result, let strongSelf = self {
                strongSelf.user = user
            }
        }
        updateFriends()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = indexPathToReload {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        updateHeaderViews()
    }
    
    private func updateHeaderViews() {
        if let user = user {
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                
                if let identifier = GlobalData.sharedInstance.dataRefenciesDict[user.id] {
                    let allPhotos = PHAsset.fetchAssets(withLocalIdentifiers: [identifier], options: PHFetchOptions.init())
                    
                    DispatchQueue.global(qos: .background).async {
                        allPhotos.enumerateObjects({ (asset, count, stop) in
                            let imageManager = PHImageManager.default()
                            let targetSize = CGSize(width: 200, height: 200)
                            let options = PHImageRequestOptions()
                            options.isSynchronous = true
                            imageManager.requestImage(for: asset,
                                                      targetSize: targetSize,
                                                      contentMode: .aspectFit,
                                                      options: options,
                                                      resultHandler:
                                { (image, info) in
                                    
                                    if let image = image {
                                        DispatchQueue.main.async {
                                            strongSelf.imageView.image = image
                                        }
                                    }
                            })
                            
                        })
                    }
                    
                    
                } else {
                    strongSelf.setupImage(user: user, imageView: strongSelf.imageView)
                }
                
                strongSelf.userLabel.text = user.firstName + " " + user.lastName
            }
        }
    }
    
    @objc func logOut() {
        print("logged out")
        defaults.set(false, forKey: "UserIsLoggedIn")
        VKSdk.forceLogout()
        let loginStoryboard = UIStoryboard.storyboard(.login)
        let loginController: LoginController = loginStoryboard.instantiateViewController()
        present(loginController, animated: true, completion: nil)
    }
    
}

extension MainController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(App.Int.heightMainCell)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.defaultReuseIdentifier, for: indexPath) as! CustomTableViewCell
        
        let friend = friends[indexPath.row]
        
        cell.contentView.backgroundColor = UIColor.black
        cell.titleLabel.text = friend.firstName + " " + friend.lastName
        cell.titleLabel.textColor = .white
        
        if let identifier = GlobalData.sharedInstance.dataRefenciesDict[friend.id] {
            print(" local identifier", identifier)
        } else {
           setupImage(user: friend, imageView: cell.userImageView)
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 300 - (scrollView.contentOffset.y + 300)
        let height = min(max(y, 60), 400)
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: - move it to RxFlow
        let detailStoryboard = UIStoryboard.storyboard(.detail)
        let detailController: DetailController = detailStoryboard.instantiateViewController()
        let friend = friends[indexPath.row]
        detailController.user = friend
        
        indexPathToReload = indexPath
        
        self.show(detailController, sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
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
