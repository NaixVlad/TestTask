//
//  Post.swift
//  AtlanTeamTest
//
//  Created by Vladislav Andreev on 05.10.17.
//  Copyright © 2017 Vladislav Andreev. All rights reserved.
//

import Foundation


struct Post {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

extension Post {
    private enum Keys: String, SerializationKey {
        case userId
        case id
        case title
        case body
    }
    
    init(serialization: Serialization) {
        userId = serialization.value(forKey: Keys.userId)!
        id = serialization.value(forKey: Keys.id)!
        title = serialization.value(forKey: Keys.title)!
        body = serialization.value(forKey: Keys.body)!
        
    }
}
