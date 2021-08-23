//
//  Product.swift
//  markup-test
//
//  Created by Max Boychenko on 05.08.2021.
//

import Foundation

struct Product: Hashable {
	let id = UUID()
	let title: String
	let imagePath: String
}
