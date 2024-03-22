//
//  AppLanguageManager.swift
//  MyNotesProject
//
//  Created by Nurtilek on 3/20/24.
//

import Foundation

enum languageType: String {
    case kg = "Kyzgyzstan"
    case ru = "Russian"
    case en = "America"
}

class AppLanguageManager {
    static let shared = AppLanguageManager()
    
    private var currentLanguge: languageType?
    
    private var currentBundle: Bundle = Bundle.main
    
}
