//
//  ConfigView.swift
//  hiAnimation
//
//  Created by Mohammad Blur on 1/18/24.
//

import SwiftUI
import Combine

struct ConfigView: View {
    @StateObject var itemVM : ItemViewModel = ItemViewModel()
    
    var body: some View {
        VStack{
            ForEach($itemVM.config) { config in
                HStack{
                    Picker(selection: config.name , label: Text("select name")) {
                        ForEach(["1","2","3"] ,id: \.self) { name in
                            Text(name)
                        }
                    }
                    .pickerStyle(.segmented)
                    Toggle("", isOn: config.isTrue)
                }
                .padding()
            }
            
            ForEach(itemVM.config) { config in
                Text("selected name is \(config.name) and \(config.isTrue ? " TRUE ": " FALSE")")
            }
            
            Text("\(itemVM.storedConfig)")
                .padding()
        }
    }
}

#Preview {
    ConfigView()
}
