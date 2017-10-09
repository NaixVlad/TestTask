//
//  Comment.swift
//  AtlanTeamTest
//
//  Created by Vladislav Andreev on 05.10.17.
//  Copyright © 2017 Vladislav Andreev. All rights reserved.
//

import Foundation

struct Comment {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}

extension Comment {
    private enum Keys: String, SerializationKey {
        case postId
        case id
        case name
        case email
        case body
    }
    
    init(serialization: Serialization) {
        postId = serialization.value(forKey: Keys.postId)!
        id = serialization.value(forKey: Keys.id)!
        name = serialization.value(forKey: Keys.name)!
        email = serialization.value(forKey: Keys.email)!
        body = serialization.value(forKey: Keys.body)!
        
    }
}
