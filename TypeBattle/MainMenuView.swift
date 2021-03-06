//
//  MainMenuView.swift
//  TypeBattle
//
//  Created by Alex Lee on 2017-07-13.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import SpriteKit

class MainMenuView: UIView, BGSceneDelegate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    let leaderboardIconWidth:CGFloat = 64.0
    var gameManager = GameManager()
    var currentPlayer: Player!
    var gameSession: GameSession?
    let screenSize = UIScreen.main.bounds
    var background: BackgroundScene!
    var buttonTag  = 0

    private lazy var nameIcon:UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "TypeBattle3D"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var stack:UIStackView = {
        let sv = UIStackView()
        sv.alignment = UIStackView.Alignment.fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.isLayoutMarginsRelativeArrangement = true
        sv.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        sv.axis = .vertical
        sv.spacing = 15
        return sv
    }()
    
    private lazy var leaderboardButton:UIButton = {
        let button = UIButton()
        button.tag = 5
        let icon   = #imageLiteral(resourceName: "leaderboard_icon")
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(icon, for: .normal)
        button.tintColor = UIColor.gameRed
        button.backgroundColor = UIColor.clear
        
        button.addTarget(self, action: #selector(lbButtonTapped(sender:)), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var singlePlayerButton:MainMenuButton = {

        let button = self.createMenuButton(title: "Training")
        button.addTarget(self, action: #selector(spButtonTapped(sender:)), for: .touchUpInside)
        button.tag = 1
        
        return button
    }()
    
    private lazy var multiPlayerButton:MainMenuButton = {
        let button = self.createMenuButton(title: "Multiplayer")
        button.tag = 2
        
        button.addTarget(self, action: #selector(mpButtonTapped(sender:)), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var settingsButton:MainMenuButton = {
        let button = self.createMenuButton(title: "Settings")
        button.tag = 3
        
        button.addTarget(self, action: #selector(settingsButtonTapped(sender:)), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var profileButton:MainMenuButton = {
        let button = self.createMenuButton(title: "My Profile")
        button.tag = 4
        
        button.addTarget(self, action: #selector(profileButtonTapped(sender:)), for: .touchUpInside)
        
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor(red: 194/255, green: 217/255, blue: 241/255, alpha: 1.0)
        self.addSubview(nameIcon)
        self.addSubview(leaderboardButton)
        
        self.addSubview(stack)
        
        stack.addArrangedSubview(singlePlayerButton)
        stack.addArrangedSubview(multiPlayerButton)
        stack.addArrangedSubview(profileButton)
        stack.addArrangedSubview(settingsButton)
        
        // Get logged user
        let delegate = UIApplication.shared.delegate as! AppDelegate
        self.currentPlayer = delegate.player
        
        setupBackground()
        background.backgroundColor = UIColor.background
        background.bgDelegate = self
        
//        let playerSessions = [PlayerSession(playerID: "100", playerName: "alex")]
//        playerSessions[0].totalTime = 50
//        playerSessions[0].finalPosition = 1
//        let frameOfKeyboard = CGRect(x: 0.0, y: 50.0, width: self.frame.width, height: 200.0)
//        let endgame = Bundle.main.loadNibNamed("EndGameView", owner: self, options: nil)?.first as! EndGameView
//        endgame.frame = frameOfKeyboard
//        endgame.players = playerSessions
//        self.addSubview(endgame)
        self.setNeedsUpdateConstraints()
        
    }
    func animationDidFinish() {
        switch buttonTag {
        case 1:
            trainingSegue()
            buttonTag = 0
        case 2:
            multiplayerSegue()
            buttonTag = 0
        case 3:
            settingsSegue()
            buttonTag = 0
            break
        case 4:
            myProfileSegue()
            buttonTag = 0
        case 5:
            leaderboardSegue()
            buttonTag = 0
        default:
            break
        }
    }

    
    @objc func spButtonTapped(sender: UIButton) {
        MusicHelper.sharedHelper.playButtonSound()
        buttonTag = 1
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "startAnimation"), object: nil)
    }
    
    @objc func lbButtonTapped(sender: UIButton) {
        MusicHelper.sharedHelper.playButtonSound()
        buttonTag = 5
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "startAnimation"), object: nil)
    }
    
    @objc func mpButtonTapped(sender: UIButton) {
        MusicHelper.sharedHelper.playButtonSound()
        buttonTag = 2
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "startAnimation"), object: nil)
    }
    
    @objc func settingsButtonTapped(sender: UIButton) {
        MusicHelper.sharedHelper.playButtonSound()
        buttonTag = 3
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "startAnimation"), object: nil)
    }
    
    @objc func profileButtonTapped(sender: UIButton) {
        MusicHelper.sharedHelper.playButtonSound()
        buttonTag = 4
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "startAnimation"), object: nil)
    }
    
    func setupBackground() {
        
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        //gameViewHeight = screenHeight - keyboardHeight
        
        let gameView = SKView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        
        background = BackgroundScene(size: gameView.frame.size)
        background.scaleMode = .aspectFit
        
        gameView.translatesAutoresizingMaskIntoConstraints = false
        gameView.presentScene(background)
        gameView.ignoresSiblingOrder = true
        gameView.showsFPS = false
        gameView.showsNodeCount = false
        
        self.insertSubview(gameView, belowSubview: nameIcon)
        
        gameView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        gameView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        gameView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        gameView.heightAnchor.constraint(equalToConstant: screenHeight).isActive = true
        
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([ nameIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
                                      nameIcon.topAnchor.constraint(equalTo: topAnchor, constant: 50.0),
                                      nameIcon.heightAnchor.constraint(equalTo:widthAnchor, multiplier: 0.75),
                                      nameIcon.widthAnchor.constraint(equalTo: nameIcon.heightAnchor),
                                      stack.topAnchor.constraint(equalTo: nameIcon.bottomAnchor),
                                      stack.centerXAnchor.constraint(equalTo: centerXAnchor),
                                      stack.widthAnchor.constraint(equalTo: nameIcon.widthAnchor, constant: -25.0),
                                      leaderboardButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0),
                                      leaderboardButton.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 15.0),
                                      leaderboardButton.widthAnchor.constraint(equalToConstant: leaderboardIconWidth),
                                      leaderboardButton.heightAnchor.constraint(equalTo: leaderboardButton.widthAnchor)
                                      ])
        super.updateConstraints()
    }
    
    func createMenuButton(title:String!) -> MainMenuButton {
        let button = MainMenuButton()
        button.contentVerticalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.gameRed
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.gameFont(size: 30.0)
        button.layer.cornerRadius = 4.0
        return button
    }
    
    func trainingSegue() {
        guard var top  = UIApplication.shared.keyWindow?.rootViewController else {return}
        while let next = top.presentedViewController {top = next}
        guard let vc   = top as? MainMenuViewController else {return}

        // Create lobby
        let category = arc4random_uniform(2) == 1 ? "quote" : "poem"
        let lobby    = gameManager.createGameLobby(name: "TRAINING", keyword: category, maxCapacity: 1, location: nil, owner: self.currentPlayer)

        // Create session
        self.gameSession = self.gameManager.createGameSession(lobby: lobby, someRandomText: "just type the correct letter faster than your opponents. it is that simple!", persistInFirebase: false)
        
        let characterArray = self.gameManager.getAllCharacters()
        let randomCharacterIndex = Int(arc4random_uniform(8))
        self.gameSession?.players[0].gameCharacter = characterArray[randomCharacterIndex].type
        
        vc.gameSession = self.gameSession
        vc.performSegue(withIdentifier: "toTraining", sender: vc)        
   }
    
    func myProfileSegue() {
        let storyboard = UIStoryboard(name: "ProfilePage", bundle: nil)
        let vc         = storyboard.instantiateInitialViewController()
        let window     = UIApplication.shared.windows[0] as UIWindow
        
        let transition      = CATransition()
        transition.type  = CATransitionType.fade
        transition.duration = 0.5
        
        window.set(rootViewController: vc!, withTransition: transition)
    }
    
    func multiplayerSegue() {
        let storyboard = UIStoryboard(name: "Multiplayer", bundle: nil)
        let vc         = storyboard.instantiateInitialViewController()
        let window     = UIApplication.shared.windows[0] as UIWindow
        
        let transition      = CATransition()
        transition.type  = CATransitionType.fade
        transition.duration = 0.5
        
        window.set(rootViewController: vc!, withTransition: transition)
    }
    
    func leaderboardSegue() {
        let storyboard = UIStoryboard(name: "Leaderboard", bundle: nil)
        let vc         = storyboard.instantiateInitialViewController()
        let window     = UIApplication.shared.windows[0] as UIWindow
        
        
        let transition      = CATransition()
        transition.type  = CATransitionType.fade
        transition.duration = 0.5
        
        window.set(rootViewController: vc!, withTransition: transition)
    }
    
    func settingsSegue() {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let vc         = storyboard.instantiateInitialViewController()
        let window     = UIApplication.shared.windows[0] as UIWindow
       
        let transition      = CATransition()
        transition.type  = CATransitionType.fade
        transition.duration = 0.5
        
        window.set(rootViewController: vc!, withTransition: transition)
 
    }
}
