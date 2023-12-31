//
//  ParseAllExchangers.swift
//  Xomo
//

import Foundation
import SwiftSoup

final class ParseRatingExchangers {
    
    static let shared = ParseRatingExchangers()
    
    var url = "https://wellcrypto.io/ru/exchangers/"
    public var ratingExchangers = [RatingExchangersModel]()
    
    // MARK: Rating Exchanges Parsing
    
    func parse(completion: @escaping (([RatingExchangersModel]) -> Void)) {
        DispatchQueue.global().asyncAfter(deadline: .now()) { [weak self] in
            if let url = URL(string: self!.url) {
                do {
                    let html = try String(contentsOf: url)
                    let document: Document = try SwiftSoup.parse(html)
                    
                    let elementsName: Elements = try document.getElementsByClass("exchange__title")
                    let elementReserve: Elements = try document.getElementsByClass("exchange__reserve").select("nobr")
                    let elementStatus: Elements = try document.getElementsByClass("exchange__status")
                    let elementReviews: Elements = try document.getElementsByClass("exchange__feedback").select("a").select("span")
                    
                    if (elementsName.count == elementReserve.count && elementsName.count == elementStatus.count && elementsName.count == elementReviews.count) {
                        for index in 0..<elementsName.count {
                            let exchanger = try RatingExchangersModel(name: elementsName[index].text(), reserve: "Резерв: " + elementReserve[index].text(), status: elementStatus[index].text(), reviews: "Отзывы: " + elementReviews[index].text(), url: "https://wellcrypto.io" + elementsName[index].attr("href"))
                            
                            self?.ratingExchangers.append(exchanger)
                        }
                    } else {
                        completion([])
                    }
                    
                    completion(self?.ratingExchangers ?? [])
                } catch {
                    completion([])
                }
            }
        }
    }
}
