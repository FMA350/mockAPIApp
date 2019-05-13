//
//  IOmodule.swift
//  mockAPI
//
//  Created by Francesco Maria Moneta (BFS EUROPE) on 13/05/2019.
//  Copyright © 2019 wipro.com. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


struct Post {
    var id : Int
    var userId : Int
    var title : String
    var body : String
}


class IO{
    
    static func getPosts(numberOfPosts : Int, callback : @escaping (_ posts : [Post]) -> ()){
        let url : String = "https://jsonplaceholder.typicode.com/posts?page=1&_limit=\(numberOfPosts)"
        Alamofire.request(url, method: .get).responseJSON(){
            response in
            if response.result.isSuccess{
                let posts = JSONtoPost(numberOfPosts: numberOfPosts, json: JSON(response.result.value!))
                callback(posts)
            }
            else{
                print("Error! \(response.result.error!)")
            }
        }
    }
    
    static func JSONtoPost(numberOfPosts: Int, json : JSON)-> [Post]{
        var posts : [Post] = []
        let realNumberOfPosts = json.count
        var i : Int = 0
        while(i < realNumberOfPosts){
            posts.append(Post(id: json[i]["id"].int!, userId: json[i]["userId"].int!, title: json[i]["title"].string!, body: json[i]["body"].string!))
            i+=1
        }
        return posts
    }
}

