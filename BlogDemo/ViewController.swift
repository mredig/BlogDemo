//
//  ViewController.swift
//  BlogDemo
//
//  Created by Michael Redig on 5/5/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	let fableView = IDontKnowEverything()
	let fakeNetworking = IDoNetworking()

	let fableViewData = ["what I did on my summer vacation", "the first day on my vacation", "I woke up", "Then, I went downtown", "to get a job"]

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		fakeNetworking.delegate = self
		fableView.delegate = self
	}

	@IBAction func fakeATableViewPressed(_ sender: UIButton) {
		fableView.pretendToDisplayData()
	}

	@IBAction func fakeANetworkRequestPressed(_ sender: UIButton) {
		fakeNetworking.goGetSomeDatas()
	}
}

//Fill in the things it doesn't know!
extension ViewController: IDontKnowEverythingDelegate {
	func ignorantClassWantsACountOfStrings(_ ignorantClass: IDontKnowEverything) -> Int {
		return fableViewData.count
	}

	func ignorantClass(_ ignorantClass: IDontKnowEverything, needsStringAtIndex index: Int) -> String {
		return fableViewData[index]
	}
}

//React to new information!
extension ViewController: IDoNetworkingDelegate {
	func iDoNetworking(_ iDoNetworking: IDoNetworking, gotsTheDatas datas: [String]) {
		print("I gots the datas: [\(datas)]")
	}
}
