//
//  Location.swift
//  AtlanTeamTest
//
//  Created by Vladislav Andreev on 05.10.17.
//  Copyright © 2017 Vladislav Andreev. All rights reserved.
//

import Foundation

struct Location {
    let latitude: String
    let longitude: String
}

extension Location {
    private enum Keys: String, SerializationKey {
        case lat
        case lng
    }
    
    init(serialization: Serialization) {
        latitude = serialization.value(forKey: Keys.lat)!
        longitude = serialization.value(forKey: Keys.lng)!
    }
}
