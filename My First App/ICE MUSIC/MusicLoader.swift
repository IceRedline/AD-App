//
//  MuiscLoader.swift
//  My First App
//
//  Created by Артем Табенский on 29.12.2024.
//

import UIKit

class MusicLoader {
    
    func loadMusic(arrayToFill: inout Array<Album>?) {
        arrayToFill = [Album(name: "Risen From The Ashes", image: UIImage(named: "Risen From The Ashes обложка.jpg"), song:
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
    }
    
}
