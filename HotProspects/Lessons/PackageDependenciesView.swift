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
