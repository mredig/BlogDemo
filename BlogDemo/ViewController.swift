//
//  ViewController.swift
//  BlogDemo
//
//  Created by Michael Redig on 5/5/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	let iterations = 999_999

	var uuidArray = [UUID]()
	var stringArray = [String]()

	var percentageMatch = 0.2 // double between 0 and 1 (0 - 100%)

	let baseID = UUID()

	@IBOutlet var textView: UITextView!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.


		let matchingCount = Int(Double(iterations) * percentageMatch)
		let unmatchingCount = Int(Double(iterations) * (1 - percentageMatch))

		for _ in 1...matchingCount {
			uuidArray.append(baseID)
			stringArray.append(baseID.uuidString)
		}

		for _ in 1...unmatchingCount {
			let unmatchedID = UUID()
			uuidArray.append(unmatchedID)
			stringArray.append(unmatchedID.uuidString)
		}

		uuidArray.shuffle()
		uuidArray.shuffle()
		uuidArray.shuffle()

		stringArray.shuffle()
		stringArray.shuffle()
		stringArray.shuffle()

		NSLog("ready")
	}


	@IBAction func goPressed(_ sender: UIButton) {
		benchmarkComparisons()
	}
	func benchmarkComparisons() {
		let startuuidTime = CFAbsoluteTimeGetCurrent()
		var matches = 0
		for compareID in uuidArray {
			matches = baseID == compareID ? matches + 1 : matches
		}
		let enduuidTime = CFAbsoluteTimeGetCurrent()
		textView.text = "uuid done (\(matches))...\n"

		let startStringTime = CFAbsoluteTimeGetCurrent()
		let baseString = baseID.uuidString
		matches = 0
		for compareString in stringArray {
			matches = baseString == compareString ? matches + 1 : matches
		}
		let endStringTime = CFAbsoluteTimeGetCurrent()
		textView.text += "string done (\(matches))...\n"

		textView.text += "uuid duration: \(enduuidTime - startuuidTime)\n"
		textView.text += "string duration: \(endStringTime - startStringTime)\n"
	}
}

