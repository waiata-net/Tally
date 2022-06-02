//
//  Read.swift
//  Blackboard
//
//  Created by Neal Watkins on 2022/6/2.
//

import Foundation
import UniformTypeIdentifiers


struct Read {
    
    var ext: String = ""
    var blank = 0
    var coded = 0
    var notes = 0
    var total = 0
    
    init() {
    }
    
    init(url: URL) {
        ext = url.pathExtension
        read(url: url)
    }
    
    mutating func read(url: URL) {
        guard let id = try? url.resourceValues(forKeys: [.typeIdentifierKey]).typeIdentifier,
              let ut = UTType(id),
              ut.conforms(to: .text),
              let data = try? String(contentsOfFile: url.path)
        else { return }
        let lines = data.components(separatedBy: .newlines).map{ $0.trimmingCharacters(in: .whitespaces)}
        for line in lines {
            if line.isEmpty { blank += 1 }
            else if line.hasPrefix("//") { notes += 1 }
            else { coded += 1 }
        }
        total = lines.count
    }
    
    static func +(a: Read, b: Read?) -> Read {
        guard let b = b else {
            return a
        }
        var r = a
        r.blank = a.blank + b.blank
        r.coded = a.coded + b.coded
        r.notes = a.notes + b.notes
        r.total = a.total + b.total
        return r
    }
    
}
