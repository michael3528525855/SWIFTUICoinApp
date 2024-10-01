//
//  CoinView.swift
//  SWIFTUICoinApp
//
//  Created by michael on 29/09/2024.
//

import SwiftUI

struct CoinView: View {
    
    @StateObject private var viewModel = CoinVewModel()
    
    /// A bindable property that holds the index of the selected fruit from the list
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        VStack {
            Text("ByteCoin")
                .font(.largeTitle)
            //Image("B")
            HStack{
                Text("BitcoinImage")
                Spacer()
                Text(viewModel.price)
                Spacer()
                Text(viewModel.currencyArray[selectedIndex])
            }
            .padding()
            .background(.gray.opacity(0.3))
            .cornerRadius(10.0)
            
            Spacer()
            
            /// A picker bound to the `selectedFruitIndex` property.
            /// This displays and allows selection from the `fruits` list.
            Picker("Select your favorite fruit", selection: $selectedIndex) {
                ForEach(0 ..< viewModel.currencyArray.count, id: \.self) { index in
                    Text(self.viewModel.currencyArray[index]).tag(index)
                    
                }
            }
            .pickerStyle(.inline)
            //-------
            .onChange(of: selectedIndex) { newValue in
                let selectedCurrency = viewModel.currencyArray[newValue]
                viewModel.fitchData(currncy: selectedCurrency)  // Fetch new data when the currency changes
            }
        }
        .padding()
        .background(Color("BackgroundColor"))
        //-------------
        .onAppear {
            let selectedCurrency = viewModel.currencyArray[selectedIndex]
            viewModel.fitchData(currncy: selectedCurrency)  // Fetch data initially for the selected currency
        }
    }
    
}

#Preview {
    CoinView()
}
