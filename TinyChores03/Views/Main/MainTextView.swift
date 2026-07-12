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
    let choreID: UUID
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        VStack {
            Spacer()

            ZStack {
                text
                    .id(choreID)
            }
            .animation(contentAnimation, value: choreID)

            Spacer()
        }
    }


    private var transition: AnyTransition {
        guard !reduceMotion else { return .identity }
        return .opacity.combined(with: .scale(scale: 0.96))
    }


    private var contentAnimation: Animation? {
        reduceMotion ? nil : .smooth(duration: 0.28, extraBounce: 0)
    }


    private var text: some View {
        Text(name)
            .font(.system(size: 52, weight: .bold, design: .rounded))
            .multilineTextAlignment(.center)
            .foregroundColor(.purple)
            .lineLimit(2)
            .minimumScaleFactor(0.55)
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity, alignment: .center)
            .transition(transition)
    }
}

struct MainTextView_Previews: PreviewProvider {
    static var previews: some View {
        MainTextView(name: "Current chore", choreID: UUID())
    }
}
