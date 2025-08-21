import Foundation

struct SyncSettings {
    static let prefix = "sync"

    static func ReloadFromCloud() {
        Swift.print("RELOADING...")
        let dict = NSUbiquitousKeyValueStore.default.dictionaryRepresentation
        for (key, value) in dict {
            if key.hasPrefix(prefix) {
                UserDefaults.standard.set(value, forKey: key)
                Swift.print(key, value)
            }
        }
    }

    static func SaveToCloud() {
        Swift.print("SAVING...")
        let dict = UserDefaults.standard.dictionaryRepresentation()
        for (key, value) in dict {
            if key.hasPrefix(prefix) {
                NSUbiquitousKeyValueStore.default.set(value, forKey: key)
                Swift.print(key, value)
            }
        }
        NSUbiquitousKeyValueStore.default.synchronize()
    }
}

