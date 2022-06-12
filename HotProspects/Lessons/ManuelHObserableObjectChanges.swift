//
//  ManuelHObserableObjectChanges.swift
//  HotProspects
//
//  Created by Gokhan Bozkurt on 5.06.2022.
//

import SwiftUI

@MainActor class DelayedUpdater: ObservableObject {
    var value = 0 {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

struct ManuelHObserableObjectChanges: View {
    @StateObject var updater = DelayedUpdater()
    var body: some View {
        Text("Value is \(updater.value)")
    }
}

struct ManuelHObserableObjectChanges_Previews: PreviewProvider {
    static var previews: some View {
        ManuelHObserableObjectChanges()
    }
}
