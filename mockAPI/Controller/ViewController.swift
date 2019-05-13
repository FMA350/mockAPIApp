//
//  ViewController.swift
//  mockAPI
//
//  Created by Francesco Maria Moneta (BFS EUROPE) on 11/05/2019.
//  Copyright © 2019 wipro.com. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    let numericField : UITextField = {
       let nf = UITextField()
        nf.borderStyle = .line
        nf.textAlignment = .center
        nf.backgroundColor = .lightGray
        nf.placeholder = "Number of posts"
        nf.keyboardType = UIKeyboardType.numberPad
        nf.addTarget(self, action: #selector(onTextFieldChange), for: .editingChanged)
       return nf
    }()
    
    let loadButton : UIButton = {
       let lb = UIButton()
        lb.setTitle("Load", for: .normal)
        lb.setTitleColor(.black, for: .normal)
        lb.setTitleColor(.white, for: .disabled)
        lb.isEnabled = false
        lb.backgroundColor = .green
        lb.addTarget(self, action: #selector(onLoadButtonTouch), for: .touchUpInside)
        return lb
    }()
    
    var textFieldValue : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstrains()
    }
    
    func addSubviews(){
        view.addSubview(numericField)
        view.addSubview(loadButton)
    }
    
    func setupConstrains(){
        //TODO: check constraints for other devices (tested on Xr)
        view.translatesAutoresizingMaskIntoConstraints = true
        setupNumericFieldConstrains()
        setupLoadButtonConstraints()
    }
    
    func setupNumericFieldConstrains(){
        
        numericField.translatesAutoresizingMaskIntoConstraints = false
        numericField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        numericField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        numericField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        numericField.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func setupLoadButtonConstraints(){
        loadButton.translatesAutoresizingMaskIntoConstraints = false
        loadButton.topAnchor.constraint(equalTo: numericField.bottomAnchor, constant: 25).isActive = true
        loadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loadButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    
    //ACTIONS
    @objc func onTextFieldChange(){
        //if text is empty
        guard let t = numericField.text else{
            return
        }
        //if text is not a valid integer
        guard let value = Int(t) else{
            loadButton.isEnabled = false
            numericField.backgroundColor = .red
            return
        }
        //if value is negative
        if value < 0 {
            return
        }
        //else if value is acceptable
        textFieldValue = value
        loadButton.isEnabled = true
        numericField.backgroundColor = .lightGray
    }
    
    @objc func onLoadButtonTouch(){
        performSegue(withIdentifier: "toTableViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTableViewController" {
            let vc = segue.destination as! PostsDelegate
            vc.setNumberOfPosts(number: textFieldValue)
            
        }
    }

}

