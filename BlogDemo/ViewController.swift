//
//  ViewController.swift
//  BlogDemo
//
//  Created by Michael Redig on 5/5/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	var embeddedTableViewController: EmbeddedTableViewController? {
		didSet {
			embeddedTableViewController?.muhDatas = ["Yo dawg, I heard you like embedding view controllers, so I put a view controller in your view controller so you can control views while you control views."]
		}
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "EmbedTableController" {
			guard let dest = segue.destination as? EmbeddedTableViewController else { return }
			embeddedTableViewController = dest
			// now I can access the embedded controller and give it data or make it respond to button presses or whatnot
		}
	}
}

