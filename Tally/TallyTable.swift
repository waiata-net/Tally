//
//  TallyTable.swift
//  Tally
//
//  Created by Neal Watkins on 2022/8/8.
//

import SwiftUI

struct TallyTable: View {
    
    @EnvironmentObject var campaign: Campaign
    
    @State private var sorter = [KeyPathComparator(\Read.ext)]
    @State private var filter = Filter.all
    
    var tallys: [Read] {
        var tallys = campaign.tallys.sorted(using: sorter)
        switch filter {
        case .code: tallys = tallys.filter { $0.isCode }
        default: break
        }
        let total = Read(total: tallys)
        tallys.append(total)
        
        return tallys
    }
    
    enum Filter: String, CaseIterable {
        case all
        case code
    }
    
    var body: some View {
        VStack {
            HStack {
                Picker("", selection: $filter) {
                    ForEach(Filter.allCases, id: \.self) { filter in
                        Text(filter.rawValue.localizedCapitalized).tag(filter)
                    }
                }
                Button{
                    campaign.run()
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
            }
            Table(tallys, sortOrder: $sorter) {
                TableColumn("File Type", value: \.ext) { read in
                    if read.isTotal {
                        Text("Total")
                    } else {
                        Label {
                            Text(read.ext)
                        } icon: {
                            Image(nsImage: read.icon ?? NSImage())
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 48, maxHeight: 48)
                        }
                    }
                }
                TableColumn("File Count", value: \.count) { read in
                    Text("\(read.count)")
                }
                TableColumn("Blank Lines", value: \.blank) { read in
                    Text("\(read.blank)")
                }
                TableColumn("Comments", value: \.notes) { read in
                    Text("\(read.notes)")
                }
                TableColumn("Code Lines", value: \.coded) { read in
                    Text("\(read.coded)")
                }
                TableColumn("Total Lines", value: \.total) { read in
                    Text("\(read.total)")
                }
                TableColumn("Space", value: \.bytes) { read in
                    Text("\(read.byteString)")
                }
            }
            .onChange(of: sorter) {
                campaign.tallys.sort(using: $0)
            }
        }
    }
}

struct TallyTable_Previews: PreviewProvider {
    @State static var sample = Sample.campaign
    static var previews: some View {
        TallyTable()
            .environmentObject(sample)
    }
}

