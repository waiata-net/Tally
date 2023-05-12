//
//  TallyBrowse.swift
//  Tally
//
//  Created by Neal Watkins on 2022/8/22.
//

import SwiftUI

struct TallyBrowse: View {
    
    @AppStorage("Campaign URL") var url: URL?
    @EnvironmentObject var campaign: Campaign
    
    var browseLabel: String {
        var label = campaign.label
        if label.isEmpty { label = "Browse…" }
        return label
    }
    
    var body: some View {
        HStack {
            Button {
                campaign.browse()
            } label: {
                Text(browseLabel).font(.title)
                    .frame(maxWidth: .infinity)
                    .padding(8)
                    .background(Color.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .keyboardShortcut("o")
            .buttonStyle(.plain)
            
        }
    }

}

struct TallyBrowse_Previews: PreviewProvider {
    @State static var sample = Sample.campaign
    static var previews: some View {
        TallyBrowse()
            .environmentObject(sample)
    }
}
