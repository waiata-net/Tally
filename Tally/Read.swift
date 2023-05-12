//
//  Read.swift
//  Tally
//
//  Created by Neal Watkins on 2022/6/2.
//

import Foundation
import UniformTypeIdentifiers
import AppKit


struct Read: Identifiable {
    
    var id = UUID()
    var uti: String = ""
    var ext: String = ""
    var blank = 0
    var coded = 0
    var notes = 0
    var total = 0
    var count = 1
    var bytes = UInt64(0)
    var isTotal = false
    
    init() {
    }
    
    init(url: URL) {
        ext = url.pathExtension
        read(url: url)
    }
    
    init(total: [Read]) {
        self = total.reduce(Read(), +)
        self.isTotal = true
        self.ext = "Σ"
    }
    
    mutating func read(url: URL) {
        bytes = url.fileSize
        guard let uti = try? url.resourceValues(forKeys: [.typeIdentifierKey]).typeIdentifier,
              let ut = UTType(uti),
              ut.conforms(to: .text),
              let data = try? String(contentsOfFile: url.path)
        else { return }
        
        self.uti = uti
        
        let lines = data.components(separatedBy: .newlines).map{ $0.trimmingCharacters(in: .whitespaces)}
        for line in lines {
            if line.isEmpty { blank += 1 }
            else if line.hasPrefix("//") { notes += 1 }
            else { coded += 1 }
        }
        total = lines.count
    }
    
    var icon: NSImage? {
        guard let type = UTType(uti) else { return nil }
        return NSWorkspace.shared.icon(for: type)
    }
    
    var byteString: String {
        if bytes == 0 {
            return ""
        } else {
            return ByteCountFormatter.string(fromByteCount: Int64(bytes), countStyle: .file)
        }
    }
    
    var isCode: Bool {
        total > 0
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
        r.count = a.count + b.count
        r.bytes = a.bytes + b.bytes
        return r
    }
    
}
