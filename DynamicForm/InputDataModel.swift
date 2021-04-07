//
//  InputDataModel.swift
//  DynamicForm
//
//  Created by Macintosh on 06/04/21.
//

import Foundation

enum InputType {
    case text
    case currency
    case date
    case number
    case email
    case phone
    case nik
    case npwp
    case nationality
    case province
    case municipality
    case district
    case subDistrict
    
    var regex: String {
        switch self {
        case .number:
            return "^[0-9]+$"
        case .email:
            return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case .phone:
            return "^[0-9]{6,14}$"
        case .nik:
            return "^((1[1-9])|(21)|([37][1-6])|(5[1-4])|(6[1-5])|([8-9][1-2]))[0-9]{2}[0-9]{2}(([0-6][0-9])|(7[0-1]))((0[1-9])|(1[0-2]))([0-9]{2})[0-9]{4}$"
        case .npwp:
            return "^[0-9]{1,16}$"
        default:
            return "^.{1,}$"
        }
    }
}

struct InputDataModel {
    var key: String?
    var value: String?
    let enabled: Bool
    let type: InputType
    let isRequired: Bool
    var placeholder: String? = nil
    
    func isValid() -> Bool {
        guard let value = value else { return !isRequired }
        switch type {
        case .text, .date:
            return isRequired ? !value.isEmpty : true
        default:
            return value.regex(with: type.regex)
        }
    }
}
