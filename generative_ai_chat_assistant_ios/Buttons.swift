import SwiftUI

struct PrimaryButton: View {
    let label: String
    let action: () -> Void
    let isLoading: Bool
    let isDisabled: Bool

    var body: some View {
        Button(action: action) {
            if isLoading {
                ProgressView()
            } else {
                Text(label)
                    .font(Typography.body)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
        }
        .disabled(isDisabled || isLoading)
        .background(isDisabled || isLoading ? Colors.secondary : Colors.primary)
        .cornerRadius(8)
    }
}

struct SecondaryButton: View {
    let label: String
    let action: () -> Void
    let isLoading: Bool
    let isDisabled: Bool

    var body: some View {
        Button(action: action) {
            if isLoading {
                ProgressView()
            } else {
                Text(label)
                    .font(Typography.body)
                    .foregroundColor(Colors.primary)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
        }
        .disabled(isDisabled || isLoading)
        .background(Colors.background)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Colors.primary, lineWidth: 2)
        )
    }
}
