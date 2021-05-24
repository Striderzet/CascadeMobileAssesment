//
//  UtilityMethods.swift
//  CascadeMobileAssessmentTonyBuckner
//
//  Created by Tony Buckner on 5/22/21.
//
//MARK: - This file would be my Swiss Army Knife for methods.

import Foundation
import UIKit

///Convert CGFloat to dollar string
func truncateZeros(_ number: Double) -> String {
    
    var newStr = "$\(number)"
    
    if newStr == "$0.0" {
        return newStr
    }
    
    if let startDotIndex = newStr.firstIndex(of: ".") {
        newStr.removeSubrange(newStr.index(startDotIndex, offsetBy: 3)..<newStr.endIndex)
    }
    
    return newStr
}

///Returns true if user balance is greater than price.
func balanceCheck(userBalance: Double, pokemonPrice: Double) -> Bool {
    return userBalance >= pokemonPrice
}
