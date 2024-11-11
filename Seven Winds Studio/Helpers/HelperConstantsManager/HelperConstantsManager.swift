//
//  HelperConstantsManager.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 12/11/24.
//

final class HelperConstantsManager {
    
    static let shared = HelperConstantsManager()
    
    var userEmail: String = ""
    
    private init(){}
    
    func deleteAllConstants(){
        userEmail = ""
    }
}
