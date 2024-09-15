//
//  NinthViewController.swift
//  My First App
//
//  Created by Артем Табенский on 14.03.2024.
//

import UIKit
import AVKit

class MusicCell: UICollectionViewCell {
    @IBOutlet weak var albumPreview: UIImageView!
    @IBOutlet weak var nowplayingIcon: UIImageView!
}

class Album {
    var name: String
    var image: UIImage?
    var song: URL?
    
    init(name: String, image: UIImage? = nil, song: URL? = nil) {
        self.name = name
        self.image = image
        self.song = song
    }
}

var albums: [Album] = [Album(name: "Risen From The Ashes", image: UIImage(named: "Risen From The Ashes обложка.jpg"), song:
                            Bundle.main.url(forResource: "Покиньте Зал", withExtension: "mp3")),
                       Album(name: "Audi Quattro", image: UIImage(named: "Audi Quattro обложка.jpg"), song: Bundle.main.url(forResource: "Audi Quattro", withExtension: "mp3")),
                       Album(name: "Audi Quattro 2021 Renewed", image: UIImage(named: "Quattro 2021.jpg"), song: Bundle.main.url(forResource: "Audi Quattro 2021", withExtension: "mp3")),
                       Album(name: "REIGNITION", image: UIImage(named: "REIGNITION.jpeg"), song:
                            Bundle.main.url(forResource: "СИНИЙ AUDI", withExtension: "mp3")),
                       Album(name: "Action", image: UIImage(named: "Action обложка.jpg"), song:
                                Bundle.main.url(forResource: "Action", withExtension: "mp3")),
                       Album(name: "Тверская", image: UIImage(named: "Тверская обложка.JPG"), song:
                                Bundle.main.url(forResource: "Тверская", withExtension: "mp3")),
                       Album(name: "Города", image: UIImage(named: "Города обложка.JPG"), song:
                                Bundle.main.url(forResource: "Города", withExtension: "mp3")),
                       Album(name: "Специфичный", image: UIImage(named: "специфичный обложка.jpeg"), song: Bundle.main.url(forResource: "Специфичный", withExtension: "mp3")),
                       Album(name: "Onward Love", image: UIImage(named: "Onward Love обложка.JPG"), song:
                                Bundle.main.url(forResource: "Onward Love", withExtension: "mp3")),
                       Album(name: "More Than Silence", image: UIImage(named: "MORE THAN SILENCE.JPG"), song: Bundle.main.url(forResource: "Заключительная", withExtension: "wav")),
                       Album(name: "10 FAULTS", image: UIImage(named: "10 FAULTS обложка.jpeg"), song:
                                Bundle.main.url(forResource: "10 FAULTS", withExtension: "mp3"))]

class NinthViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var musicCollectionView: UICollectionView!
    
    var player: AVAudioPlayer?
    var currentlyPlayingCell: MusicCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        musicCollectionView.dataSource = self
        musicCollectionView.delegate = self
        
        //FirstViewController.musicplayer.stop()
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        if let imageView = sender.view as? UIImageView,
           let cell = imageView.superview?.superview as? MusicCell,
           let indexPath = musicCollectionView.indexPath(for: cell) {
            let album = albums[indexPath.row]
            if let songURL = album.song {
                if let player = player, player.isPlaying {
                    player.stop()
                    currentlyPlayingCell?.nowplayingIcon.isHidden = true
                    if currentlyPlayingCell == cell {
                        self.player = nil
                        self.currentlyPlayingCell = nil
                        return
                    }
                }
                do {
                    player = try AVAudioPlayer(contentsOf: songURL)
                    player?.play()
                    cell.nowplayingIcon.isHidden = false
                    currentlyPlayingCell = cell
                } catch {
                    print("Error playing song: \(error)")
                }
                print("Song started!")
            }
        }
    }
}

extension NinthViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicCell", for: indexPath) as! MusicCell
        cell.albumPreview.image = albums[indexPath.row].image
        cell.albumPreview.contentMode = .scaleAspectFit

        // Add shadow to nowplayingIcon
        cell.nowplayingIcon.layer.masksToBounds = false
        cell.nowplayingIcon.layer.shadowColor = UIColor.black.cgColor
        cell.nowplayingIcon.layer.shadowOffset = CGSize(width: 0, height: 1)
        cell.nowplayingIcon.layer.shadowOpacity = 100
        cell.nowplayingIcon.layer.shadowRadius = 10

        // Enable user interaction and add gesture recognizer
        cell.albumPreview.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        cell.albumPreview.addGestureRecognizer(tapGestureRecognizer)
        
        return cell
    }
    
    @IBAction func nextButtonTapped(_ sender: UIBarButtonItem) {
        player?.stop()
        currentlyPlayingCell?.nowplayingIcon.isHidden = true
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vcp = storyboard.instantiateViewController(withIdentifier: "PAGESID") as! PageViewController
        self.navigationController?.pushViewController(vcp, animated: true)
    }
}
