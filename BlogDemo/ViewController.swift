//
//  ViewController.swift
//  BlogDemo
//
//  Created by Michael Redig on 5/5/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	@IBOutlet var lettersStackView: UIStackView!
	@IBOutlet var buttonStackView: UIStackView!

	@IBAction func wigglePressed(_ sender: UIButton) {
	}

	@IBAction func flourishPressed(_ sender: UIButton) {
		// disable buttons so that we dont have overlapping animations
		disableButtons()
		// run this animation on *each* individual letter
		for (index, letter) in lettersStackView.subviews.enumerated() {
			// 1. get frame position
			let oldFrame = letter.frame
			// 2. set anchor point, which as a byproduct, moves the position
			letter.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
			// 3. reposition back into the old position, now that the anchor point is correct for this animation
			letter.frame = oldFrame

			// 4. we only want to enable the buttons again after the FINAL letter animation finishes
			var completionButtonEnabler: ((Bool) -> Void)? = nil
			if index == lettersStackView.subviews.count - 1 {
				completionButtonEnabler = enableButtons
			}

			// 5. set delay per letter so it has a *wave* effect
			let delay = TimeInterval(index) * 0.05
			UIView.animateKeyframes(withDuration: 0.3, delay: delay, options: [], animations: {
				// 6. squash animation
				UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.8, animations: {
					letter.transform = CGAffineTransform(scaleX: 1.8, y: 0.5)
				})
				// 6. jump animation
				UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.33, animations: {
					letter.transform = CGAffineTransform(scaleX: 0.5, y: 2.2)
				})
			}) { _ in //completion closure here, btw
				// 7. return to 'identity' (original state), but with a spring animation
				UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
					letter.transform = .identity
				}, completion: completionButtonEnabler)
			}
		}
	}

	@IBAction func rainbowPressed(_ sender: UIButton) {
	}

	func disableButtons() {
		for case let button as UIButton in buttonStackView.subviews {
			button.isEnabled = false
		}
	}

	func enableButtons(_ enable: Bool) {
		for case let button as UIButton in buttonStackView.subviews {
			button.isEnabled = true
		}
	}

}
