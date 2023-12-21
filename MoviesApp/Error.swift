//
//  Error.swift
//  MoviesApp
//
//  Created by Thomas Sheppard on 20/12/23.
//

import Foundation

enum CustomError: LocalizedError {
    case errorFetchingData

    var description: String? {
        switch self {
        case .errorFetchingData:
            return "Error getting movies information"
        }
    }
}
