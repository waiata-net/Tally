//
//  ViewController.swift
//  Blackboard
//
//  Created by Neal Watkins on 2022/6/2.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var rootButton: FileButton!
    
    @IBOutlet weak var table: NSTableView!
    
    @IBOutlet weak var blankTotal: NSTextField!
    @IBOutlet weak var notesTotal: NSTextField!
    @IBOutlet weak var codedTotal: NSTextField!
    @IBOutlet weak var totalTotal: NSTextField!
    
    @IBAction func repath(_ sender: Any) {
        guard let url = rootButton.url else { return }
        campaign = Campaign(root: url)
    }
    
    var campaign: Campaign? {
        didSet {
            campaign?.run()
            render()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        render()
    }

    func render() {
        guard let campaign = campaign else {
            return
        }

        rootButton.url = campaign.root
        table.reloadData()
        
        blankTotal.integerValue = campaign.total.blank
        notesTotal.integerValue = campaign.total.notes
        codedTotal.integerValue = campaign.total.coded
        totalTotal.integerValue = campaign.total.total
    }


}

extension ViewController: NSTableViewDelegate, NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return campaign?.tallys.count ?? 0
    }
    
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let tally = campaign?.tallys[row] else { return nil }
        switch tableColumn?.identifier {
        case UI.Column.ext : return cell(ext: tally.ext)
        case UI.Column.blank : return cell(tot: tally.blank)
        case UI.Column.notes : return cell(tot: tally.notes)
        case UI.Column.coded : return cell(tot: tally.coded)
        case UI.Column.total : return cell(tot: tally.total)
        default: return nil
        }
    }
    
    
    func cell(ext: String?) -> NSTableCellView? {
        guard let ext = ext,
              let view = table.makeView(withIdentifier: UI.Cell.ext, owner: nil) as? NSTableCellView
        else { return nil }
        view.textField?.stringValue = ext
        return view
    }
    
    func cell(tot: Int?) -> NSTableCellView? {
        guard let tot = tot,
              let view = table.makeView(withIdentifier: UI.Cell.tot, owner: nil) as? NSTableCellView
        else { return nil }
        view.textField?.integerValue = tot
        view.textField?.alignment = .right
        return view
    }
    
    struct UI {
        struct Column {
            static let ext = NSUserInterfaceItemIdentifier("Ext Column")
            static let blank = NSUserInterfaceItemIdentifier("Blank Column")
            static let notes = NSUserInterfaceItemIdentifier("Notes Column")
            static let coded = NSUserInterfaceItemIdentifier("Coded Column")
            static let total = NSUserInterfaceItemIdentifier("Total Column")
        }
        struct Cell {
            static let ext = NSUserInterfaceItemIdentifier("Ext Cell")
            static let tot = NSUserInterfaceItemIdentifier("Tot Cell")
        }
    }
}

