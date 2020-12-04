//
//  QuestionView.swift
//  Question
//
//  Created by hiraoka on 2020/11/16.
//

import SwiftUI

struct QuestionView: View {

    var questions: [QuestionViewModelProtocol]
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(questions, id: \.index) { question in

                        switch question {
                        case let text as TextQuestionViewModel:
                            QuestionLabel(question: question)
                            QuestionTextField(question: text).padding(.leading, 25.0)
                        case let radio as RadioQuestionViewModel:
                            QuestionLabel(question: question)
                            QuestionRadio(question: radio).padding(.leading, 25.0)
                        case let checkbox as CheckboxQuestionViewModel:
                            QuestionLabel(question: question)
                            QuestionCheckbox(question: checkbox).padding(.leading, 25.0)
                        default:
                            EmptyView()
                        }

                    }
                }
                .padding()
            }
            
            Button(action: {
                
                print(String(data: try! JSONEncoder().encode(questions.map {  ($0 as? QuestionAnswerable)?.asQuestion() }), encoding: .utf8)!)
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                    Text("送信する").foregroundColor(.white).bold()
                }
            }).frame(width: 200, height: 48)
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        let questions: [QuestionViewModelProtocol] = [
            TextQuestionViewModel(index: 1, title: "テキスト入力", placeholder: "", answer: "Hello"),
            RadioQuestionViewModel(index: 2, title: "単一選択", option: ["Hello", "World", "Swift"], answer: "Hello"),
            CheckboxQuestionViewModel(index: 3, title: "複数選択", option: ["Hello", "World", "Swift"], answer: ["World", "Swift"])
        ]
        QuestionView(questions: questions)
    }
}

struct QuestionLabel: View {
    var question: QuestionViewModelProtocol
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "\(question.index).circle.fill")
                .resizable()
                .frame(width: 25.0, height: 25.0)
                .foregroundColor(.blue)
            VStack(alignment: .leading) {
                Text(question.title ?? "")
                    .font(.headline)
                    .frame(height: 25.0)
                if let subtitle = question.subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                }
            }
        }
    }
}

struct QuestionTextField: View {
    @ObservedObject var question: TextQuestionViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            if #available(iOS 14.0, *) {
                TextEditor(text: $question.answer)
                    .frame(height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray)
                    )
            } else {
                TextField(question.placeholder ?? "", text: $question.answer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
    }
}

struct QuestionCheckbox: View {
    @ObservedObject var question: CheckboxQuestionViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(question.selections ?? [], id: \.self) { option in
                Button(
                    action: {
                        if let index = question.answer.firstIndex(of: option) {
                            question.answer.remove(at: index)
                            return
                        }
                        question.answer += [option]
                    },
                    label: {
                        HStack(alignment: .center, spacing: 10) {
                            Image(systemName: question.answer.contains(option) ? "checkmark.square" : "square")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.blue)
                                .frame(width: 20.0, height: 20.0)
                            
                            Text(option)
                        }
                    }
                )
            }
        }
    }
}

struct QuestionRadio: View {
    @ObservedObject var question: RadioQuestionViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(question.selections ?? [], id: \.self) { option in
                Button(
                    action: { question.answer = option },
                    label: {
                        HStack(alignment: .center, spacing: 10) {
                            Image(systemName: question.answer == option ? "checkmark.circle" : "circle")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.blue)
                                .frame(width: 20.0, height: 20.0)
                            
                            Text(option)
                        }
                    }
                )
            }
        }
    }
}

protocol QuestionViewModelProtocol {
    var index: Int { get set }
    var title: String? { get set }
    var subtitle: String? { get set }
}

protocol QuestionAnswerable: QuestionViewModelProtocol {
    associatedtype Selection
    associatedtype Answer

    var selections: Selection? { get set }
    var placeholder: Answer? { get set}
    var answer: Answer { get set }
    
    func asQuestion() -> Question
}
