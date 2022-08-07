//
//  URL.swift
//  Tally
//
//  Created by Neal Watkins on 2022/6/2.
//

import Foundation

extension URL {
    var isDirectory: Bool {
       (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true
    }
}
