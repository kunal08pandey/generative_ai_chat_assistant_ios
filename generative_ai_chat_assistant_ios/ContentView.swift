import SwiftUI
import Playgrounds

struct ContentView: View {
    @State private var username = ""
    @State private var password = <redacted>    @State private var isLoading = false
    @State private var isDisabled = false

    var body: some View {
        VStack(spacing: 20) {
            TextFieldControl(label: "Username", placeholder: "Enter username", isSecure: false, text: $username, keyboardType: .default, onEditingChanged: { _ in }, onCommit: { })
            TextFieldControl(label: "Password", placeholder: "Enter password", isSecure: true, text: $password, keyboardType: .default, onEditingChanged: { _ in }, onCommit: { })
            PrimaryButton(label: "Login", action: { login() }, isLoading: isLoading, isDisabled: isDisabled)
            SecondaryButton(label: "Cancel", action: { }, isLoading: isLoading, isDisabled: isDisabled)
        }
        .padding()
    }

    private func login() {
        isLoading = true
        // Simulate login delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
            // Handle login success or failure
        }
    }
}

#Preview {
    ContentView()
}

#Playground {
    _ = 1 + 2
}
