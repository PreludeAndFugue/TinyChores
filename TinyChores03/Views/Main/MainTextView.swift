//
//  MainTextView.swift
//  TinyChores03
//
//  Created by gary on 01/10/2020.
//  Copyright © 2020 Gary Kerr. All rights reserved.
//

import SwiftUI

struct MainTextView: View {
    @State var opacity = 1.0


    let name: String


    var body: some View {
        VStack {
            Spacer()

            Text(name)
                .font(.system(size: 65, design: .rounded))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.purple)
                .padding()
                .frame(maxWidth: .infinity)
                .animation(nil)

            Spacer()
        }
    }
}

struct MainTextView_Previews: PreviewProvider {
    static var previews: some View {
        MainTextView(name: "Current chore")
    }
}
