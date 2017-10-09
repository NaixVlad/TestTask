//
//  Company.swift
//  AtlanTeamTest
//
//  Created by Vladislav Andreev on 05.10.17.
//  Copyright © 2017 Vladislav Andreev. All rights reserved.
//

import Foundation


struct Company {
    let name: String
    let catchPhrase: String
    let bs: String
}

extension Company {
    private enum Keys: String, SerializationKey {
        case name
        case catchPhrase
        case bs
    }
    
    init(serialization: Serialization) {
        name = serialization.value(forKey: Keys.name)!
        catchPhrase = serialization.value(forKey: Keys.catchPhrase)!
        bs = serialization.value(forKey: Keys.bs)!
    }
}
