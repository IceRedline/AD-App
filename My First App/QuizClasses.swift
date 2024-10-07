//
//  QuizClasses.swift
//  My First App
//
//  Created by Артем Табенский on 02.10.2024.
//

import Foundation

public class ChosenClass {
    var name: String
    var description: String
    var questions: Dictionary<String, String>
    var answers: Array<String>
    
    init(name: String, description: String, questions: Dictionary<String, String>, answers: Array<String>) {
        self.name = name
        self.description = description
        self.questions = questions
        self.answers = answers
    }
}


public let chosenMusicTheme = ChosenClass(name: "Музыка",
                                          description: "В данной викторине вам предстоит угадывать исполнителей и названия песен.",
                                          questions: ["Когда вышел трек бургер" : "2017"],
                                          answers: ["2017","2018","2016","2015"])
public let chosenTechTheme = ChosenClass(name: "Технологии",
                                         description: "В данной викторине вам предстоит отвечать на вопросы связанные с техникой.",
                                         questions: ["Когда вышел первый айфон" : "2007"],
                                         answers: ["1","2","3","4"])
public let chosenHistoryTheme = ChosenClass(name: "История и культура",
                                            description: "В данной викторине вам предстоит показать себя с культурной стороны.",
                                            questions: ["Когда моцарт написал лунную сонату" : "1724"],
                                            answers: ["1","2","3","4"])
public let chosenPoliticsTheme = ChosenClass(name: "Политика и бизнес",
                                             description: "В данной викторине вам предстоит доказать, что вы шарите в теме денег и грязи.",
                                             questions: ["Когда Путин стал президентом РФ" : "1999"],
                                             answers: ["1","2","3","4"])
