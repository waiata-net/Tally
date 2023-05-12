//
//  ContentView.swift
//  Tally
//
//  Created by Neal Watkins on 2022/8/8.
//

import SwiftUI

struct ContentView: View {
    
    
    @AppStorage("campaignURL") var url: URL?
    
    @State var campaign: Campaign = Campaign()
    
    init() {
        campaign = Campaign(url: url)
        print(campaign.urls)
    }
      
    var body: some View {
        VStack {
            TallyBrowse(campaign: $campaign)
            TallyTable(campaign: campaign)
            Spacer()
        }
        .padding()
        .frame(minWidth: 480, minHeight: 480)
        
    }
    
    
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
