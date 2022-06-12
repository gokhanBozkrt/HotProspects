//
//  EnvironmentObjectView.swift
//  HotProspects
//
//  Created by Gokhan Bozkurt on 5.06.2022.
//

import SwiftUI

@MainActor class User: ObservableObject {
    @Published var name = "Paul Hansome"
}

struct EditView: View {
    @EnvironmentObject var user : User
    var body: some View {
        TextField("User Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user : User
    
    var body: some View {
        Text(user.name)
    }
}

struct EnvironmentObjectView: View {
    @StateObject var user = User()
    var body: some View {
        VStack {
            EditView()
            DisplayView()
        }
        .environmentObject(user)
    }
}

struct EnvironmentObjectView_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentObjectView()
    }
}
