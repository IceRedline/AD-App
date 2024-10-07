//
//  QuizClasses.swift
//  My First App
//
//  Created by Артем Табенский on 02.10.2024.
//

import Foundation

public var chosenTheme: ChosenClass = chosenMusicTheme // переделать
public var chosenThemeQuestionsArray: [String] = Array(chosenTheme.questionsAndAnswers.keys).shuffled()

public class ChosenClass {
    var name: String
    var description: String
    var questionsAndAnswers: Dictionary<String, Array<String> > // словарь с вопросами и ответами
    
    init(name: String, description: String, questionsAndAnswers: Dictionary<String, Array<String> >) {
        self.name = name
        self.description = description
        self.questionsAndAnswers = questionsAndAnswers
    }
    
}


public let chosenMusicTheme = ChosenClass(name: "Музыка",
                                          description: "В данной викторине вам предстоит угадывать исполнителей и названия песен.",
                                          questionsAndAnswers: ["Когда вышел трек бургер" : ["2017","2018","2016","2015"],
                                                      "Кто является автором песни бургер" : ["Face","MORGENSHTERN","Тимати","Егор Крид"]] )
public let chosenTechTheme = ChosenClass(name: "Технологии",
                                         description: "В данной викторине вам предстоит отвечать на вопросы связанные с техникой.",
                                         questionsAndAnswers: ["Когда вышел первый айфон" : ["1","2","3","4"]] )
public let chosenHistoryTheme = ChosenClass(name: "История и культура",
                                            description: "В данной викторине вам предстоит показать себя с культурной стороны.",
                                            questionsAndAnswers: ["Когда моцарт написал лунную сонату" : ["1","2","3","4"]] )
public let chosenPoliticsTheme = ChosenClass(name: "Политика и бизнес",
                                             description: "В данной викторине вам предстоит доказать, что вы шарите в теме денег и грязи.",
                                             questionsAndAnswers: ["Когда Путин стал президентом РФ" : ["1","2","3","4"]] )
