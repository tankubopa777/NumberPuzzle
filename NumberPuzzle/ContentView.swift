//
//  ContentView.swift
//  NumberPuzzle
//
//  Created by warunporn intarachana on 9/11/2566 BE.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var puzzleLogic = PuzzleLogic()

    var body: some View {
//      Use GeometryReader for make ui adapt with screen
        GeometryReader { geometry in
            VStack {
                Button("New Game") {
                    puzzleLogic.newGame()
                }
                .font(.title)
                .foregroundColor(.white)
                .padding()
                
              
//              define screen size
                let minScreenSize = min(geometry.size.width, geometry.size.height)
//              define box of number size
                let boxSize = minScreenSize / 4 - 10

//              create number box 4x4
                VStack(spacing: 5) {
                    ForEach(0..<4, id: \.self) { row in
                        HStack(spacing: 5) {
                            ForEach(0..<4, id: \.self) { column in
                                BoxNumber(number: self.puzzleLogic.numbers[row * 4 + column], size: boxSize)
                                    .aspectRatio(1, contentMode: .fit)
                                    .onTapGesture {
                                        self.puzzleLogic.moveNumber(row: row, column: column)
                                    }
                            }
                        }
                    }
                }
                .padding(.horizontal)

//              show text when you win
                if puzzleLogic.hasWon {
                    Text("You Win!")
                        .font(.largeTitle)
                        .padding()
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Text("Moves: \(puzzleLogic.moveCount)")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()

//                This code use for check winner
//                Button("Win Now") {
//                    puzzleLogic.winNow()
//                }
            }
            .padding()
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color(red: 0.2, green: 0.2, blue: 0.2, opacity: 1.0))
        }
    }
}

// config box number
struct BoxNumber: View {
    let number: Int
    let size: CGFloat

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(number == 0 ? Color.clear : Color.pink)
                .frame(width: size, height: size)
            if number != 0 {
                Text("\(number)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }
    }
}
