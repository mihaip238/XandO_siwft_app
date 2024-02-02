//
//  YourNameView.swift
//  TicTacToe
//
//  Created by Mihai Postolache on 17.11.2023.
//

import SwiftUI

struct YourNameView: View {
    @AppStorage("yourName") var yourName = ""
    @State private var userName = ""
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                    Text("Welcome")
                    .font(.system(size: 46)) // Set your desired font size here
                    .bold()
                    .padding(.leading, 1) // Add padding to align with the navigation bar leading
                  Spacer()
                        }
                        .padding(.top, 30)
                        .padding(.bottom, 60)
            Spacer()
            Text("Please enter your name below.")
                .padding(.bottom, 20)
            TextField("Your Name", text: $userName)
                .textFieldStyle(.roundedBorder)
            Button("Continue") {
                yourName = userName
            }
            .buttonStyle(.borderedProminent)
            .disabled(userName.isEmpty)
            Spacer()
            Image("LaunchScreen")
            Spacer()
        }
        .padding()
        .inNavigationStack()
    }
}

#Preview {
    YourNameView()
}
