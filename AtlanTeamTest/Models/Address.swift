//
//  Address.swift
//  AtlanTeamTest
//
//  Created by Vladislav Andreev on 05.10.17.
//  Copyright © 2017 Vladislav Andreev. All rights reserved.
//

import Foundation

struct Address {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Location?
}

extension Address {
    private enum Keys: String, SerializationKey {
        case street
        case suite
        case city
        case zipcode
        case geo
    }
    
    init(serialization: Serialization) {
        street = serialization.value(forKey: Keys.street)!
        suite = serialization.value(forKey: Keys.suite)!
        city = serialization.value(forKey: Keys.city)!
        zipcode = serialization.value(forKey: Keys.zipcode)!
        
        if let geoSerialization: Serialization = serialization.value(forKey: Keys.geo) {
            geo = Location(serialization: geoSerialization)
        } else {
            geo = nil
        }
        
    }
}
