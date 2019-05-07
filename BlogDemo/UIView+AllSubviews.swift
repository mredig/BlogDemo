//
//  UIView+AllSubview.swift
//  Recipes
//
//  Created by Michael Redig on 5/6/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

extension UIView {
	func allSubviews() -> Set<UIView> {
		var childSubviews = Set(subviews)
		for subview in subviews {
			childSubviews = childSubviews.union(subview.allSubviews())
		}
		return childSubviews
	}
}
