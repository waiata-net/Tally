//
//  Campaign.swift
//  Blackboard
//
//  Created by Neal Watkins on 2022/6/2.
//

import Foundation


class Campaign {
    
    var root: URL
    
    var tallys = [Read]()
    
    init(root: URL) {
        self.root = root
    }
    
    func run() {
        
        tallys = []
        
        let fm = FileManager()
        
        if root.isDirectory {
            guard let enumerator = fm.enumerator(at: root, includingPropertiesForKeys: nil, options: .skipsHiddenFiles) else {
                return
            }
                for case let url as URL in enumerator {
                    read(url)
            }
        } else {
             read(root)
        }
        
    }
    
    var extentions: [String] {
        tallys.map { $0.ext }.sorted()
    }
    
    
    func read(_ url: URL) {
        let read = Read(url: url)
        if let i = tallys.firstIndex(where: { $0.ext == read.ext }) {
            let t = tallys.remove(at: i)
            tallys.insert(t + read, at: i)
        } else {
            tallys.append(read)
        }
    }
    
    subscript(_ ext: String) -> Read? {
        tallys.first(where: { $0.ext == ext })
    }
    
}
