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
    var subtitle: String?
    
    func asQuestion() -> Question {
        Question(title: title, subtitle: subtitle, input: .radio(option: Input.Radio(placeholder: placeholder, selections: selections ?? [])), answer: .single(answer))
    }

    typealias Selection = [String]
    typealias Answer = String
    
    var selections: Selection? = []
    var placeholder: Answer?
    @Published var answer: Answer = ""
    
    init(index: Int, question: Question) {
        self.index = index
        self.title = question.title
        self.subtitle = question.subtitle
        
        if case .radio(let option) = question.input,
           let radio = option as? Input.Radio {
            self.placeholder = radio.placeholder
            self.answer = radio.placeholder ?? ""
            self.selections = radio.selections
        }

    }
    
    init(index: Int, title: String, option: Selection ,answer: Answer) {
        self.index = index
        self.title = title
        self.selections = option
        self.answer = answer
    }
}
