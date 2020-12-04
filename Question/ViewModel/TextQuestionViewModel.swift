//
//  TextQuestionViewModel.swift
//  Question
//
//  Created by hiraoka on 2020/11/19.
//

import Foundation

class TextQuestionViewModel: QuestionViewModelProtocol, ObservableObject, QuestionAnswerable {
    var index: Int
    var title: String?
    var subtitle: String?

    typealias Selection = String
    typealias Answer = String
    
    var selections: Selection? = nil
    var placeholder: Answer?
    @Published var answer: Answer = ""
    
    init(index: Int, question: Question) {
        self.index = index
        self.title = question.title
        self.subtitle = question.subtitle
        
        if case .single(let placeholder) = question.option?.placeholder {
            self.placeholder = placeholder
            self.answer = placeholder
        }
    }
    
    init(index: Int, title: String, placeholder: Answer, answer: Answer) {
        self.index = index
        self.title = title
        self.placeholder = placeholder
        self.answer = answer
    }
}

extension TextQuestionViewModel {
    func asQuestion() -> Question {
        Question(title: title, subtitle: subtitle, option: Option(placeholder: .single(placeholder ?? ""), selection: nil), answer: .single(answer))
    }
}
