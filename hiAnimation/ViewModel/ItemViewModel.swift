//
//  ItemViewModel.swift
//  hiAnimation
//
//  Created by Mohammad Blur on 1/18/24.
//

import SwiftUI

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
