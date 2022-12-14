import Foundation

/*
 Сервис для управления загрузками и сохранениями настроек
 */

class SettingsManager {
    
    private let defaultSettingsStorage = DefaultSettingsStorage()
    private let settingsStorage = SettingsStorage()
    
    public init() throws {
        let settings = try self.loadSettings()
        try self.saveUserSettings(settings: settings)
    }
    
    /*
     Метод проверки и загрузки настроек приложения
     */
    private func loadSettings() throws -> Settings {
        if let settings = try settingsStorage.getUserSettings() {
            return settings
        } else {
            return try defaultSettingsStorage.getSettings()
        }
    }
    
    /*
     Метод получения сохранных настроек из settingsStorage, в случае отсутствия настроек будет производиться бросание ошибки
     */
    func getSettings() throws -> Settings {
        guard let settings = try settingsStorage.getUserSettings() else {
            throw SettingsErrors.noUserSettings
        }
        return settings
    }
    
    /*
     Метод сохранения пользовательских настроек
     */
    func saveUserSettings(settings: Settings) throws {
        try settingsStorage.saveUserSettings(settings: settings)
    }
}
