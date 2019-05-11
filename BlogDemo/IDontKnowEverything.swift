//
//  ClassWithDelegateProtocol.swift
//  BlogDemo
//
//  Created by Michael Redig on 5/9/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import Foundation

protocol IDontKnowEverythingDelegate: AnyObject {

	// tableView-similar related functions
	func ignorantClassWantsACountOfStrings(_ ignorantClass: IDontKnowEverything) -> Int
	func ignorantClass(_ ignorantClass: IDontKnowEverything, needsStringAtIndex index: Int) -> String
}

/**
	This class represents something like a tableView that needs data or a UI item that can customize its behavior. It could also be something like a network class that runs in the background and informs its delegate when data fetching is completed.

	Delegates are simply a pattern of one class not quite having the whole picture and needing some information filled in. You may wonder why these things aren't set via properties, but often times properties just don't cut it, for example when you want to let another class know to react (like updating a list) after a network transaction.
*/
class IDontKnowEverything {

	weak var delegate: IDontKnowEverythingDelegate?

	//MARK:- this acts something like a tableview

	/**
		For the sake of this example, this is just printing an array of strings, but think of it instead as determining and then displaying cells in a tableview

		The power of this method is allowing for you to have a GIGANTIC dataset, but still have your tableView run at extremely smooth speeds since it only loads enough data for what's on screen and then recycles its cells for reuse (that's what the whole `dequeueCellForReuse` is about)
	*/
	func pretendToDisplayData() {
		let count = delegate?.ignorantClassWantsACountOfStrings(self) ?? 0

		let visibleRange = getRangeToShow()
		let upperBound = min(visibleRange.upperBound, count)
		let lowerBound = min(visibleRange.lowerBound, upperBound)
		let visibleRangeOfValidData = lowerBound..<upperBound

		var mahDatas = [String]()
		for index in visibleRangeOfValidData {
			let newString = delegate?.ignorantClass(self, needsStringAtIndex: index) ?? ""
			mahDatas.append(newString)
		}
		print(mahDatas)
	}


	private func getRangeToShow() -> ClosedRange<Int> {
		// a tableview, for example, would do a calculation to see what range of cells are currently visible and generate a range (or something similar) based on that calculation... but for the sake of this example, we'll just return a range
		return 0...20
	}
}


