//
//  DetailViewController.swift
//  mockAPI
//
//  Created by Francesco Maria Moneta (BFS EUROPE) on 13/05/2019.
//  Copyright © 2019 wipro.com. All rights reserved.
//

import UIKit


class DetailViewController : UIViewController {
    
    var post : Post? = nil
    var origin : PostsTableViewController? = nil
    
    let scrollView : UIScrollView = {
        var sv = UIScrollView()
        return sv
    }()
    
    let background : UIView = {
        var bg = UIView()
        return bg
    }()
    
    
    let titleText : UITextView = {
        var t = UITextView()
        t.textAlignment = .center
        t.font = .systemFont(ofSize: 20)
        t.isEditable = false
        return t
    }()
    
    let idText : UITextView = {
        var id = UITextView()
        id.isEditable = false
        return id
    }()
    
    let userIdText : UITextView = {
        var userId = UITextView()
        userId.isEditable = false
        return userId
    }()
    
    let bodyText : UITextView = {
       var bl = UITextView()
        bl.font =  .systemFont(ofSize: 18)
        bl.isEditable = false
        return bl
    }()
    
    let modifyButton : UIButton = {
        var mb = UIButton(type: .system)
        mb.setTitle("Modifiy", for: .normal)
        mb.setTitle("Save Changes", for: .focused)
        mb.backgroundColor = .yellow
        mb.addTarget(self, action: #selector(toggleModify), for: .touchUpInside)
        return mb
    }()
    
    let removeButton : UIButton = {
        var rb = UIButton(type: .system)
        rb.setTitle("Remove this post", for: .normal)
        rb.isEnabled = false
        rb.setTitleColor(.gray, for: .disabled)
        rb.setTitleColor(.black, for: .normal)
        rb.addTarget(self, action: #selector(removePost), for: .touchUpInside)
        rb.backgroundColor = .red
        return rb
    }()
    
    let buttonStackView : UIStackView = {
        var stackView = UIStackView()
        stackView.alignment = UIStackView.Alignment.bottom
        stackView.distribution = UIStackView.Distribution.equalSpacing
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DetailViewController.dismissKeyboard)))
        addSubviews()
        setupConstraints()
        setupTextValues()
        setupStackView()
    }
    
    func setupStackView(){
        buttonStackView.addArrangedSubview(removeButton)
        buttonStackView.addArrangedSubview(modifyButton)
    }
    
    
    func setupTextValues(){
        guard let p = post else{
            return
        }
        titleText.text = p.title.capitalized
        idText.text = String(p.id)
        titleText.delegate = self
        userIdText.text = String(p.id)
        bodyText.text = p.body
        
    }
    
    func addSubviews(){
        
        view.addSubview(scrollView)
        scrollView.addSubview(background)
        background.addSubview(titleText)
        background.addSubview(idText)
        background.addSubview(userIdText)
        background.addSubview(bodyText)
        background.addSubview(buttonStackView)
    }
    
    func setupConstraints(){
        setupScrollviewConstrains()
        setupBackgroundConstrains()
        setupIdTextConstraints()
        setupUserIdTextConstraints()
        setupTitleTextConstrains()
        setupBodyTextConstrains()
        setupStackViewConstraints()
    }
    
    func setupScrollviewConstrains(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func setupBackgroundConstrains(){
        background.translatesAutoresizingMaskIntoConstraints = false
        background.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        background.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        background.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        background.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        background.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

    }
    
    func setupTitleTextConstrains(){
        titleText.translatesAutoresizingMaskIntoConstraints = false
        titleText.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        titleText.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        titleText.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.2).isActive = true
        titleText.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    func setupIdTextConstraints(){
        idText.translatesAutoresizingMaskIntoConstraints = false
        idText.centerXAnchor.constraint(equalTo: background.centerXAnchor).isActive = true
        idText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: -10).isActive = true
        idText.widthAnchor.constraint(equalTo: background.widthAnchor).isActive = true
        idText.heightAnchor.constraint(equalTo: background.heightAnchor, multiplier: 0.05).isActive = true
    }
    
    func setupUserIdTextConstraints(){
        userIdText.translatesAutoresizingMaskIntoConstraints = false
        userIdText.centerXAnchor.constraint(equalTo: background.centerXAnchor).isActive = true
        userIdText.topAnchor.constraint(equalTo: idText.bottomAnchor, constant: -10).isActive = true
        userIdText.widthAnchor.constraint(equalTo: background.widthAnchor).isActive = true
        userIdText.heightAnchor.constraint(equalTo: background.heightAnchor, multiplier: 0.05).isActive = true
    }
    
    
    func setupBodyTextConstrains(){
        bodyText.translatesAutoresizingMaskIntoConstraints = false
        bodyText.topAnchor.constraint(equalTo: userIdText.bottomAnchor).isActive = true
        bodyText.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        bodyText.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor, multiplier: 0.3).isActive = true
        bodyText.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    func setupStackViewConstraints(){
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.topAnchor.constraint(equalTo: bodyText.bottomAnchor).isActive = true
        buttonStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        buttonStackView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor, multiplier: 0.05).isActive = true
        buttonStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.7).isActive = true
    }
    
    @objc func removePost(){
        guard let originGuarded = origin else{
            return
        }
        origin?.removePost(index: originGuarded.currentlySelected)
        //self.navigationController?.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissKeyboard(){
        print("dismissing")
        view.endEditing(true)
    }
    
    @objc func toggleModify(){
        if titleText.isEditable == false{
            removeButton.isEnabled = true
            titleText.isEditable = true
            idText.isEditable = true
            userIdText.isEditable = true
            bodyText.isEditable = true
            
        }
        else{
            removeButton.isEnabled = false
            titleText.isEditable = false
            idText.isEditable = false
            userIdText.isEditable = false
            bodyText.isEditable = false
            savePost()
        }
    }
    
    func savePost(){
        post?.title = titleText.text
        post?.body = bodyText.text
        var x : Int = Int(idText.text) ??  0
        post?.id = Int(x)
        x = Int(userIdText.text) ??  0
        post?.userId = Int(x)

        guard let postGuarded = post else{
            return
        }
        guard let originGuarded = origin else{
            return
        }
        origin?.changePost(p: postGuarded, index: originGuarded.currentlySelected)
    }
}



extension DetailViewController : DetailDelegate{
    func setPreviousVC(previousVC: PostsTableViewController) {
        origin = previousVC
    }
    
    func getPostDetails(p: Post) {
        post = p
    }
}

extension DetailViewController : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
    }
}
