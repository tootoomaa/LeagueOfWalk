//
//  MainViewController.swift
//  LeagueOfWalk
//
//  Created by 요한 on 2020/07/21.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import Firebase
import SnapKit

class MainViewController: UIViewController {
  
  // MARK: - Properties
  
  var eggTabCount: Int = 0
  
  // 사용자 첫 로그인 확이
  var initialization: Bool = true
  
  var progressValue: CGFloat = 0 {
    didSet {
      self.progressView.progress = progressValue
    }
  }
  
  var ments: String = ""  {
    didSet {
      mentLabel.text = ments
    }
  }
  
  private let heroImageView: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(named: "Egg")
    iv.contentMode = .scaleAspectFit
    return iv
  }()
  
  private let contentsView: UILabel = {
    let l = UILabel()
    l.backgroundColor = CommonUI.pointColor
    l.layer.cornerRadius = CommonUI.cornerRadius
    l.layer.borderWidth = CommonUI.borderWidth
    l.layer.borderColor = CommonUI.edgeColor.cgColor
    l.text = "teijakljsdfl"
    
    return l
  }()
  
  let progressView: ProgressView = {
    let view = ProgressView()
    view.backgroundColor = .gray
    view.progress = 0
    return view
  }()
  
  let progressBackgroundView: UIView = {
    let view = UIView()
    view.backgroundColor = .gray
    return view
  }()
  
  let mentLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.textAlignment = .center
    label.font = .boldSystemFont(ofSize: 20)
    return label
  }()
  
  private lazy var stackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [heroImageView, progressBackgroundView, contentsView])
    sv.axis = .vertical
    sv.spacing = 20
    
    return sv
  }()
  
  // MARK: - Inti
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    UserDefaults.standard.set(true, forKey: "fullProgress")
//    let imageString = "1-1"
    
//    UserDefaults.standard.set(false, forKey: "fullProgress")
//    UserDefaults.standard.set(0, forKey: "walkingStatus")
//    UserDefaults.standard.set(imageString, forKey: "summoner")
    
//    print(UserDefaults.standard.bool(forKey: "fullProgress"))
//    print(UserDefaults.standard.string(forKey: "summoner"))
    
    configureInitialData()
    
    checkIfUserIsLoggedIn()
    
    checkIfUserSelectCharacter()
    
    configureTabGestureRecog()
    
    setUI()
  }
  
  private func configureInitialData() {
    
    initialization = UserDefaults.standard.bool(forKey: "fullProgress")
    print(initialization)
    
    if initialization == false {
      if let summonerImageString = UserDefaults.standard.string(forKey: "summoner") {
      
        print(summonerImageString)
        heroImageView.isUserInteractionEnabled = initialization
        heroImageView.image = UIImage(named: summonerImageString)
        mentLabel.text = ""
      }
    } else {
      heroImageView.isUserInteractionEnabled = true
      mentLabel.text = "터치하여 알을 부화하세요!"
    }
  }
  
  private func configureTabGestureRecog() {
    
    let gestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tabHeroImage))
    heroImageView.addGestureRecognizer(gestureRecognizer)
