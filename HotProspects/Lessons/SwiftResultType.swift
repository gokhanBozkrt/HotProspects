//
//  SwiftResultType.swift
//  HotProspects
//
//  Created by Gokhan Bozkurt on 5.06.2022.
//

import SwiftUI

struct SwiftResultType: View {
    @State private var output = ""
    var body: some View {
        Text(output)
            .task {
                await fetchReading()
            }
    }
    func fetchReading() async {
        let fetchTask = Task { () -> String in
            let url = URL(string:  "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings =  try  JSONDecoder().decode([Double].self, from: data)
            return  "Found \(readings.count) readings"
        }
        // Error is inside the result
        let result = await fetchTask.result
        switch result {
        case .success(let str):
            output = str
        case .failure(let error):
            "Download Error"
        }
    }
}

struct SwiftResultType_Previews: PreviewProvider {
    static var previews: some View {
        SwiftResultType()
    }
}
