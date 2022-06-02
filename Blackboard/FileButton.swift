//
//  FileButton.swift
//
//  Created by Neal on 4-14-18.
//  Copyright © 2018 waiata. All rights reserved.
//

import Cocoa

@IBDesignable
class FileButton : NSButton {
    @IBInspectable var preferenceKey : String? = nil
    @IBInspectable var panelTitle : String = "Select File"
    @IBInspectable var allowedExtensions : String = ""
    @IBInspectable var directoriesAllowed : Bool = true
    @IBInspectable var filesAllowed : Bool = true
    @IBInspectable var displayFullPath : Bool = true
    @IBInspectable var isSavePanel : Bool = false
    
    var url : URL? {
        didSet { render() }
    }
    
    override func awakeFromNib() {
        read()
        render()
    }
    
    override func sendAction(_ action: Selector?, to target: Any?) -> Bool {
        
        if isSavePanel {
            savePanel()
        } else {
            openPanel()
        }
        
        record()
        render()
        
        return super.sendAction(action, to: target)
    }
    
    func openPanel() {
        let panel = NSOpenPanel()
        
        panel.title = panelTitle
        panel.canChooseDirectories = directoriesAllowed
        panel.canChooseFiles = filesAllowed
        panel.allowedFileTypes = allowed()
        panel.allowsMultipleSelection = false
        
        let ok = panel.runModal()
        guard ok == .OK else { return }
        
        url = panel.url
    }
    
    func savePanel() {
        let panel = NSSavePanel()
        
        panel.title = panelTitle
        panel.allowedFileTypes = allowed()
        
        let ok = panel.runModal()
        guard ok == .OK else { return }
        
        url = panel.url
    }
    
    func allowed() -> [String]? {
        let split = allowedExtensions.split(separator: ",")
        if split.isEmpty { return nil } // allow all file types
        return split.map({String($0)})
    }
    
    func read() {
        if let key = preferenceKey {
            url = UserDefaults.standard.url(forKey: key)
        }
    }
    
    func render() {
        if displayFullPath {
            title = url?.path ?? "…"
        } else {
            title = url?.lastPathComponent.removingPercentEncoding ?? "…"
        }
    }
    
    func record() {
        if let key = preferenceKey {
            UserDefaults.standard.set(url, forKey: key)            
        }
    }
}