//    heroImageView.isUserInteractionEnabled = true
  }
  
  private func setUI() {
    
    view.backgroundColor = CommonUI.backgroundColor
    view.addSubview(stackView)
    view.addSubview(progressView)
    view.addSubview(mentLabel)
    
    view.bringSubviewToFront(progressView)
    
    navigationSettings()
    
    let guid = view.safeAreaLayoutGuide
    
    stackView.snp.makeConstraints {
      $0.top.bottom.equalTo(guid)
      $0.trailing.equalTo(guid).offset(-20)
      $0.leading.equalTo(guid).offset(20)
      $0.bottom.equalTo(guid).offset(-20)
    }
    
    heroImageView.snp.makeConstraints {
      $0.height.equalTo(300)
    }

    mentLabel.snp.makeConstraints {
      $0.bottom.equalTo(heroImageView.snp.bottom)
      $0.centerX.equalTo(heroImageView.snp.centerX)
      $0.height.equalTo(40)
    }

    progressBackgroundView.snp.makeConstraints {
      $0.height.equalTo(10)
    }
    
    progressView.snp.makeConstraints{
      $0.top.equalTo(progressBackgroundView.snp.top)
      $0.bottom.equalTo(progressBackgroundView.snp.bottom)
      $0.leading.equalTo(progressBackgroundView.snp.leading)
      $0.trailing.equalTo(progressBackgroundView.snp.trailing)
      $0.height.equalTo(10)
    }

    contentsView.snp.makeConstraints {
      $0.height.equalTo(view.frame.height / 4)
    }
  }
  // navigation
  func navigationSettings() {
    navigationItem.titleView = NavigationBarView(
      frame: .zero,
      title: CommonUI.NavigationBarTitle.mainSummonerVC.rawValue
    )
    
    let navBar = self.navigationController?.navigationBar
    navBar?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    navBar?.shadowImage = UIImage()
    navBar?.isTranslucent = true
    navBar?.backgroundColor = UIColor.clear
  }
  
  
  // MARK: - Handler
  
  @objc func tabHeroImage() {
    
    eggTabCount += 1
    
    progressValue = CGFloat(eggTabCount)/CGFloat(27)

    switch eggTabCount {
    case 0...3:
      didTabEggRotatedAnimation()
      ments = "방금 알이 움직인건가요?"
    case 4...12:
      didTabEggRotatedAnimation()
      ments = "무엇인가 안에서 움직이고 있네요 !!"
    case 12...19:
      didTabEggRotatedAnimation()
      didTabEggShakeAnimation()
      ments = "움직임이 커졌네요 !!"
    case 19...26:
      didTabEggRotatedAnimation()
      didTabEggShakeAnimation()
      ments = "곧 무엇인가 밖으로 나올것 같아요 !!"
    default:
      heroImageView.contentMode = .scaleAspectFill
      heroImageView.clipsToBounds = true
      
       let imageString: String = ["1-1", "1-2", "1-3", "2-1", "2-2", "2-3", "3-1", "3-2", "3-3", "4-1", "4-2", "4-3", "5-1", "5-2", "5-3", " 6-1", "6-2", "6-3"].randomElement()!
      
      UserDefaults.standard.set(false, forKey: "fullProgress")
      UserDefaults.standard.set(0, forKey: "walkingStatus")
      UserDefaults.standard.set(imageString, forKey: "summoner")
      
      let popup = PopupView()
      popup.imageString = imageString
      heroImageView.image = UIImage(named: popup.imageString!)
      
      mentLabel.text = ""
      heroImageView.isUserInteractionEnabled = false
      progressValue = CGFloat(0)
      view.addSubview(popup)
      return
    }
  }
  
  // MARK: - Animation
  
  private func didTabEggRotatedAnimation() {
    let random: CGFloat = CGFloat(drand48()) - 0.5
    
    UIView.animateKeyframes(withDuration: 0.25, delay: 0, animations: {
      UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
        self.heroImageView.transform = self.heroImageView.transform.rotated(by: random)
      })
      UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3, animations: {
        self.heroImageView.transform = .identity
      })
      UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3, animations: {
        self.heroImageView.transform = self.heroImageView.transform.rotated(by: -random)
      })
      UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
        self.heroImageView.transform = .identity
      })
    })
  }
  
  private func didTabEggShakeAnimation() {
    UIView.animateKeyframes(withDuration: 0.25, delay: 0, animations: {
      UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
        self.heroImageView.center.x -= 8
      })
      UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3, animations: {
        //        self.heroImageView.transform = .identity
        self.heroImageView.center.x += 16
      })
      UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3, animations: {
        self.heroImageView.center.x -= 16
      })
      UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
        self.heroImageView.transform = .identity
        self.heroImageView.center.x += 8
      })
    })
  }
  
 
  // MARK: - FireBase
  func checkIfUserIsLoggedIn() {
    DispatchQueue.main.async {
      if Auth.auth().currentUser == nil {
        let loginVC = LoginVC()
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true, completion: nil)
      }
    }
  }
  
  func checkIfUserSelectCharacter() {
    DispatchQueue.main.async {
      if let uid = Auth.auth().currentUser?.uid {
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
          
          guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
          
          let user = User.init(uid: uid, dictionary: dictionary)
          
          if user.selectCharactor == "" {
            let selectCharVC = SelectCharVC()
            selectCharVC.userData = user
            selectCharVC.modalPresentationStyle = .fullScreen
            self.present(selectCharVC, animated: true, completion: nil)
          }
        }
      }
    }
  }
}
