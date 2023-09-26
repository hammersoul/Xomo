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
    
    // MARK: Exchanges Parsing
    
    func parse(completion: @escaping (([ExchangerModel]) -> Void), exchangers: String) {
        DispatchQueue.global().asyncAfter(deadline: .now()) { [weak self] in
            if let url = URL(string: self!.url + exchangers) {
                do {
                    let html = try String(contentsOf: url)
                    let document: Document = try SwiftSoup.parse(html)
                    
                    let elementsName: Elements = try document.getElementsByClass("exchange__title")
                    let elementGive: Elements = try document.getElementsByClass("exchange__send-wrap")
                    let elementReceive: Elements = try document.getElementsByClass("exchange__receive")
                    let elementReserve: Elements = try document.getElementsByClass("exchange__reserve-wrap")
                    
                    for index in 0..<elementsName.count {
                        let exchanger = try ExchangerModel(name: elementsName[index].text(), reserve: elementReserve[index].text(), give: elementGive[index].text(), receive: elementReceive[index].text(), url: "https://wellcrypto.io" + elementsName[index].attr("href"))
                        
                        self?.exchangers.append(exchanger)
                    }
                    
                    completion(self?.exchangers ?? [])
                } catch {
                    print("Error get exchangers")
                }
            }
        }
    }
}
