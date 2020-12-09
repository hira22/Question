// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let question = try? newJSONDecoder().decode(Question.self, from: jsonData)

import Foundation

// MARK: - QuestionElement
struct Question: Codable {
    let title: String?
    let subtitle: String?
    let input: Input
//    let option: Option?
    let answer: Answer?
}

protocol Optional {}

enum InputType: String, Codable {
    case text
    case radio
    case checkbox
//    case date
//    case email
//    case number
//    case tel
}

enum Input: Codable {
    case text(option: Optional?)
    case radio(option: Optional)
    case checkbox(option: Optional)
//    case date(placeholder: Date, start: Date, end: Date)
//    case email(placeholder: String)
//    case number(placeholder: Int)
//    case tel(placeholder: String)

    private enum CodingKeys: String, CodingKey {
        case inputType = "type"
        case option
    }
    
    struct Text: Optional, Codable {
        let placeholder: String?
    }
    
    struct Radio: Optional, Codable {
        let placeholder: String?
        let selections: [String]
    }
    
    struct Checkbox: Optional, Codable {
        let placeholder: [String]?
        let selections: [String]
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(InputType.self, forKey: .inputType)
        
        switch type {
        case .text:
            let x = try? container.decode(Text.self, forKey: .option)
            self = .text(option: x)
            return
            
        case .radio:
            if let x = try? container.decode(Radio.self, forKey: .option) {
                self = .radio(option: x)
                return
            }
            
            self = .radio(option: Radio(placeholder: nil, selections: []))
            
        case .checkbox:
            if let x = try? container.decode(Checkbox.self, forKey: .option) {
                self = .checkbox(option: x)
                return
            }
            
            self = .radio(option: Checkbox(placeholder: nil, selections: []))
        }
        
        throw DecodingError.typeMismatch(Input.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Input"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .text(option: let option):
            try container.encode(InputType.text, forKey: .inputType)
            try container.encode(option as? Text, forKey: .option)
            
        case .radio(option: let option):
            try container.encode(InputType.radio, forKey: .inputType)
            try container.encode(option as? Radio, forKey: .option)
            
        case .checkbox(option: let option):
            try container.encode(InputType.checkbox, forKey: .inputType)
            try container.encode(option as? Checkbox, forKey: .option)
        }
        
        throw EncodingError.invalidValue(Input.self, EncodingError.Context(codingPath: encoder.codingPath, debugDescription: "Wrong type for Input"))
    }
}

enum Answer: Codable {
    case single(String)
    case multiple([String])
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .multiple(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .single(x)
            return
        }
        throw DecodingError.typeMismatch(Answer.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Answer"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .single(let x):
            try container.encode(x)
        case .multiple(let x):
            try container.encode(x)
        }
    }
}

struct Option: Codable {
    let placeholder: Answer?
    let selection: Selection?
}

enum Selection: Codable {
    case stringArray([String])
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }

        throw DecodingError.typeMismatch(Option.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Option"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .stringArray(let x):
            try container.encode(x)
        }
    }
}
