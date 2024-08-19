//
//  Prospect.swift
//  HotProspects
//
//  Created by Kenji Dela Cruz on 8/15/24.
//

import SwiftData
import SwiftUI
@Model
class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    var date =  Date.now
    
    init(name: String, emailAddress: String, isContacted: Bool) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
    }
}
