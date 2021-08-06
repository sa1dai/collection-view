//
//  ProductSections.swift
//  markup-test
//
//  Created by Max Boychenko on 05.08.2021.
//

import Foundation
import UIKit

struct ProductSectionList {
    private let sections: [ProductSection]
    
    subscript(index: Int) -> ProductSection {
        sections[index]
    }
    
    var sectionsCount: Int {
        sections.count
    }
    
    func getProductTitle(by indexPath: IndexPath) -> String {
        sections[indexPath.section].products[indexPath.item].title
    }
    
    func getProductImage(by indexPath: IndexPath) -> UIImage? {
        UIImage(named: sections[indexPath.section].products[indexPath.item].imagePath)
    }
    
    static func mock() -> ProductSectionList {
        let productTitles = ["Слива сезонная", "Йогурт", "Батончик фруктовый"]
        let productMealTitles = ["Ветчина", "Окорок свиной бескостный", "Бургер из говядины"]
        var sections: [ProductSection] = []
        let mockProduct = {() -> Product in
            let randomProductIndex = Int.random(in: 0...2)
            return Product(
                title: productTitles[randomProductIndex],
                imagePath: "Product-\(randomProductIndex + 1)"
            )
        }
        sections.append(
            ProductSection(
                title: "Сегодня в тренде",
                products: (1...9).map { _ in mockProduct() }
            )
        )
        let mockMealProduct = {() -> Product in
            let randomProductIndex = Int.random(in: 0...2)
            return Product(
                title: productMealTitles[randomProductIndex],
                imagePath: "Product-Meal-\(randomProductIndex + 1)"
            )
        }
        sections.append(
            ProductSection(
                title: "Мясо",
                products: (1...12).map { _ in mockMealProduct() }
            )
        )
        return ProductSectionList(sections: sections)
    }
}
