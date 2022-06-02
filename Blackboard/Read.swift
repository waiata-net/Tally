//
//  Read.swift
//  Blackboard
//
//  Created by Neal Watkins on 2022/6/2.
//

import Foundation


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
