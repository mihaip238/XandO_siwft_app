//
//  TicTacToeApp.swift
//  TicTacToe
//
//  Created by Mihai Postolache on 16.11.2023.
//

import SwiftUI

struct AppEntry: App {
    @AppStorage("yourName") var yourName = ""
    @StateObject var game = GameService()
    var body: some Scene {
        WindowGroup {
            if yourName.isEmpty {
                YourNameView()
            }else {
                StartView(yourName: yourName)
                    .environmentObject(game)
            }
        }
    }
}
