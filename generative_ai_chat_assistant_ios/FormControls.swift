import SwiftUI

struct TextFieldControl: View {
    let label: String
    let placeholder: String
    let isSecure: Bool
    @Binding var text: String
    let keyboardType: UIKeyboardType
    let onEditingChanged: (Bool) -> Void
    let onCommit: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(Typography.subheadline)
                .foregroundColor(Colors.text)
            if isSecure {
                SecureField(placeholder, text: $text)
                    .keyboardType(keyboardType)
                    .onEditingChanged(onEditingChanged)
                    .onCommit(onCommit)
            } else {
                TextField(placeholder, text: $text)
                    .keyboardType(keyboardType)
                    .onEditingChanged(onEditingChanged)
                    .onCommit(onCommit)
            }
        }
        .padding()
        .background(Colors.background)
        .cornerRadius(8)
    }
}

struct ButtonControl: View {
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
