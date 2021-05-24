//
//  DispatchMethods.swift
//  CascadeMobileAssessmentTonyBuckner
//
//  Created by Tony Buckner on 5/22/21.
//
//MARK: - Quick simplified method for handling certain methods on the main queue only.

import Foundation

///Will perform functions on the main thread.
func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
