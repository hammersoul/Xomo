//
//  ParseExchangers.swift
//  Xomo
//

import Foundation
import SwiftSoup

final class ParseExchangers {
    
    static let shared = ParseExchangers()
    
    var url = "https://wellcrypto.io/ru/exchangers/exchange/"
    public var exchangers = [ExchangerModel]()
    
    var giveCurrency = String()
    var receiveCurrency = String()
    
    // MARK: Exchanges Parsing
    
    func parse(completion: @escaping (([ExchangerModel]) -> Void), exchanger: String) {
        DispatchQueue.global().asyncAfter(deadline: .now()) { [weak self] in
            if let url = URL(string: self!.url + exchanger) {
                do {
                    let html = try String(contentsOf: url)
                    let document: Document = try SwiftSoup.parse(html)
                                        
                    let elementsName: Elements = try document.getElementsByClass("exchange__title")
                    let elementGive: Elements = try document.getElementsByClass("exchange__send")
                    let elementReceive: Elements = try document.getElementsByClass("exchange__receive")
                    let elementReserve: Elements = try document.getElementsByClass("exchange__reserve-wrap")
                    
                    if (elementsName.count == elementGive.count && elementsName.count == elementReceive.count && elementsName.count == elementReserve.count) {
                        for index in 0..<elementsName.count {
                            let exchanger = try ExchangerModel(name: elementsName[index].text(), reserve: elementReserve[index].text(), give: elementGive[index].attr("data-in"), receive: elementReceive[index].attr("data-out"), url: "https://wellcrypto.io" + elementsName[index].attr("href"))
                            
                            self?.exchangers.append(exchanger)
                        }
                    } else {
                        completion([])
                    }
                    
                    completion(self?.exchangers ?? [])
                } catch {
                    completion([])
                }
            }
        }
    }
}
