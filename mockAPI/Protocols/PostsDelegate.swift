//
//  postsDelegate.swift
//  mockAPI
//
//  Created by Francesco Maria Moneta (BFS EUROPE) on 13/05/2019.
//  Copyright © 2019 wipro.com. All rights reserved.
//

import Foundation


protocol PostsDelegate {
    func setNumberOfPosts(number : Int)
    func changePost(p : Post, index : Int)
    func removePost(index : Int)
}

