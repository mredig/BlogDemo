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
		for (index, letter) in lettersStackView.subviews.enumerated() {
//			let animation = {
//				let randomTransform = CGAffineTransform(scaleX: CGFloat.random(in: 0.8...1.2), y: CGFloat.random(in: 0.8...1.2))
//				letter.transform = randomTransform
//			}
//			UIView.animate(withDuration: 0.1, animations: animation) { _ in
//				UIView.animate(withDuration: 0.1, animations: animation, completion: nil)
//			}
			animateWiggle(on: letter)
		}
	}

	@IBAction func stopWigglePressed(_ sender: UIButton) {
		enableWiggle = false
	}
	
	func animateWiggle(on view: UIView) {
		let animation = {
			let randomTransform = CGAffineTransform(scaleX: CGFloat.random(in: 0.8...1.2), y: CGFloat.random(in: 0.8...1.2))
			view.transform = randomTransform
		}

		UIView.animate(withDuration: TimeInterval.random(in: 0.08...0.12), animations: animation) { [weak self] _ in
			if self?.enableWiggle ?? false {
				self?.animateWiggle(on: view)
			} else {
				self?.finishWiggle(on: view)
			}
		}
	}

	func finishWiggle(on view: UIView) {
		UIView.animate(withDuration: 0.1) { [weak self] in
			view.transform = .identity
			self?.enableButtons(true)
		}
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

	@IBAction func rainbowPressed(_ sender: UIButton) {

		for (index, letter) in lettersStackView.subviews.enumerated() {
			guard let letter = letter as? UILabel else { continue }

//			let colorKeyframeAnimation = CAKeyframeAnimation(keyPath: "textColor")
//
//			colorKeyframeAnimation.values = [UIColor.red.cgColor,
//											 UIColor.green.cgColor,
//											 UIColor.blue.cgColor]
//			colorKeyframeAnimation.keyTimes = [0, 0.5, 1]
//			colorKeyframeAnimation.duration = 2
//			letter.layer.add(colorKeyframeAnimation, forKey: nil)
			let delay = TimeInterval(index) * 0.05
//			UIView.animateKeyframes(withDuration: 3, delay: delay, options: [], animations: {
//				UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
//					let changeColor = CATransition()
//					changeColor.duration = 1.5
//					CATransaction.begin()
//					CATransaction.setCompletionBlock {
//						letter.layer.add(changeColor, forKey: nil)
//						letter.textColor = UIColor(hue: 1, saturation: 1, brightness: 1, alpha: 1)
//					}
//					CATransaction.commit()
//				})
//				UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
//					let changeColor = CATransition()
//					changeColor.duration = 1.5
//					CATransaction.begin()
//					CATransaction.setCompletionBlock {
//						letter.layer.add(changeColor, forKey: nil)
//						letter.textColor = UIColor(hue: 0, saturation: 1, brightness: 0, alpha: 1)
//					}
//					CATransaction.commit()
//				})
//			}, completion: nil)

			UIView.animate(withDuration: 1.5, delay: delay, options: [], animations: {
				let changeColor = CATransition()
				changeColor.duration = 1.5
				CATransaction.begin()
				CATransaction.setCompletionBlock {
					letter.layer.add(changeColor, forKey: nil)
					letter.textColor = UIColor(hue: 1, saturation: 1, brightness: 1, alpha: 1)
				}
				CATransaction.commit()
			}) { _ in
				UIView.animate(withDuration: 1.5, animations: {
					let changeColor = CATransition()
					changeColor.duration = 1.5
					CATransaction.begin()
					CATransaction.setCompletionBlock {
						letter.layer.add(changeColor, forKey: nil)
						letter.textColor = UIColor(hue: 0, saturation: 1, brightness: 0, alpha: 1)
					}
					CATransaction.commit()
				}, completion: nil)
			}
		}
	}

//	func disableButtons() {
//		for case let button as UIButton in buttonStackView.subviews {
//			button.isEnabled = false
//		}
//	}

	func enableButtons(_ enable: Bool) {
		for case let button as UIButton in buttonStackView.subviews {
			button.isEnabled = enable
			if button.tag == 1 {
				button.isEnabled = !enable
			}
		}
	}

}
