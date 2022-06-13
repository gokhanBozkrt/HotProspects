//
//  Extension + FileManager .swift
//  HotProspects
//
//  Created by Gokhan Bozkurt on 12.06.2022.
//

import Foundation

let fileName = "Prospecs"

extension FileManager {
    static var documentsDirectory: URL {
        let path = Self.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }

}
