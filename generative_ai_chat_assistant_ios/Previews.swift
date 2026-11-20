import SwiftUI

struct Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            TextFieldControl(label: "Username", placeholder: "Enter username", isSecure: false, text: .constant(""), keyboardType: .default, onEditingChanged: { _ in }, onCommit: { })
            TextFieldControl(label: "Password", placeholder: "Enter password", isSecure: true, text: .constant(""), keyboardType: .default, onEditingChanged: { _ in }, onCommit: { })
            PrimaryButton(label: "Login", action: { }, isLoading: false, isDisabled: false)
            SecondaryButton(label: "Cancel", action: { }, isLoading: false, isDisabled: false)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
