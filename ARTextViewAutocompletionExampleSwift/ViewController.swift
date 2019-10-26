//
//  ViewController.swift
//  ARTextViewAutocompletionExampleSwift
//
//  Created by Lucas Farah on 9/10/15.
//  Copyright (c) 2015 Lucas Farah. All rights reserved.
//

import UIKit

class ViewController: UITableViewController,UITextViewDelegate {

  @IBOutlet weak var emailTextView: AREmailAutocompleteTextView!
  @IBOutlet weak var allTextView: ARTwitterAutocompleteTextView!
  override func viewDidLoad() {
    super.viewDidLoad()

    // Set a default data source for all ARAutocompleteTextView instances. Otherwise, you can specify the data source on individual text fields via the autocompleteDataSource property or use my default AREmailAutocompleteTextView and ARTwitterAutocompleteTextView like in this sample
    ARAutocompleteTextView.setDefaultAutocompleteDataSource(ARAutocompleteManager.shared())
    
    // Dismiss the keyboard when the user taps outside of a text field
    let singleTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleSingleTap))
    self.view.addGestureRecognizer(singleTap)

  }
  
  @objc func handleSingleTap()
  {
    self.emailTextView.resignFirstResponder()
      self.allTextView.resignFirstResponder()
  }
}

