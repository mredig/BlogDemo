//
//  PersonSearchTableViewController.swift
//  Find a Crew
//
//  Created by Michael Redig on 5/7/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit

class PersonSearchTableViewController: UITableViewController {

	@IBOutlet var searchBar: UISearchBar!
	private let personController = PersonController()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
}

extension PersonSearchTableViewController {
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return personController.people.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "PersonTableViewCell", for: indexPath)

		guard let personCell = cell as? PersonTableViewCell else { return cell }
		personCell.person = personController.people[indexPath.row]
		return personCell
	}
}

extension PersonSearchTableViewController: UISearchBarDelegate {

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
		guard let searchTerm = searchBar.text else { return }
		personController.searchForPeople(with: searchTerm) { [weak self] in
			DispatchQueue.main.async {
				self?.tableView.reloadData()
			}
		}
	}
}

