//
//  ParseConverter.swift
//  Xomo
//

import Foundation
import SwiftSoup

final class ParseConverter {
    
    static let shared = ParseConverter()
    
    let url = "https://finance.rambler.ru/calculators/converter/"
    
    public var numReceive = String()
    
    // MARK: Converter Parsing
    
    func parse(numGive: String, currencyGive: String, currencyReceive: String, completion: @escaping (String) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now()) { [weak self] in
            if let url = URL(string: self!.url + numGive + "-" + currencyGive + "-" + currencyReceive + "/") {
                do {
                    let html = try String(contentsOf: url)
                    let document: Document = try SwiftSoup.parse(html)
                    
                    let elementReceive: Element = try document.getElementsByClass("converter-display__cross-block").select("div.converter-display__value").last()!
                    
                    self!.numReceive = try elementReceive.text()
                    
                    completion(self?.numReceive ?? "")
                } catch {
                    print("Error get info")
                }
            }
        }
    }
}
