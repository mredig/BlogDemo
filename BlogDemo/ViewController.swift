//
//  ViewController.swift
//  BlogDemo
//
//  Created by Michael Redig on 5/5/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet var dataLabel: UILabel!
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

		DispatchQueue.global().async {
			self.dataLabel.text = "NEW IMPORTANT INFORMATION!!!"
		}
	}


}

