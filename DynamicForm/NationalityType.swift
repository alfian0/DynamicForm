//
//  NationalityType.swift
//  DynamicForm
//
//  Created by Macintosh on 06/04/21.
//

import Foundation

enum NationalityType: Int, CaseIterable {
    case wni
    case wna
    
    var value: String {
        switch self {
        case .wni:
            return "WNI"
        case .wna:
            return "WNA"
        }
    }
}
