//
//  Universities.swift
//  SummerSchool
//
//  Created by Dan, Radu-Ionut on 04.08.2021.
//

import Foundation

final class Universities: ObservableObject {
    
    private static let allUniversities: [University] = Bundle.main.decode("universities.json")
    
    @Published var universities: [University] = allUniversities
    
    func reloadUniversities() {
        universities = Self.allUniversities
    }
    
    func loadFavouriteUniversities() {
        universities = Self.allUniversities.filter { $0.isFavourite }
    }
    
}

extension University {
    var isFavourite: Bool {
        get {
            guard let storedIDs = UserDefaults.standard.stringArray(forKey: University.storeKey) else {
                return false
            }
            
            return storedIDs.contains(id.uuidString)
        }
        set {
            let idString = id.uuidString
            let userDefaults = UserDefaults.standard
            var storedIDs = userDefaults.stringArray(forKey: University.storeKey) ?? []
            
            if let index = storedIDs.firstIndex(where: { $0 == idString }) {
                storedIDs.remove(at: index)
            } else {
                storedIDs.append(idString)
            }
            
            userDefaults.setValue(storedIDs, forKey: University.storeKey)
        }
    }
}
