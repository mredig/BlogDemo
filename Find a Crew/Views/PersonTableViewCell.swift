//
//  PersonViewCell.swift
//  Find a Crew
//
//  Created by Michael Redig on 5/7/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

	var person: Person? {
		didSet {
			updateViews()
		}
	}

	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var genderLabel: UILabel!
	@IBOutlet var birthYearLabel: UILabel!

	private func updateViews() {
		guard let person = person else { return }

		nameLabel.text = person.name
		genderLabel.text = person.gender.rawValue.capitalized
		birthYearLabel.text = person.birthYear
	}
}
