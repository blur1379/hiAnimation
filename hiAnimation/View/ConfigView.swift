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



class ItemViewModel: ObservableObject {
    @AppStorage(AppStorageName.CONFIG.rawValue) var storedConfig = Data()
    @Published var config: [Config] = [] {
        didSet {
            saveConfig(config)
        }
    }
    
    init() {
        config = decodeConfig() ?? [Config(isTrue: false, name: "1"),
                                    Config(isTrue: false, name: "1"),
                                    Config(isTrue: false, name: "1")]
    }
    
    func saveConfig(_ configs: [Config]) {
        guard let data = encodeConfig(with: configs) else { return }
        storedConfig = data
    }
    
    func encodeConfig(with configs: [Config]) -> Data? {
        let encoder = JSONEncoder()
        do {
            return try encoder.encode(configs)
        } catch {
            print("encoder can't encode with error : \(error)")
            return nil
        }
    }
    
    func decodeConfig() -> [Config]? {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode([Config].self, from: storedConfig)
        } catch {
            print("decoder can't decode with error : \(error)")
            return nil
        }
    }
}

struct Config: Identifiable, Codable {
    var id: UUID = UUID()
    var isTrue: Bool
    var name: String
}

enum AppStorageName: String {
    case CONFIG
}
