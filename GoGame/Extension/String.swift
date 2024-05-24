//
//  String.swift
//  GoGame
//
//  Created by FFK on 24.05.2024.
//

import Foundation

extension String {
    func stringByRemovingHTMLTags() -> String {
        // HTML taglerini temizlemek için düzenli ifadeyi tanımla
        let regex = try! NSRegularExpression(pattern: "<[^>]+>")
        // HTML etiketlerini kaldır
        let range = NSRange(location: 0, length: self.utf16.count)
        let cleanString = regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "")
        // Temizlenmiş metni geri döndür
        return cleanString
    }
}
