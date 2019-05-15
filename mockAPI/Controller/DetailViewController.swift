//
//  DetailViewController.swift
//  mockAPI
//
//  Created by Francesco Maria Moneta (BFS EUROPE) on 13/05/2019.
//  Copyright © 2019 wipro.com. All rights reserved.
//

import UIKit


class DetailViewController : UIViewController {
    
    var post : Post!                       //Will always be passed
    var origin : PostsTableViewController! //will always be initialized
    
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
    
    let idText : UITextField = {
        var id = UITextField()
        id.isEnabled = false
        id.addTarget(self, action: #selector(onTextFieldChange(sender:)), for: .allEditingEvents)
        return id
    }()
    
    let userIdText : UITextField = {
        var userId = UITextField()
        userId.isEnabled = false
        userId.addTarget(self, action: #selector(onTextFieldChange(sender:)), for: .allEditingEvents)
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
        mb.isSelected = false
        mb.setTitle("Modifiy", for: .normal)
        mb.setTitle("Save Changes", for: .selected)
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
        loadTextValues()
        setupStackView()
    }
    
    func setupStackView(){
        buttonStackView.addArrangedSubview(removeButton)
        buttonStackView.addArrangedSubview(modifyButton)
    }
    
    
    func loadTextValues(){
        guard let p = post else{
            return
        }
        titleText.text = p.title//.capitalized //justforfun
        idText.text = String(p.id)
        userIdText.text = String(p.userId)
        bodyText.text = p.body
        
        //reset backgrounds
        idText.backgroundColor = .white
        userIdText.backgroundColor = .white
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
    
    @objc func onTextFieldChange(sender: UITextField){
        guard let t = sender.text else{
            sender.backgroundColor = .red
            return
        }
        if Int(t) == nil {
            sender.backgroundColor = .red
        }
        else {
            sender.backgroundColor = .white
        }
    }
    
    @objc func removePost(){
        guard let originGuarded = origin else{
            return
        }
        origin.removePost(index: originGuarded.currentlySelected)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func toggleModify(){
        modifyButton.isSelected.toggle()
        if modifyButton.isSelected == true{
            removeButton.isEnabled = true
            titleText.isEditable = true
            idText.isEnabled = true
            userIdText.isEnabled = true
            bodyText.isEditable = true
        }
        else{
            removeButton.isEnabled = false
            titleText.isEditable = false
            idText.isEnabled = false
            userIdText.isEnabled = false
            bodyText.isEditable = false
            savePost()
            loadTextValues()
        }
    }
    
    func savePost(){
        post.title = titleText.text
        post.body = bodyText.text
        var x : Int = Int(idText.text!) ?? post.id
        post.id = x
        x = Int(userIdText.text!) ??  post.userId
        post.userId = x
        origin.changePost(p: post, index: origin.currentlySelected)
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
