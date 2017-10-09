//
//  User.swift
//  AtlanTeamTest
//
//  Created by Vladislav Andreev on 05.10.17.
//  Copyright © 2017 Vladislav Andreev. All rights reserved.
//

import Foundation

struct User {

    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address?
    let phone: String
    let website: String
    let company: Company?
}


struct UsersArray {
    
    let items: [User]
    
    init(serialization: [Serialization]) {
        items = serialization.map{serialization in User(serialization: serialization)}
    }
}

extension User {
    private enum Keys: String, SerializationKey {
        case id
        case name
        case username
        case email
        case address
        case phone
        case website
        case company
    }
    
    init(serialization: Serialization) {

        id = serialization.value(forKey: Keys.id)!
        name = serialization.value(forKey: Keys.name)!
        username = serialization.value(forKey: Keys.username)!
        email = serialization.value(forKey: Keys.email)!
        
        if let addressSerialization: Serialization = serialization.value(forKey: Keys.address) {
            address = Address(serialization: addressSerialization)
        } else {
            address = nil
        }
        
        phone = serialization.value(forKey: Keys.phone)!
        website = serialization.value(forKey: Keys.website)!

        
        if let companySerialization: Serialization = serialization.value(forKey: Keys.company) {
            company = Company(serialization: companySerialization)
        } else {
            company = nil
        }
        
        
    }
}
