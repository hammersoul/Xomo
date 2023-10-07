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
                                                        
                    let elementReceive: Element = try document.getElementsByClass("_20gvL").last()!.getElementsByClass("_1wjU3").last()!
                    
                    self!.numReceive = try elementReceive.text()
                    
                    completion(self?.numReceive ?? "")
                } catch {
                    self!.numReceive = ""
                    completion("")
                }
            } else {
                self!.numReceive = ""
                completion("")
            }
        }
    }
}
