//
//  NextButtonView.swift
//  TinyChores03
//
//  Created by gary on 01/10/2020.
//  Copyright © 2020 Gary Kerr. All rights reserved.
//

import SwiftUI

struct NextButtonView: View {
    let action: () -> Void


    var body: some View {
        Button("Next", action: action)
            .font(.system(.title3, design: .rounded).weight(.bold))
            .buttonStyle(.glassProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .tint(.purple)
            .accessibilityLabel("Next chore")
    }
}


#if DEBUG
struct NextButtonView_Previews: PreviewProvider {
    static var previews: some View {
        NextButtonView(action: { })
    }
}
#endif
