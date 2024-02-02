//
//  ContentView.swift
//  TicTacToe
//
//  Created by Mihai Postolache on 16.11.2023.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var game: GameService
    @StateObject var connectionManager: MPConnectionManager
    @State private var gameType: GameType = .undetermined
    @AppStorage("yourName") var yourName = ""
    @State private var opponentName = ""
    @FocusState private var focus: Bool
    @State private var startGame = false
    @State private var changeName = false
    @State private var newName = ""
    init(yourName: String) {
        self.yourName = yourName
        _connectionManager = StateObject(wrappedValue: MPConnectionManager(yourName: yourName))
    }
    var body: some View {
        VStack {
            HStack {
            Text("Hello, \(yourName)")
                .font(.system(size: 46))
                .bold()
                .padding(.leading, 1)
            Spacer()
                }
                .padding(.top, 30)
                .padding(.bottom, 90)
            Text("Let's play TicTacToe")
                .padding()
                .textFieldStyle(.plain)
                .font(.system(size: 20))

            Picker("Select Game", selection: $gameType){
                Text("Select Game Type").tag(GameType.undetermined)
                Text("Two Sharing device").tag(GameType.single)
                Text("Challenge your device").tag(GameType.bot)
                Text("Challenge a friend").tag(GameType.peer)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10, style:.continuous).stroke(lineWidth: 2))
            .accentColor(.primary)
            Text(gameType.description)
                .padding()
            VStack {
                switch gameType {
                case .single:
                        TextField("Opponent Name", text: $opponentName)
                case .bot:
                    EmptyView()
                case .peer:
                    MPPeersView(startGame: $startGame)
                        .environmentObject(connectionManager)
                case .undetermined:
                    EmptyView()
                }
            }
            .padding(0)
            .textFieldStyle(.roundedBorder)
            .focused($focus)
            .frame(width: 350)
            if gameType != .peer {
                Button("Start Game"){
                    game.setupGame(gameType: gameType, player1Name: yourName, player2Name: opponentName)
                    focus = false
                    startGame.toggle()
                }
 
                .buttonStyle(.borderedProminent)
                .disabled(
                    gameType == .undetermined ||
                    gameType == .single && opponentName.isEmpty
                )
                Spacer()
                Image("LaunchScreen")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                Spacer()
                Button("Change my name"){
                    changeName.toggle()
                }
                .buttonStyle(.bordered)
            }
            Spacer()
        }
        .padding()
        .fullScreenCover(isPresented: $startGame, content: {
            GameView()
                .environmentObject(connectionManager)
        })
        .alert("Change Name", isPresented: $changeName, actions: {
            TextField("New name", text: $newName)
            Button("OK", role: .destructive) {
                yourName = newName
                exit(-1)
            }
            Button("Cancel", role: .cancel){}
        }, message: {Text("Tapping on the OK button will quit the application so you can relaunch to use your changed name.")})
        .inNavigationStack()
    }
}

struct Startview_Previews: PreviewProvider {
    static var previews: some View {
        StartView(yourName: "Mihai")
            .environmentObject(GameService())
    }
}
