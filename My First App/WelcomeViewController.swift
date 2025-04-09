//
//  ViewController.swift
//  My First App
//
//  Created by Артем Табенский on 03.03.2024.
//

import UIKit
import AVKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet private weak var logo: UIImageView!
    @IBOutlet private weak var welcomeButton: UIButton!
    @IBOutlet private weak var welcomeLabel: UILabel!
    @IBOutlet private weak var musicButton: UIButton!
    
    var musicplayer: AVAudioPlayer!
    let animationsEngine = Animations()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = Bundle.main.url(forResource: "ambient", withExtension: "mp3")
        musicplayer = try! AVAudioPlayer(contentsOf: url!)
        // player.numberOfLoops = -1
    }
    
    private func animateLogo(fade: Bool) {
        switch fade {
        case true:
            UIView.transition(with: logo,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: { self.logo.image = UIImage(named: "AD Fade") },
                              completion: nil)
        case false:
            UIView.transition(with: logo,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: { self.logo.image = UIImage(named: "AD") },
                              completion: nil)
        }
    }
    
    @IBAction private func welcomeButtonTapped() {
        welcomeLabel.fadeIn()
        welcomeButton.isEnabled = false
        musicplayer.play()
        musicButton.isEnabled = true
        musicButton.isSymbolAnimationEnabled = true
        /*
        musicButton.imageView?.addSymbolEffect(.appear) { context in
            if let imageView = context.sender as? UIImageView, context.isFinished {
                self.view.addSubview(imageView)
            }
        }
        */
        musicButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        animateLogo(fade: true)
    }
    
    @IBAction func musicButtonTapped() {
        if musicplayer.isPlaying {
            musicplayer.stop()
            musicButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            animateLogo(fade: false)
        } else {
            musicplayer.play()
            musicButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            animateLogo(fade: true)
        }
    }
    
    
    @IBAction private func quizButtonTapped() {
        if musicplayer.isPlaying {
            musicplayer.stop()
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: StoryboardIDs.quizice)
        self.present(vc, animated: true)
    }
    
    @IBAction private func animationsButtonTapped(_ sender: UIButton) {
        animationsEngine.animateDownFloat(sender)
    }
    
    @IBAction private func animationsButtonReleased(_ sender: UIButton) {
        animationsEngine.animateUpFloat(sender)
    }
    
    @IBAction func browserButtonTapped() {
        let vc = storyboard?.instantiateViewController(withIdentifier: StoryboardIDs.web) as! BrowserViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
