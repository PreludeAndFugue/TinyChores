//
//  AddChoreView.swift
//  TinyChores03
//
//  Created by gary on 22/09/2020.
//  Copyright © 2020 Gary Kerr. All rights reserved.
//

import SwiftUI

struct AddChoreView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: AddChoreViewModel


    var body: some View {
        #if os(macOS)
        macOSContent
        #else
        iOSContent
        #endif
    }


    #if os(macOS)
    private var macOSContent: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Add Chore")
                .font(.headline)

            Form {
                TextField("Title", text: $viewModel.name)
                Picker("Period", selection: $viewModel.selectedPeriod) {
                    ForEach(viewModel.periodNames.indices, id: \.self) { index in
                        Text(viewModel.periodNames[index])
                    }
                }
            }

            HStack {
                Spacer()
                saveButton
            }
        }
        .padding()
        .frame(width: 360)
    }
    #endif


    #if os(iOS)
    private var iOSContent: some View {
        NavigationView {
            Form {
                TextField("Title", text: $viewModel.name)
                Picker(selection: $viewModel.selectedPeriod, label: Text("Period")) {
                    ForEach(viewModel.periodNames.indices, id: \.self) { i in
                        Text(viewModel.periodNames[i])
                    }
                    .navigationBarTitle("Period", displayMode: .inline)
                }
            }
            .navigationBarTitle("Add", displayMode: .inline)
            .navigationBarItems(trailing: saveButton)
        }
    }
    #endif


    private var saveButton: some View {
        Button(action: save) {
            Text("Save")
        }
        .foregroundColor(.purple)
        .buttonStyle(PlainButtonStyle())
        .disabled(!viewModel.canSave)
    }


    func save() {
        viewModel.save()
        presentationMode.wrappedValue.dismiss()
    }
}



struct AddChoreView_Previews: PreviewProvider {
    private static let vm = AddChoreViewModel(db: .init(userDefaults: .standard))

    static var previews: some View {
        AddChoreView(viewModel: vm)
    }
}
