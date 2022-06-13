//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Gokhan Bozkurt on 7.06.2022.
//
import CodeScanner
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    @State private var showConfirmation = false
    enum FilterType {
        case none, contacted,uncontacted
    }
    enum SortType {
        case name, date
    }
    @EnvironmentObject var prospects: Prospects
    @State private var showScanner = false
    let filter: FilterType
    @State private var sortOrder = SortType.date

    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    HStack {
                        if filter == .none && !prospect.isContacted {
                            withAnimation(.easeInOut) {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(.red)
                                    .font(.title2)
                                    .padding(.vertical,8)
                            }
                              
                    }
                 
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                    }
                    .swipeActions {
                        if prospect.isContacted {
                            Button {
                                withAnimation {
                                    prospects.toggleIsContacted(prospect)
                                }
                            } label: {
                                Label("Mark Uncontacted",systemImage:"person.crop.circle.badge.xmark")
                            }
                            .tint(.blue)
                        } else {
                            Button {
                                withAnimation {
                                    prospects.toggleIsContacted(prospect)
                                }
                            } label: {
                                Label("Mark contacted",systemImage:"person.crop.circle.fill.badge.checkmark")
                            }
                            .tint(.green)
                            
                            Button {
                                addNotification(for: prospect)
                            } label: {
                                Label("Remind me", systemImage: "bell")
                            }
                            .tint(.orange)
                        }
                        Button(role: .destructive) {
                            prospects.removePeople(prospect)
                        } label: {
                            Label("Delete", systemImage: "minus.circle")
                        }
                    
                    }
                }
               
            }.navigationTitle(title)
                .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                       showScanner = true
                    } label: {
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                           showConfirmation = true
                        } label: {
                            Label("Sort", systemImage: "arrow.up.arrow.down.circle")
                        }
                        }
                }
                .confirmationDialog("Sort by...", isPresented: $showConfirmation) {
                    Button("Name(A-Z)") { sortOrder = .name  }
                    Button("Date (Newest first)") { sortOrder = .date }
                    Button("Cancel",role: .cancel) { }
                } message: {
                    Text("Sort by something")
                }
                
                .sheet(isPresented: $showScanner) {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "Zombi Bozkurt\ngokhanbozkurt.com", completion: handleScan)
                }
                
            
        }
    }
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted People"
        case .uncontacted:
            return "Uncontacted People"
        }
    }
    
    var filteredProspects: [Prospect] {
        let result: [Prospect]
        switch filter {
        case .none:
            result = prospects.people
        case .contacted:
            result = prospects.people.filter { $0.isContacted}
        case .uncontacted:
            result =  prospects.people.filter { !$0.isContacted}
        }
        if sortOrder == .name {
            return result.sorted { $0.name < $1.name}
        } else {
           return result.reversed()
        }
    }
    
    func handleScan(result: Result<ScanResult,ScanError>) {
        showScanner = false
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            prospects.addProspect(prospect: person)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            // in oerder to test notification feature
          //  let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
            
        }
        center.getNotificationSettings { setting in
           if  setting.authorizationStatus == .authorized {
                addRequest()
           } else {
               center.requestAuthorization(options: [.alert,.badge,.sound]) { success, error in
                   if success {
                       addRequest()
                   } else {
                       // Error handling alert need
                       print(error?.localizedDescription)
                   }
               }
           }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none )
    }
}
