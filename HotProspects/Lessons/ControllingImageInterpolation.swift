//
//  ControllingImageInterpolation.swift
//  HotProspects
//
//  Created by Gokhan Bozkurt on 5.06.2022.
//

import SwiftUI

struct ControllingImageInterpolation: View {
    var body: some View {
        Image("example")
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(.black)
            .ignoresSafeArea()
    }
}

struct ControllingImageInterpolation_Previews: PreviewProvider {
    static var previews: some View {
        ControllingImageInterpolation()
    }
}
