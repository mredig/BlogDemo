//
//  ViewController.swift
//  BlogDemo
//
//  Created by Michael Redig on 5/5/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		let screwyAlphabet = "qiwcghxkberdsljpvumyaoznft"

		// closure 1
		var sortedAlphabet = screwyAlphabet.sorted { (a, b) -> Bool in
			return a < b
		}

		// closure 2
		sortedAlphabet = screwyAlphabet.sorted(by: { (a, b) -> Bool in
			a < b
		})

		// closure 3
		sortedAlphabet = screwyAlphabet.sorted { $0 < $1 }
	}


}

