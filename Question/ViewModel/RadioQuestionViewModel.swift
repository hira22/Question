//
//  RadioQuestionViewModel.swift
//  Question
//
//  Created by hiraoka on 2020/11/19.
//

import Foundation

class RadioQuestionViewModel: QuestionViewModelProtocol, ObservableObject, QuestionAnswerable {
    var index: Int
    var title: String?
    
    func asQuestion() -> Question {
        Question(title: title, option: .stringArray(option), answer: .string(answer))
    }
    
    typealias Option = [String]
    typealias Answer = String
    
    var option: Option = []
    @Published var answer: Answer = ""
    
    init(index: Int, question: Question) {
        self.index = index
        self.title = question.title
        if case .stringArray(let option) = question.option,
           case .string(let answer) = question.answer {
            self.option = option
            self.answer = answer
        }
    }
    
    init(index: Int, title: String, option: Option ,answer: Answer) {
        self.index = index
        self.title = title
        self.option = option
        self.answer = answer
    }
}
