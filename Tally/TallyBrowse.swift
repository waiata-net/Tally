//
//  TallyBrowse.swift
//  Tally
//
//  Created by Neal Watkins on 2022/8/22.
//

import SwiftUI

struct TallyBrowse: View {
    
    @AppStorage("campaignURL") var url: URL?
    @Binding var campaign: Campaign
    
    var body: some View {
        HStack {
            Button(campaign.label) {
                openPanel()
            }
            .frame(minWidth: 240, maxWidth: .infinity)
            Button{
                campaign.run()
            } label: {
                Image(systemName: "arrow.clockwise")
            }
            
        }
    }

    func openPanel() {
        let panel = NSOpenPanel()
        
        panel.canChooseDirectories = true
        panel.canChooseFiles = true
        panel.allowsMultipleSelection = true
        
        let ok = panel.runModal()
        guard ok == .OK else { return }
        
        url = panel.url
        campaign = Campaign(urls: panel.urls)
    }
}

struct TallyBrowse_Previews: PreviewProvider {
    @State static var sample = Sample.campaign
    static var previews: some View {
        TallyBrowse(campaign:  $sample)
    }
}
