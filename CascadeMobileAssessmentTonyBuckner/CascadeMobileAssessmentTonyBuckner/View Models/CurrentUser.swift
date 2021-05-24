//
//  CurrentUser.swift
//  CascadeMobileAssessmentTonyBuckner
//
//  Created by Tony Buckner on 5/22/21.
//
//MARK: - Current user view model, with the ability to set another user here in the future.

import Foundation
import SwiftUI

class CurrentUser: ObservableObject {
    
    @Published var details = User(firstName: "Tony",
                                  lastName: "Buckner",
                                  accountNumber: 8827493,
                                  balance: 12.87,
                                  email: "tony.buckner26@gmail.com")
    
    init() { }
    
    ///Change current user
    func changeUser(newUser: User) {
        performUIUpdatesOnMain {
            self.details = newUser
        }
    }
    
}
