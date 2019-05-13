//
//  postsTableViewController.swift
//  mockAPI
//
//  Created by Francesco Maria Moneta (BFS EUROPE) on 13/05/2019.
//  Copyright © 2019 wipro.com. All rights reserved.
//

import UIKit

class PostsTableViewController : UITableViewController {
    
    var numberOfPosts : Int = 0
    var currentlySelected : Int = -1
    var posts : [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }

    
    func setupTable(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        
        tableView.dataSource = self
        
        IO.getPosts(numberOfPosts: numberOfPosts){
            (posts) in
            print(posts)
            self.posts = posts
            self.tableView.reloadData()
        }
    }
    
    //tableView methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        cell.textLabel?.text = posts[indexPath.row].title
        cell.detailTextLabel?.text = posts[indexPath.row].body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentlySelected = indexPath.row
        //perform the segue
        performSegue(withIdentifier: "toDetailView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView"{
            let vc = segue.destination as! DetailDelegate
            vc.getPostDetails(p: posts[currentlySelected])
            vc.setPreviousVC(previousVC: self)
        }
    }
    
}

extension PostsTableViewController : PostsDelegate {
    func changePost(p: Post, index: Int) {
        posts[index] = p
        tableView.reloadData()
    }
    
    func removePost(index : Int){
        posts.remove(at: index)
        tableView.reloadData()
    }
    
    
    func setNumberOfPosts(number: Int) {
        numberOfPosts = number
    }
    
    
}
