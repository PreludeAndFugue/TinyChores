//
//  ChoreView.swift
//  TinyChores03
//
//  Created by gary on 20/09/2020.
//  Copyright © 2020 Gary Kerr. All rights reserved.
//

import SwiftUI

struct ChoreView: View {
    let chore: Chore
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(chore.name)
                    .font(.system(.title, design: .rounded))

                Text(chore.period.name)
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.purple)
            }
            .padding([.top, .bottom], 8)
            Spacer()
        }
    }
}


#if DEBUG
struct ChoreView_Previews: PreviewProvider {
    static var previews: some View {
        ChoreView(chore: Chore(id: UUID(), name: "Chore name", period: .day, date: Date()))
    }
}
#endif
