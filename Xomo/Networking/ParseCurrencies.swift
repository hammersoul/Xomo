//
//  ParseCurrencies.swift
//  Xomo
//

import Foundation
import SwiftSoup

final class ParseCurrencies {
    
    static let shared = ParseCurrencies()
    
    var url = "https://crypto.com/price?page="
    public  var currencies = [CurrencyModel]()
    
    // MARK: Currencies Parsing
    
    func parse(completion: @escaping (([CurrencyModel]) -> Void), page: String = "1") {
        DispatchQueue.global().asyncAfter(deadline: .now()) { [weak self] in
            if let url = URL(string: self!.url + page) {
                do {
                    let html = try String(contentsOf: url)
                    let document: Document = try SwiftSoup.parse(html)
                    
                    let elementsName: Elements = try document.getElementsByClass("css-87yt5a").select("p")
                    let elementsTicker: Elements = try document.getElementsByClass("css-87yt5a").select("span")
                    let elementsPriceOne: Elements = try document.getElementsByClass("chakra-text css-13hqrwd")
                    let elementsPriceTwo: Elements = try document.getElementsByClass("css-vtw5vj").select("p")
                    
                    for index in 0..<elementsName.count {
                        let currency = try CurrencyModel(name: elementsName[index].text(), ticker: elementsTicker[index].text(), priceOne: elementsPriceOne[index].text(), priceTwo: elementsPriceTwo[index].text())
                                                
                        self?.currencies.append(currency)
                    }
                    
                    completion(self?.currencies ?? [])
                } catch {
                    print("Error get currencies")
                }
            }
        }
    }
}
