//
//  TextQuestionViewModel.swift
//  Question
//
//  Created by hiraoka on 2020/11/19.
//

import Foundation

class TextQuestionViewModel: QuestionViewModelProtocol, ObservableObject, QuestionAnswerable {
    typealias Option = String
    typealias Answer = String
    
    var index: Int
    var title: String?
    var option: Option = ""
    @Published var answer: Answer = ""
    
    init(index: Int, question: Question) {
        self.index = index
        self.title = question.title
        if case .string(let option) = question.option,
           case .string(let answer) = question.answer {
            self.option = option
            self.answer = answer
        }
    }
    
    init(index: Int, title: String, option: Option  ,answer: Answer) {
        self.index = index
        self.title = title
        self.option = option
        self.answer = answer
    }
}

extension TextQuestionViewModel {
    func asQuestion() -> Question {
        Question(title: title, option: .string(option), answer: .string(answer))
    }
}
