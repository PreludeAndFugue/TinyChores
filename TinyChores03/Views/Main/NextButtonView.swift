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
        Button(action: action) {
            Text("Next")
                .font(.system(.title3, design: .rounded))
                .fontWeight(.bold)
        }
        .foregroundColor(.white)
        .padding(.horizontal, 24)
        .padding(.vertical, 14)
        .background(Capsule().fill(Color.purple))
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
