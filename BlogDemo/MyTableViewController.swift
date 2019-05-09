//
//  MyTableViewController.swift
//  BlogDemo
//
//  Created by Michael Redig on 5/5/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {

	var dataArray: [Int] = (1...10).map { $0 }

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		configureRefresh()
	}

	func configureRefresh() {
		tableView.refreshControl = UIRefreshControl()
		tableView.refreshControl?.addTarget(self, action: #selector(refreshMahDatas), for: .valueChanged)
	}

	@objc func refreshMahDatas() {
		// simulating a network delay
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			self.dataArray = self.dataArray.map { $0 + 3 }
			self.tableView.refreshControl?.endRefreshing()
			self.tableView.reloadData()
		}
	}

}

extension MyTableViewController {


	override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

		let firstAction = UIContextualAction(style: .normal, title: "Delete or Something") { (action, //a reference to the action (firstAction in this case)
			view, // source view in which action was displayed
			handler //The handler block for you to execute after you have performed the action. This block has no return value and takes the following parameter:
				//actionPerformed:
					//A Boolean value indicating whether you performed the action. Specify true if you performed the action or false if you were unable to perform the action for some reason.
			) in
			// do stuff like deleting the data and then the row here
			print("BELETED.")
			handler(false)
			//I don't totally understand the handler. You're supposed to pass it `true` if whatever your operation is was a success, or false if it failed... but it behaves the same either way
		}
		firstAction.backgroundColor = .red

		//and again easier to read without all the comments
		let secondAction = UIContextualAction(style: .normal, title: "1up") { (action, view, handler) in
			//gamify your app here
			print("You scored a 1up")
			handler(true)
		}
		secondAction.backgroundColor = UIColor(red: 0.1, green: 0.8, blue: 0.3, alpha: 1.0)

		return UISwipeActionsConfiguration(actions: [firstAction, secondAction])
	}

	override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let leadingAction = UIContextualAction(style: .normal, title: "Mark as 'supafly'") { (action, view, handler) in
			print("View '\(view)' is now supafly")
			handler(true)
		}
		leadingAction.backgroundColor = UIColor(red: 0.1, green: 0.4, blue: 0.9, alpha: 1.0)

		return UISwipeActionsConfiguration(actions: [leadingAction])

	}



	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataArray.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

		let dataValue = dataArray[indexPath.row]
		cell.textLabel?.text = "Cell \(dataValue)"
		return cell
	}
}
