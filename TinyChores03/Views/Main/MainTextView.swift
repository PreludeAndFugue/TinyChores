//
//  MainTextView.swift
//  TinyChores03
//
//  Created by gary on 01/10/2020.
//  Copyright © 2020 Gary Kerr. All rights reserved.
//

import SwiftUI

struct MainTextView: View {
    let name: String
    @Binding var toggle: Bool

    var body: some View {
        VStack {
            Spacer()

            ZStack {
                if toggle {
                    text
                } else {
                    text
                }
            }

            Spacer()
        }
    }


    private var transition: AnyTransition {
        let insertion = AnyTransition.scale(scale: 0.1).combined(with: .opacity)
        let removal = AnyTransition.scale(scale: 6).combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }


    private var text: some View {
        Text(name)
            .font(.system(size: 65, design: .rounded))
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .foregroundColor(.purple)
            .padding()
            .frame(maxWidth: .infinity)
            .animation(nil)
            .transition(transition)
            .animation(.easeIn)
    }
}

struct MainTextView_Previews: PreviewProvider {
    static var previews: some View {
        MainTextView(name: "Current chore", toggle: .constant(true))
    }
}
