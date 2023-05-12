//
//  Campaign.swift
//  Tally
//
//  Created by Neal Watkins on 2022/6/2.
//

import Foundation


class Campaign: ObservableObject {
    
    var urls = [URL]()
    
    @Published var total = Read()
    var tallys = [Read]()
    
    let fm = FileManager()
    
    init() {
        
    }
    
    init(url: URL?) {
        if let url = url {
            self.urls = [url]
        } else {
            self.urls = []
        }
        run()
    }
    
    init(urls: [URL]) {
        self.urls = urls
        run()
    }
    
    
    var extentions: [String] {
        tallys.map { $0.ext }.sorted()
    }
    
    var label: String {
        urls.reduce("") { $0 + " " + $1.lastPathComponent }
    }
    
    func run() {
        
        tallys = []
        
        for url in urls {
            if url.isDirectory {
                read(directory: url)
            } else {
                read(file: url)
            }
            
        }
        total = Read(total: tallys)
    }
    
    func read(directory: URL) {
        guard let enumerator = fm.enumerator(at: directory, includingPropertiesForKeys: nil, options: .skipsHiddenFiles) else {
            return
        }
        for case let url as URL in enumerator {
            read(file: url)
        }
    }
    
    
    func read(file: URL) {
        let read = Read(url: file)
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
