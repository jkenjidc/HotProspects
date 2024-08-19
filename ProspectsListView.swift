//
//  ProspectsListView.swift
//  HotProspects
//
//  Created by Kenji Dela Cruz on 8/19/24.
//

import SwiftUI
import SwiftData
import UserNotifications


struct ProspectsListView: View {
    @Environment(\.modelContext) var modelContext
    @Query var prospects: [Prospect]
    @Binding public var selected: Set<Prospect>
    let filter: ProspectsView.FilterType
    var showProspectIcon: Bool {
        return filter == .none
    }
    var body: some View {
        ForEach(prospects, id: \.self) { prospect in
            NavigationLink(destination: EditProscpectView(prospect: prospect, selected: $selected))
            {
                VStack(alignment: .leading) {
                    HStack{
                        if showProspectIcon {
                            Image(systemName: prospect.isContacted ? "person.crop.circle.badge.xmark" : "questionmark.diamond")
                        }
                        Text(prospect.name)
                            .font(.headline)
                    }
                    
                    Text(prospect.emailAddress)
                        .foregroundStyle(.secondary)
                }
            }
            .buttonStyle(PlainButtonStyle())
            .swipeActions {
                Button("Delete", systemImage: "trash", role: .destructive) {
                    modelContext.delete(prospect)
                }
                if prospect.isContacted {
                    Button("Mark Uncontaced", systemImage: "person.crop.circle.badge.xmark") {
                        prospect.isContacted.toggle()
                    }
                    .tint(.blue)
                } else {
                    Button("Mark Contacted", systemImage: "person.crop.circle.badge.xmark") {
                        prospect.isContacted.toggle()
                    }
                    .tint(.green)
                    
                    Button("Remind Me", systemImage: "bell") {
                        addNotification(for: prospect)
                    }
                    .tint(.orange)
                }
            }
            .tag(prospect)
        }

    }
    
    init(selected: Binding<Set<Prospect>>, filter: ProspectsView.FilterType, sortOrder:[SortDescriptor<Prospect>]) {
        _prospects = Query(sort: sortOrder)
        self.filter = filter
        _selected = selected
        if filter != .none {
            let showContactedOnly = filter == .contacted
            
            _prospects = Query(filter: #Predicate{
                $0.isContacted == showContactedOnly
            }, sort: sortOrder)
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest  = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            //            var dateComponents =  DateComponents()
            //            dateComponents.hour = 9
            //
            //            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request  = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        
    }

}

#Preview {
    @State  var selectedProspects = Set<Prospect>()
    return ProspectsListView(selected: $selectedProspects, filter: ProspectsView.FilterType.none, sortOrder: [SortDescriptor(\Prospect.name)])
}
