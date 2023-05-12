//
//  ContentView.swift
//  Tally
//
//  Created by Neal Watkins on 2022/8/8.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("campaignURL") var url: URL?
    
    @StateObject var campaign = Campaign()
      
    var body: some View {
        VStack {
            TallyBrowse()
            TallyTable()
            Spacer()
        }
        .padding()
        .frame(minWidth: 480, minHeight: 480)
        .environmentObject(campaign)
        .navigationTitle(campaign.label)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
