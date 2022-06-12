//
//  ContextMenus.swift
//  HotProspects
//
//  Created by Gokhan Bozkurt on 6.06.2022.
//

import SwiftUI

struct ContextMenus: View {
    @State private var backgroundColor = Color.mint
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .padding()
            .background(backgroundColor)
            
            Text("Change Color")
                 .padding()
        
                  .contextMenu {
                      Button(role: .destructive) {
                        backgroundColor = .red
                    } label: {
                        Label("red", systemImage: "checkmark.circle.fill")
                            .foregroundColor(.red)
                    }
                    Button("Green") {
                        backgroundColor = .green
                    }
            }
        }
    }
}

struct ContextMenus_Previews: PreviewProvider {
    static var previews: some View {
        ContextMenus()
    }
}
