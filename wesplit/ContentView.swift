//
//  ContentView.swift
//  wesplit
//
//  Created by Victor Hristov on 23/10/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double = 0.0
    @State private var numberOfPeople: Int = 2
    @State private var tipPerc: Int = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercs: [Int] = [0, 5, 10, 15, 20, 25]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        let tipAmount = Double(tipPerc)
        
        let tipVal = (checkAmount / 100) * tipAmount
        let total = checkAmount + tipVal
        let amountPerPerson = total / peopleCount
        
        return amountPerPerson
    }
    
    func resetFields() -> () {
        checkAmount = 0.0
        numberOfPeople = 2
        tipPerc = 20
        
        return
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Amount and people").foregroundStyle(.indigo)) {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                        
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100, id: \.self) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header: Text("How much do you want to leave?").foregroundStyle(.indigo)) {
                    Picker("Tip percentage", selection: $tipPerc) {
                        ForEach(tipPercs, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section(header: Text("Amount per person").foregroundStyle(.indigo)) {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section {
//                        Button(action: {
//                            amountIsFocused = false
//                        }) {
//                            Text("Remove keyboard").foregroundStyle(.indigo)
//                        }
                        Button(action: resetFields) {
                            Text("Reset").foregroundStyle(.red)
                        }
                }
            }.navigationTitle("Tippers")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard, content: {
                        Button(action: {amountIsFocused = false}) {
                            Text("Done")
                        }
                    })
                }
            
           
        }.tint(Color.indigo)
    }
}
#Preview {
    ContentView()
}
