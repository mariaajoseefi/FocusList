//
//  EmptyStateView.swift
//  FocusList
//
//  Created by majo on 23/04/26.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "checkmark.circle")
                .font(.system(size: 60))
                .foregroundColor(.gray.opacity(0.5))
            
            Text("No Tasks Yet")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Tap the + button to create your first task")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6))
    }
}

#Preview {
    EmptyStateView()
}
