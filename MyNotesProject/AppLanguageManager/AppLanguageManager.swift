//
//  AppLanguageManager.swift
//  MyNotesProject
//
//  Created by Nurtilek on 3/20/24.
//

import Foundation

enum languageType: String {
    case kg = "ky-KG"
    case ru = "ru"
    case en = "en"
}

class AppLanguageManager {
    
    static let shared = AppLanguageManager()
    
    private var currentLanguge: languageType?
    
    private var currentBundle: Bundle = Bundle.main
    
    var bundle: Bundle {
        return currentBundle
    }
    
    func setApplanguage(language: languageType) {
       setCurrentlanguage(language: language)
        setCurrentBabdlePath(languageCode: language.rawValue)
    }
    
    private func setCurrentlanguage(language: languageType) {
        currentLanguge = language
        //TODO: добавить сохранение userDefaults
    }
    
    private func setCurrentBabdlePath(languageCode: String) {
        guard let bundle = Bundle.main.path(forResource: languageCode, ofType: "lproj"), let langBundle = Bundle(path: bundle) else {
            currentBundle = Bundle.main
            return
        }
        currentBundle = langBundle
    }
    
}

extension String {
    func localized() -> String {
        let bundle = AppLanguageManager.shared.bundle
        return NSLocalizedString(self, tableName: "Localizable", bundle: bundle, value: "", comment: "")
    }
}
