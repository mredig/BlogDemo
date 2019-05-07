//
//  ViewController.swift
//  BlogDemo
//
//  Created by Michael Redig on 5/5/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet var searchBar: UISearchBar!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		for subview in searchBar.allSubviews() {
			if let selector = subview as? UISegmentedControl {
				selector.tintColor = .yellow
				subview.backgroundColor = .clear
			}
		}
	}


}

