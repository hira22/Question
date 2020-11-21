//
//  CheckboxQuestionViewModel.swift
//  Question
//
//  Created by hiraoka on 2020/11/19.
//

import Foundation

class CheckboxQuestionViewModel: QuestionViewModelProtocol, ObservableObject, QuestionAnswerable {

    func asQuestion() -> Question {
        Question(title: title, option: .stringArray(option), answer: .stringArray(answer))
    }
    
    typealias Option = [String]
    typealias Answer = [String]
    
    var index: Int
    var title: String?
    var option: [String] = []
    @Published var answer: [String] = []
    
    init(index: Int, question: Question) {
        self.index = index
        self.title = question.title
        if case .stringArray(let option) = question.option,
           case .stringArray(let answer) = question.answer {
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
