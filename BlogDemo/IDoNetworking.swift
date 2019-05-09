//
//  IDoNetworking.swift
//  BlogDemo
//
//  Created by Michael Redig on 5/9/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import Foundation

protocol IDoNetworkingDelegate: AnyObject {
	func iDoNetworking(_ iDoNetworking: IDoNetworking, gotsTheDatas datas: [String])
}

//MARK:- this part acts something like a network manager
class IDoNetworking {

	weak var delegate: IDoNetworkingDelegate?

	/**
	This isn't the best example because networking in iOS is typically done with closures, but this still demonstrates the idea that delegates can be informed after a lengthy operation completes without bogging down the main thread and UI.
	*/
	public func goGetSomeDatas() {
		// simulating a delayed network request by delaying a closure
		DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 3) { [weak self] in
			let gottenDatas = ["There's always money in the banana stand!", "I heard the jury's still out on... science...", "(In low, gravelly voice) ...Michael.."]
			print("fake network request successful")
			guard let self = self else { return }
			self.delegate?.iDoNetworking(self, gotsTheDatas: gottenDatas)
		}
	}
}
