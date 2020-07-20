//
//  ProfileVC.swift
//  LeagueOfWalk
//
//  Created by 표건욱 on 2020/07/17.
//  Copyright © 2020 김광수. All rights reserved.
//
//
import UIKit
import Firebase

class ProfileVC: UIViewController {

    let myCharacterView = UIImageView()
    let imageLabel = UILabel()
    let imageLabel1 = UILabel()
    let imageLabel2 = UILabel()
    static let tierImageView = UIImageView()
    let viewLayout = UICollectionViewFlowLayout()
  
    lazy var menuCollection = UICollectionView(frame: view.frame,
                                               collectionViewLayout: viewLayout
    )
    
    var menuItem = ["", "Egg", "challenger_1", "treasure-chest"]
    let menuItemTitle = ["My character", "My Pet", "Ranking", "My Items"]
    
    
    struct SetItem {
        static let padding: CGFloat = 50
        static let edge = UIEdgeInsets(top: 25, left: 75, bottom: 25, right: 75)
        static var itemCountLine:CGFloat = 1
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUserSignupDate()
        setUI()
    }
    
// MARK: - func
    
    func setUI(){
        navigationItem.titleView = NavigationBarView(
            frame: .zero,
            title: CommonUI.NavigationBarTitle.profileVC.rawValue
        )

        let naviBar = self.navigationController?.navigationBar
        naviBar?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        naviBar?.shadowImage = UIImage()
        naviBar?.isTranslucent = true
        naviBar?.backgroundColor = UIColor.clear
        view.backgroundColor = CommonUI.backgroundColor
        
        let barButton = UIBarButtonItem(title: "로그아웃",
                                        style: .plain,
                                        target: self,
                                        action: #selector(handleLogoutButton(_:)))
        barButton.tintColor = CommonUI.edgeColor
        barButton.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: CommonUI.CustonFonts.enFont.rawValue,
                                                size: Standard.textSize)!], for: .normal)
        
        navigationItem.rightBarButtonItem = barButton
        
        myCharacterView.layer.cornerRadius = 5
        myCharacterView.layer.borderWidth = 0.75
        myCharacterView.layer.borderColor = UIColor.systemYellow.cgColor
        myCharacterView.clipsToBounds = true
        view.addSubview(myCharacterView)
        
        myCharacterView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myCharacterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            myCharacterView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            myCharacterView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            myCharacterView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4)
        ])
        
        imageLabel.textAlignment = .left
        imageLabel.font = UIFont(name: CommonUI.CustonFonts.enFontRagular.rawValue,
                                size: Standard.textSize + 2)
        imageLabel.textColor = Standard.textColor
        myCharacterView.addSubview(imageLabel)
        
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageLabel.topAnchor.constraint(equalTo: myCharacterView.topAnchor, constant: 15),
            imageLabel.leadingAnchor.constraint(equalTo: myCharacterView.leadingAnchor, constant: 15)
        ])
        
        imageLabel1.textAlignment = .left
        imageLabel1.font = UIFont(name: CommonUI.CustonFonts.enFontRagular.rawValue,
                                size: Standard.textSize + 2)
        imageLabel1.textColor = Standard.textColor
        myCharacterView.addSubview(imageLabel1)
        
        imageLabel1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageLabel1.topAnchor.constraint(equalTo: imageLabel.bottomAnchor, constant: 5),
            imageLabel1.leadingAnchor.constraint(equalTo: myCharacterView.leadingAnchor, constant: 15)
        ])
        
        imageLabel2.textAlignment = .left
        imageLabel2.font = UIFont(name: CommonUI.CustonFonts.enFontRagular.rawValue,
                                size: Standard.textSize + 2)
        imageLabel2.textColor = Standard.textColor
        myCharacterView.addSubview(imageLabel2)
        
        imageLabel2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageLabel2.topAnchor.constraint(equalTo: imageLabel1.bottomAnchor, constant: 5),
            imageLabel2.leadingAnchor.constraint(equalTo: myCharacterView.leadingAnchor, constant: 15)
        ])
        
//        tierImageView.image = UIImage(named: "platinum_5")
        myCharacterView.addSubview(ProfileVC.tierImageView)
        
        ProfileVC.tierImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ProfileVC.tierImageView.widthAnchor.constraint(equalTo: myCharacterView.widthAnchor, multiplier: 0.3),
            ProfileVC.tierImageView.heightAnchor.constraint(equalTo: ProfileVC.tierImageView.widthAnchor),
            ProfileVC.tierImageView.leadingAnchor.constraint(equalTo: myCharacterView.leadingAnchor),
            ProfileVC.tierImageView.bottomAnchor.constraint(equalTo: myCharacterView.bottomAnchor)
        ])
        
        menuCollection.backgroundColor = .clear
        menuCollection.collectionViewLayout = viewLayout
        menuCollection.allowsMultipleSelection = true
        menuCollection.dataSource = self
        menuCollection.delegate = self
        menuCollection.register(ProfileViewCustomCell.self, forCellWithReuseIdentifier: ProfileViewCustomCell.identifier)
        view.addSubview(menuCollection)
        
        menuCollection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuCollection.topAnchor.constraint(equalTo: myCharacterView.bottomAnchor, constant: 20),
            menuCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            menuCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            menuCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])


    }
    func fetchUserSignupDate() {
      if let uid = Auth.auth().currentUser?.uid {
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
//          print(snapshot)
          
          guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
          
            let user = User.init(uid: uid, dictionary: dictionary)
            self.myCharacterView.image = UIImage(named: "\(user.selectCharactor ?? "Ranking")_back")
            self.imageLabel.text = "NAME: \(user.nickName ?? "이름")"
            self.imageLabel1.text = "RANK: \(UserRankingVC.userRankLocationInArray + 1) st"
            self.imageLabel2.text = "SCORE: \(Int(user.walkingStatus))"
            self.menuItem[0] = user.selectCharactor
            self.menuCollection.reloadData()
        }
      }
    }

    @objc func handleLogoutButton(_ sender: UIBarButtonItem) {
      do {
        // attemp sign out
        try Auth.auth().signOut()

        //present login controller
        let loginVC = LoginVC()
        let navController = UINavigationController(rootViewController: loginVC)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
        print("SucessFull Log out User")
      } catch {
        //handle erorr
        print("Failed to sign out")
      }
    }
}
// MARK: - Extension
extension ProfileVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItem.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileViewCustomCell.identifier,
                                                      for: indexPath) as! ProfileViewCustomCell
        item.backgroundColor = .clear
        item.itemImageView.layer.cornerRadius = item.frame.height / 3
        item.itemImageView.image = UIImage(named: menuItem[indexPath.item])
        item.itemTitleLabel.text = menuItemTitle[indexPath.item]
        return item
    }


}

extension ProfileVC: UICollectionViewDelegateFlowLayout {
    // 줄 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return SetItem.padding
    }
    // 행 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return SetItem.padding
    }
    // 테두리
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return SetItem.edge
    }
    // 아이템 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let size = (collectionView.frame.width - (SetItem.edge.left + SetItem.edge.right) - (SetItem.padding * (SetItem.itemCountLine - 1))) / SetItem.itemCountLine
        return CGSize(width: size, height: size)
    }
}

extension ProfileVC: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    if indexPath.item == 3 {
      
      let randomItemVC = RandomItemVC()
      randomItemVC.myItemCheck = true
      randomItemVC.navigationItem.title = "My Item List"
      navigationController?.pushViewController(randomItemVC, animated: true)
    }
  }
}
