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

	override func viewDidLoad() {
		enableButtons(true)
	}


	var enableWiggle = false
	@IBAction func wigglePressed(_ sender: UIButton) {
		enableButtons(false)
		enableWiggle = true
		// start a random wiggle animation on each letter
		for letter in lettersStackView.subviews {
			animateWiggle(on: letter)
		}
	}

	@IBAction func stopWigglePressed(_ sender: UIButton) {
		enableWiggle = false
	}
	
	func animateWiggle(on view: UIView) {

		// generate the wiggle animation
		let animation = {
			let randomTransform = CGAffineTransform(scaleX: CGFloat.random(in: 0.8...1.2), y: CGFloat.random(in: 0.8...1.2))
			view.transform = randomTransform
		}

		// animate with the generated animation. on completion, either repeat this func, or if wiggle is disabled, run the finish wiggle func
		UIView.animate(withDuration: TimeInterval.random(in: 0.08...0.12), animations: animation) { [weak self] _ in
			if self?.enableWiggle ?? false {
				self?.animateWiggle(on: view)
			} else {
				self?.finishWiggle(on: view)
			}
		}
	}

	func finishWiggle(on view: UIView) {
		UIView.animate(withDuration: 0.1, animations: {
			//return each letter to its original state
			view.transform = .identity
		//reenable the buttons
		}, completion: enableButtons)
	}

	@IBAction func flourishPressed(_ sender: UIButton) {
		// disable buttons so that we dont have overlapping animations
//		disableButtons()
		enableButtons(false)
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

	// this button logic isn't perfect since it enables the stop wiggle even when theres no wiggling... but its late and im tired
	func enableButtons(_ enable: Bool) {
		for case let button as UIButton in buttonStackView.subviews {
			button.isEnabled = enable
			if button.tag == 1 {
				button.isEnabled = !enable
			}
		}
	}

}
