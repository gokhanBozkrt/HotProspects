//
//  Prospect.swift
//  HotProspects
//
//  Created by Gokhan Bozkurt on 7.06.2022.
//

import SwiftUI

class Prospect: Identifiable,Codable {

    
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
  fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]

  
    init() {
        do {
            let data =  try Data(contentsOf: savePath)
            self.people = try JSONDecoder().decode([Prospect].self, from: data)
        } catch  {
            people = []
        }
    }
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedProspects")
    
    func addProspect(prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
   private func save() {
       do {
           let data = try JSONEncoder().encode(people)
           try data.write(to: savePath,options: [.atomic,.completeFileProtection])
       } catch  {
           print("Unable to save data")
       }
    }
    
  
 
    func toggleIsContacted(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
        
    func removePeople(_ prospect: Prospect) {
       let index = people.firstIndex { $0.id == prospect.id }
        guard let index = index else { return }
        people.remove(at: index)
        save()
        }

    
}
