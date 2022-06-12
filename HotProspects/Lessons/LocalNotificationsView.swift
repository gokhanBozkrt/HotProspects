//
//  LocalNotificationsView.swift
//  HotProspects
//
//  Created by Gokhan Bozkurt on 7.06.2022.
//

import SwiftUI
import UserNotifications

struct LocalNotificationsView: View {
    var body: some View {
        VStack {
            Button("Request Permisson") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { success, error  in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the dogs"
                content.subtitle = "They look hungry"
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}

struct LocalNotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationsView()
    }
}
