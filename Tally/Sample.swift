//
//  Sample.swift
//  TallyTests
//
//  Created by Neal Watkins on 2022/8/8.
//

import Foundation

struct Sample {
    
    static let url = URL(fileURLWithPath: "/Users/neal/town/park/_dev/Tally")
    
    static var campaign: Campaign {
        Campaign(url: url)
    }
    
    static var tallys: [Read] {
        campaign.tallys
    }

}
