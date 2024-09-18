//
//  DataSave.swift
//  KuComics
//
//  Created by weixin on 2024/3/18.
//

import Foundation

class DataSave {
    static func setAppId() {
        UserDefaults.standard.setValue("12345", forKey: "AppId")
    }
    
    static func getAppId() -> String {
        return UserDefaults.standard.string(forKey: "AppId") ?? "45678"
    }
}

extension UserDefaults {
    func setItem<T: Encodable>(_ object: T, forKey key: String) {
        
        let encoder = JSONEncoder()
        guard let encoded = try? encoder.encode(object) else {
            return
        }
        
        self.set(encoded, forKey: key)
    }
    
    func getItem<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        
        guard let data = self.data(forKey: key) else {
            return nil
        }
        
        let decoder = JSONDecoder()
        guard let object = try? decoder.decode(type, from: data) else {
            print("Couldnt find key")
            return nil
        }
        
        return object
    }
}
