//
//  Loading.swift
//  CascadeMobileAssessmentTonyBuckner
//
//  Created by Tony Buckner on 5/22/21.
//
//MARK: - Loading screen for when the API call takes two long and to let teh user know the app is working, even if there is an error.

import SwiftUI

struct LoadingView: View {
    var body: some View {
        
        ZStack() {
            
            Color(.systemBackground)
                .ignoresSafeArea()
                .opacity(0.8)
                    
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .red))
                .scaleEffect(6.0)
            
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
