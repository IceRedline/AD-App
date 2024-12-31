//
//  ViewController.swift
//  My First App
//
//  Created by Артем Табенский on 03.03.2024.
//

import UIKit
import AVKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet private weak var logo1: UIImageView!
    @IBOutlet private weak var logo2: UIImageView!
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
    
    @IBAction private func welcomeButtonTapped() {
        welcomeLabel.text = "Welcome"
        welcomeButton.isEnabled = false
        musicplayer.play()
        musicButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        musicButton.isEnabled = true
        logo1.isHidden = true
        logo2.isHidden = false
    }
    
    @IBAction func musicButtonTapped() {
        if musicplayer.isPlaying {
            musicplayer.stop()
            musicButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            logo1.isHidden = false
            logo2.isHidden = true
        } else {
            musicplayer.play()
            musicButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            logo1.isHidden = true
            logo2.isHidden = false
        }
    }
    
    
    @IBAction private func quizButtonTapped() {
        if musicplayer.isPlaying {
            musicplayer.stop()
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "QuizID")
        self.present(vc, animated: true)
    }
    
    @IBAction private func animationsButtonTapped(_ sender: UIButton) {
        animationsEngine.animateDownFloat(sender)
    }
    
    @IBAction private func animationsButtonReleased(_ sender: UIButton) {
        animationsEngine.animateUpFloat(sender)
    }
    
    @IBAction private func galleryButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RandomGallery")
        self.present(vc, animated: true)
    }
    
}
