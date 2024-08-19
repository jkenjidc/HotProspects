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
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var email = ""
    @Binding public var selected: Set<Prospect>
    var body: some View {
        TextField(prospect.name, text: $name)
        TextField(prospect.emailAddress, text: $email)
        Button("save") {
            if !name.isEmpty {prospect.name = name}
            if !email.isEmpty {prospect.emailAddress = email}
            dismiss()
        }
        .onAppear(perform: {
            selected.removeAll()
        })
    }
}

#Preview {
    let pro = Prospect(name: "Paul", emailAddress: "Hud", isContacted: false)
    @State  var selectedProspects = Set<Prospect>()
    return EditProscpectView(prospect: pro, selected: $selectedProspects)
}
