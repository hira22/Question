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
        Question(title: title, subtitle: subtitle, option: Option(placeholder: .single(placeholder ?? ""), selection: .stringArray(selections ?? [])), answer: .single(answer))
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
        
        if case .stringArray(let selections) = question.option?.selection {
            self.selections = selections
        }
        if case .single(let placeholder) = question.option?.placeholder {
            self.placeholder = placeholder
            self.answer = placeholder
        }
    }
    
    init(index: Int, title: String, option: Selection ,answer: Answer) {
        self.index = index
        self.title = title
        self.selections = option
        self.answer = answer
    }
}
