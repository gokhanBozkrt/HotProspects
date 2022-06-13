//
//  PackageDependenciesView.swift
//  HotProspects
//
//  Created by Gokhan Bozkurt on 7.06.2022.
//

import SamplePackage
import SwiftUI

struct PackageDependenciesView: View {
    let possibleNumber = Array(1...60)
    
    var body: some View {
       Text(results)
    }
    var results: String {
        let selected = possibleNumber.random(7).sorted()
        // selected.map(String.init)
        let strings = selected.map { String($0)}
        return strings.joined(separator: ", ")
        
        
    }
}

struct PackageDependenciesView_Previews: PreviewProvider {
    static var previews: some View {
        PackageDependenciesView()
    }
}


/*
 struct ConfirmationDialog: View {
     @State private var showingConfirmation = false
     @State private var backgroundColor = Color.white
     var body: some View {
         Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
             .frame(width: 300, height: 300)
             .background(backgroundColor)
          
             .onTapGesture {
                 showingConfirmation = true
             }
             .confirmationDialog("Change Background", isPresented: $showingConfirmation) {
                 Button("Red") { backgroundColor = .red }
                 Button("Green") { backgroundColor = .green }
                 Button("Blue") { backgroundColor = .blue }
                 Button("Cancel",role: .cancel) { }
             } message: {
                 Text("Select a new Color")
             }
         
     }
 }
 */
