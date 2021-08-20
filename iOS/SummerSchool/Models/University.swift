//
//  University.swift
//  SummerSchool
//
//  Created by Dan, Radu-Ionut on 21.07.2021.
//

import Foundation

struct University: Identifiable, Decodable {
    let id: UUID
    let name: String
    let city: String
    let description: String?
    let year: Int
    let image: String
}

extension University {
    static let storeKey = "savedUniversities"
}
