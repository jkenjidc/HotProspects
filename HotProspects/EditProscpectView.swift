//
//  EditProscpectView.swift
//  HotProspects
//
//  Created by Kenji Dela Cruz on 8/16/24.
//

import SwiftUI
import SwiftData

struct EditProscpectView: View {
    var prospect: Prospect
    @State private var name = ""
    @State private var email = ""
    var body: some View {
        TextField(prospect.name, text: $name)
        TextField(prospect.emailAddress, text: $email)
        Button("save") {
            prospect.name = name
            prospect.emailAddress = email
        }
    }
}

#Preview {
    let pro = Prospect(name: "Paul", emailAddress: "Hud", isContacted: false)
    return EditProscpectView(prospect: pro)
}
