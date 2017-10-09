//
//  Photo.swift
//  AtlanTeamTest
//
//  Created by Vladislav Andreev on 05.10.17.
//  Copyright © 2017 Vladislav Andreev. All rights reserved.
//

import Foundation

struct Photo {
    let albumId: Int
    let id: Int
    let title: String
    let url: URL?
    let thumbnailUrl: URL?
}

extension Photo {
    private enum Keys: String, SerializationKey {
        case albumId
        case id
        case title
        case url
        case thumbnailUrl
    }
    
    init(serialization: Serialization) {
        albumId = serialization.value(forKey: Keys.albumId)!
        id = serialization.value(forKey: Keys.id)!
        title = serialization.value(forKey: Keys.title)!
        
        if let urlSerialization: String = serialization.value(forKey: Keys.url) {
            url = URL(string: urlSerialization)
        } else {
            url = nil
        }
        
        if let thumbnailUrlSerialization: String = serialization.value(forKey: Keys.thumbnailUrl) {
            thumbnailUrl = URL(string: thumbnailUrlSerialization)
        } else {
            thumbnailUrl = nil
        }
        
        
    }
}
