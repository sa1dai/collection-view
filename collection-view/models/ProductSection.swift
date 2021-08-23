//
//  ProductSection.swift
//  markup-test
//
//  Created by Max Boychenko on 05.08.2021.
//

import Foundation

struct ProductSection {
	let title: String
	let products: [Product]
	
	var productsCount: Int {
		products.count
	}
}
