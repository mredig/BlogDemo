//
//  EmbeddedTableViewController.swift
//  BlogDemo
//
//  Created by Michael Redig on 5/6/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit

class EmbeddedTableViewController: UITableViewController {

	var muhDatas: [String] = [] {
		didSet {
			guard isViewLoaded else { return }
			tableView.reloadData()
		}
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return muhDatas.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.textLabel?.text = muhDatas[indexPath.row]
		return cell
	}
}
