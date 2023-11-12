//
//  DataFetchPhaseOverlayView.swift
//  TechTask
//
//  Created by Alexandr Bahno on 11.11.2023.
//

import SwiftUI

protocol EmptyData {
    var isEmpty: Bool { get }
}

struct DataFetchPhaseOverlayView<V: EmptyData>: View {

    let phase: DataFetchPhase<V>
    let retryAction: () -> Void

    var body: some View {
        switch phase {
        case .empty:
            VStack {
                ProgressView()
                    .padding()
                Text("Loading...")
            }
        case .success(let value) where value.isEmpty:
            EmptyPlaceholderView(text: "No data", image: Image(systemName: "film"))
        case .failure(let error):
            RetryView(text: error.localizedDescription, retryAction: retryAction)
        default:
            EmptyView()
        }
    }
}
