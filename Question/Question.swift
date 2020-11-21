// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let question = try? newJSONDecoder().decode(Question.self, from: jsonData)

import Foundation

// MARK: - QuestionElement
struct Question: Codable {
    let title: String?
//    let inputType: InputType
    let option: Option?
    let answer: Answer?
}

//enum InputType: Codable {
//    case text(placeholder: String)
//    case radio(default: String, options: [String])
//    case checkbox(default: [String], options: [String])
//    case date(default: Date, range: (start: Date, end: Date))
//    case email(placeholder: String)
//    case number(default: Int)
//    case tel(placeholder: String)
//}

enum Answer: Codable {
    case string(String)
    case stringArray([String])
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Answer.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Answer"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .stringArray(let x):
            try container.encode(x)
        }
    }
}

enum Option: Codable {
    case string(String)
    case stringArray([String])
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Option.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Option"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .stringArray(let x):
            try container.encode(x)
        }
    }
}
