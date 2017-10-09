//
//  ServerResource.swift
//  AtlanTeamTest
//
//  Created by Vladislav Andreev on 05.10.17.
//  Copyright © 2017 Vladislav Andreev. All rights reserved.
//

import Foundation

let baseUrl = "https://jsonplaceholder.typicode.com/"

protocol SerializationObject {}

extension Dictionary: SerializationObject {}
extension Array: SerializationObject {}


protocol ServerResource {
    associatedtype Model
    var url: URL {get}
    var methodPath: String { get }
    func makeSerialization<T: SerializationObject>(serialization: T) -> Model
}

extension ServerResource {

    func makeModel(data: Data) -> Model? {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else {
            return nil
        }
        
        if let jsonDictionary = json as? Serialization {
            return makeSerialization(serialization: jsonDictionary)
        }
        
        
        if let jsonArray = json as? [Serialization] {
            return makeSerialization(serialization: jsonArray)
        }
        
        

        return  nil
    }
}


//Single Resource

protocol SingleResource: ServerResource {
    associatedtype SingleResourceModel
    var id: Int {get}
    func makeModel(serialization: Serialization) -> SingleResourceModel
}


extension SingleResource {
    var url: URL {
        get {
            return URL(string:baseUrl + methodPath + id.description)!
        }
    }
    
    func makeSerialization<T>(serialization: T) -> SingleResourceModel where T: SerializationObject {
        return makeModel(serialization: serialization as! Serialization)
    }

}

//Array Resource

protocol ArrayResource: ServerResource {
    associatedtype ArrayResourceModel
    func makeModel(serialization: [Serialization]) -> ArrayResourceModel
    
}

extension ArrayResource {
    var url: URL {
        get {
            return URL(string:baseUrl + methodPath)!
        }
    }
    
    func makeSerialization<T>(serialization: T) -> ArrayResourceModel where T : SerializationObject {
        return makeModel(serialization: serialization as! [Serialization])
    }

}

//Single resources model

struct PostResource: SingleResource {

    

    let methodPath = "posts/"
    var id: Int

    func makeModel(serialization: Serialization) -> Post {
        return Post(serialization: serialization)
    }
    
}


struct CommentResource: SingleResource {
    
    
    let methodPath = "comments/"
    var id: Int

    func makeModel(serialization: Serialization) -> Comment {
        return Comment(serialization: serialization)
    }
    
}

struct UserResource: SingleResource {
    
    let methodPath = "users/"
    var id: Int
    
    func makeModel(serialization: Serialization) -> User {
        return User(serialization: serialization)
    }
    
}

struct PhotoResource: SingleResource {
    
    let methodPath = "photos/"
    var id: Int
    func makeModel(serialization: Serialization) -> Photo {
        return Photo(serialization: serialization)
    }
    
}

struct TodoResource: SingleResource {
    
    
    
    let methodPath = "todos/"
    var id: Int
    func makeModel(serialization: Serialization) -> Task {
        return Task(serialization: serialization)
    }
    
}

//Array resource model


struct UsersArrayResource: ArrayResource {
    

    let methodPath = "users/"
    func makeModel(serialization: [Serialization]) -> UsersArray {
        return UsersArray(serialization: serialization)
    }
    
}

