//
//  TabViewLesson.swift
//  HotProspects
//
//  Created by Gokhan Bozkurt on 5.06.2022.
//

import SwiftUI

struct TabViewLesson: View {
    @State private var selectedTab = "One"
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Tab 1")
                .onTapGesture {
                    selectedTab = "Two"
                }
             .tabItem {
                 Label("One", systemImage: "star")
            }
            
            Text("Tab 2")
             .tabItem {
                 Label("Two", systemImage: "circle")
            }
             .tag("Two")
           
        }
    }
}

struct TabViewLesson_Previews: PreviewProvider {
    static var previews: some View {
        TabViewLesson()
    }
}
