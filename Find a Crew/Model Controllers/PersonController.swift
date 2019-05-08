//
//  PersonController.swift
//  Find a Crew
//
//  Created by Michael Redig on 5/7/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import Foundation

class PersonController {
	let baseURL = URL(string: "https://swapi.co/api/people/")!
	var people = [Person]()

	enum HTTPMethod: String {
		case get = "GET"
		case post = "POST"
		case put = "PUT"
		case delete = "DELETE"
	}

	func searchForPeople(with searchTerm: String, wookieeMode: Bool = false, completion: @escaping () -> Void) {
		var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
		let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
		let formatStr = wookieeMode ? "wookiee" : "json"
		let format = URLQueryItem(name: "format", value: formatStr)
		urlComponents?.queryItems = [searchTermQueryItem, format]

		guard let requestURL = urlComponents?.url else {
			print("request url is nil")
			completion()
			return
		}
		var request = URLRequest(url: requestURL)
		request.httpMethod = HTTPMethod.get.rawValue

//		URLSession.shared.dataTask(with: <#T##URL#>, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)

		URLSession.shared.dataTask(with: request) { (data, _, error) in
			if let error = error {
				print("error fetching data: \(error)")
//				completion()
			}

			guard let data = data else {
				print("no data returned")
//				completion()
				return
			}

			let decoder = JSONDecoder()
//			decoder.keyDecodingStrategy = .convertFromSnakeCase
			do {
				let convertedData = try decoder.decode(PersonSearch.self, from: data)
				self.people = convertedData.results
			} catch {
				print("error decoding data: \(error)")
			}
			completion()
		}.resume()
	}
}
