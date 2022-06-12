//
//  SwipeActionsForList.swift
//  HotProspects
//
//  Created by Gokhan Bozkurt on 6.06.2022.
//

import SwiftUI

struct SwipeActionsForList: View {
    var body: some View {
        List {
            Text("Paul Hudson")
                .swipeActions {
                    Button(role: .destructive) {
                        print("deleting")
                    } label: {
                        Label("Delete", systemImage: "minus.circle")
                    }

                }
                .swipeActions(edge: .leading) {
                    Button {
                        print("Pining")
                    } label: {
                        Label("Pin", systemImage: "pin")
                    }.tint(.orange)

                }
        }
    }
}

struct SwipeActionsForList_Previews: PreviewProvider {
    static var previews: some View {
        SwipeActionsForList()
    }
}
