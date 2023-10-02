//
//  ParseCurrencies.swift
//  Xomo
//

import Foundation
import SwiftSoup

final class ParseCurrencies {
    
    static let shared = ParseCurrencies()
    
    var url = "https://crypto.com/price"
    public var currencies = [CurrencyModel]()
    
    // MARK: Parsing Currencies
    
    func parse(completion: @escaping (([CurrencyModel]) -> Void)) {
        DispatchQueue.global().asyncAfter(deadline: .now()) { [weak self] in
            if let url = URL(string: self!.url) {
                do {
                    let html = try String(contentsOf: url)
                    let document: Document = try SwiftSoup.parse(html)
                    
                    let elementsName: Elements = try document.getElementsByClass("css-87yt5a").select("p")
                    let elementsTicker: Elements = try document.getElementsByClass("css-87yt5a").select("span")
                    let elementsPrice: Elements = try document.getElementsByClass("chakra-text css-13hqrwd")
                    let elementsChange: Elements = try document.getElementsByClass("css-vtw5vj").select("p")
                    let elementsURL: Elements = try document.getElementsByClass("chakra-link css-tzmkfm")
                    
                    if (elementsName.count == elementsTicker.count && elementsName.count == elementsPrice.count && elementsName.count == elementsChange.count && elementsName.count == elementsURL.count) {
                        for index in 0..<elementsName.count {
                            let currency = try CurrencyModel(name: elementsName[index].text(), ticker: elementsTicker[index].text(), price: elementsPrice[index].text(), change: elementsChange[index].text(), url: elementsURL[index].attr("href"))
                            
                            self?.currencies.append(currency)
                        }
                    } else {
                        completion([])
                    }
                    
                    completion(self?.currencies ?? [])
                } catch {
                    completion([])
                }
            }
        }
    }
    
    // Parse Price and Change
    func priceChange(ticker: String) -> (String, String) {
        var price = String()
        var change = String()
        
        for currecny in currencies {
            if currecny.ticker == ticker {
                price = currecny.price
                change = currecny.change
                
                break
            }
        }
        
        return (price, change)
    }
}
