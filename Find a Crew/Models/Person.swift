//
//  Person.swift
//  Find a Crew
//
//  Created by Michael Redig on 5/7/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import Foundation


struct Person: Decodable {
	let name: String
	let gender: Gender
	let birthYear: String
	let height: Int
	let mass: Int
	let hairColor: String
	let skinColor: String
	let eyeColor: String

	enum Gender: String {
		case male
		case female
		case na
		static func genderForString(_ string: String) -> Gender {
			let lc = string.lowercased()
			switch lc {
			case "male":
				return .male
			case "female":
				return .female
			default:
				return .na
			}
		}
	}
}

extension Person {
	enum CodingKeys: String, CodingKey {
		case name
		case gender
		case birthYear = "birth_year"
		case height
		case mass
		case hairColor = "hair_color"
		case skinColor = "skin_color"
		case eyeColor = "eye_color"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		name = try container.decode(String.self, forKey: .name)
		let genderStr = try container.decode(String.self, forKey: .gender)
		gender = Gender.genderForString(genderStr)
		birthYear = try container.decode(String.self, forKey: .birthYear)
		let heightStr = try container.decode(String.self, forKey: .height)
		height = Int(heightStr) ?? 0
		let massStr = try container.decode(String.self, forKey: .mass)
		mass = Int(massStr) ?? 0
		hairColor = try container.decode(String.self, forKey: .hairColor)
		skinColor = try container.decode(String.self, forKey: .skinColor)
		eyeColor = try container.decode(String.self, forKey: .eyeColor)
	}
}

struct PersonSearch: Decodable {
	let results: [Person]
}
