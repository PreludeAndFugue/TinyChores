//
//  SettingsButtonView.swift
//  TinyChores03
//
//  Created by gary on 01/10/2020.
//  Copyright © 2020 Gary Kerr. All rights reserved.
//

import SwiftUI

struct SettingsButtonView: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "gearshape.fill")
                .font(.title2)
                .frame(width: 44, height: 44)
        }
        .foregroundColor(.purple)
        .accessibilityLabel("Settings")
    }
}


#if DEBUG
struct SettingsButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButtonView(action: {})
    }
}
#endif
