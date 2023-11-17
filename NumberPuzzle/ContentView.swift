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
        GeometryReader { geometry in
            VStack {
                Button("New Game") {
                    puzzleLogic.newGame()
                }
                .font(.title)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)

                let smallestDimension = min(geometry.size.width, geometry.size.height)
                let squareSize = smallestDimension / 4 - 10 // Adjust the -10 if more space is needed

                VStack(spacing: 5) {
                    ForEach(0..<4, id: \.self) { row in
                        HStack(spacing: 5) {
                            ForEach(0..<4, id: \.self) { column in
                                NumberSquareView(number: self.puzzleLogic.numbers[row * 4 + column], size: squareSize)
                                    .aspectRatio(1, contentMode: .fit)
                                    .onTapGesture {
                                        self.puzzleLogic.moveNumber(row: row, column: column)
                                    }
                            }
                        }
                    }
                }
                .padding(.horizontal)

                if puzzleLogic.hasWon {
                    Text("You Win!")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Text("Moves: \(puzzleLogic.moveCount)")
                    .font(.headline)
                    .padding()

                Button("Win Now") {
                    puzzleLogic.winNow()
                }
            }
            .padding()
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct NumberSquareView: View {
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
