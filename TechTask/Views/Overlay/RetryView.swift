//
//  RetryView.swift
//  TechTask
//
//  Created by Alexandr Bahno on 11.11.2023.
//

import SwiftUI

struct RetryView: View {

    let text: String
    let retryAction: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            Text(text)
                .font(.callout)
                .multilineTextAlignment(.center)

            Button(action: retryAction) {
                Text("Try Again")
            }
        }
    }
}
