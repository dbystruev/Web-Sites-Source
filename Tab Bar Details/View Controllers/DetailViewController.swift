//
//  DetailViewController.swift
//  Tab Bar Details
//
//  Created by Denis Bystruev on 23/05/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var lineLabel: UILabel!
    var line: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        lineLabel.text = line
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}
