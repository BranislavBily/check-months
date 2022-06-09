//
//  ContentView.swift
//  CheckMonths
//
//  Created by Branislav Bilý on 20.02.2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: CheckMonthsViewModel
    
    @State var text: String = "Enter month"
    
    @State private var isToggle: Bool = false
    
    
    var body: some View {
        VStack {
            Toggle(isOn: $isToggle) {
                Text(isToggle ? "Normal to CZ" : "CZ to normal")
            }
            TextEditor(text: $text)
                .padding()
            Text(self.viewModel.findMonth(key: text, state: isToggle))
                .padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: CheckMonthsViewModel())
    }
}
