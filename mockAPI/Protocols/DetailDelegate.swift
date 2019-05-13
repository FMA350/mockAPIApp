//
//  DetailDelegate.swift
//  mockAPI
//
//  Created by Francesco Maria Moneta (BFS EUROPE) on 13/05/2019.
//  Copyright © 2019 wipro.com. All rights reserved.
//

import Foundation
import UIKit

protocol DetailDelegate {
    func getPostDetails(p: Post)
    func setPreviousVC(previousVC : PostsTableViewController)
}
