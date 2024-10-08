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
                                                                "Лучшая песня всех времен по версии журнала New Musical Express:" : ["Smells Like Teen Spirit","We Will Rock You","Like a Rolling Stone","Seven Nation Army"],
                                                                "Кто в 2022 году стал первым в России рэпером-иноагентом?" : ["Face","MORGENSHTERN","Oxxxymiron","Noize MC"],
                                                                "В каком году вышла песня Hotel California группы Eagles?" : ["1976", "1980", "1972", "1985"],
                                                                "Какой из этих синглов был выпущен группой The Rolling Stones в 1965 году?" : ["Satisfaction", "Hey Jude", "House of the Rising Sun", "Stairway to Heaven"]] )
public let chosenTechTheme = ChosenClass(name: "Технологии",
                                         description: "В данной викторине вам предстоит отвечать на вопросы связанные с техникой.",
                                         questionsAndAnswers: ["Когда вышел первый айфон?" : ["2007","2006","2008","2009"],
                                                               "Сколько ядер имеет процессор AMD Ryzen 3990X?" : ["64","32","16","12"],
                                                               "Mini-LED экраны являются разновидностью:" : ["IPS","OLED","TN","AMOLED"],
                                                               "Что такое HMB память?" : ["Память распаянная на чипе","Память для мобильных устройств","улучшенная разновидность GDDR6","Кэш-память процессоров AMD"],
                                                               "Технология Thunderbolt была разработана:" : ["Intel и Apple","AMD и Apple","Apple","Intel и AMD"]] )
public let chosenHistoryTheme = ChosenClass(name: "История и культура",
                                            description: "В данной викторине вам предстоит показать себя с культурной стороны.",
                                            questionsAndAnswers: ["Когда моцарт написал лунную сонату?" : ["1801","1784","1802","1811"],
                                                                  "Другое название театра Станиславского, Немировича и Данченко:" : ["МАМТ","МХТ","ГосТиМ","МПТ"],
                                                                  "Сколько симфоний написал Бетховен?" : ["6","8","4","12"],
                                                                  "Дата начала второй мировой войны" : ["1 сентября 1939 г.","22 июня 1941 г.","11 января 1940 г.","26 июня 1941 г."],
                                                                  "В каком городе Пётр I начал постройку Российского флота?" : ["Воронеж","Москва","Санкт-Петербург","Екатеринбург"]] )
public let chosenPoliticsTheme = ChosenClass(name: "Политика и бизнес",
                                             description: "В данной викторине вам предстоит доказать, что вы шарите в теме денег и грязи.",
                                             questionsAndAnswers: ["Когда Путин стал президентом РФ?" : ["1999","2000","2001","1991"],
                                                                   "BORK - компания какой страны?" : ["Россия","Германия","Австрия","Америка"],
                                                                   "Сколько стран состят в ООН?" : ["193","200","31","126"],
                                                                   "Специализация компании WeWork" : ["Коммерческая недвижимость","Поиск работы","Акселерация IT-стартапов","Девелопмент"],
                                                                   "Кто владел основной долей акций компании ЮКОС с 1995 по 2003 гг.?" :
                                                                  ["М. Ходорковский","П. Авен","Г. Греф","Б. Березовский"]] )
