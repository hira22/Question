//
//  CheckboxQuestionViewModel.swift
//  Question
//
//  Created by hiraoka on 2020/11/19.
//

import Foundation

class CheckboxQuestionViewModel: QuestionViewModelProtocol, ObservableObject, QuestionAnswerable {

    var index: Int
    var title: String?
    var subtitle: String?
    
    func asQuestion() -> Question {
        Question(title: title, subtitle: subtitle, input: .checkbox(option: Input.Checkbox(placeholder: placeholder, selections: selections ?? [])), answer: .multiple(answer))
    }
    
    typealias Selection = [String]
    typealias Answer = [String]
    
    var selections: Selection? = []
    var placeholder: Answer? = []
    @Published var answer: Answer = []
    
    init(index: Int, question: Question) {
        self.index = index
        self.title = question.title
        self.subtitle = question.subtitle
        
        if case .checkbox(let option) = question.input,
           let checkbox = option as? Input.Checkbox {
            self.placeholder = checkbox.placeholder
            self.answer = checkbox.placeholder ?? []
            self.selections = checkbox.selections
        }
    }
    
    init(index: Int, title: String, option: Selection, answer: Answer) {
        self.index = index
        self.title = title
        self.selections = option
        self.answer = answer
    }
}
