//
//  GuessTheColorView.swift
//  SUIBT
//
//  Created by Zach Eriksen on 6/8/20.
//  Copyright © 2020 oneleif. All rights reserved.
//

import SwiftUI

enum GuessColorDifficulty: CGFloat {
    case hard = 48
    case medium = 24
    case easy = 8
    case zero = 0
}

extension GuessColorDifficulty: CaseIterable { }

struct GuessTheColorView: View {
    let difficulty: GuessColorDifficulty
    
    private let targetRed: CGFloat = CGFloat.random(in: 0 ... 1)
    private let targetGreen: CGFloat = CGFloat.random(in: 0 ... 1)
    private let targetBlue: CGFloat = CGFloat.random(in: 0 ... 1)
    
    @State private var red: CGFloat = 1
    @State private var green: CGFloat = 1
    @State private var blue: CGFloat = 1
    
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Text("Match the colors")
            
            Color(UIColor(red: red,
                          green: green,
                          blue: blue,
                          alpha: 1))
                .frame(width: 120,
                       height: 120,
                       alignment: .center)
                .cornerRadius(60)
                .padding(self.difficulty.rawValue)
                .background(Color.black)
                .cornerRadius(60)
                .padding(16)
                .background(Color(UIColor(red: targetRed,
                green: targetGreen,
                blue: targetBlue,
                alpha: 1)))
                .cornerRadius(60)
                .padding()
            
            Text("R: \(Int(red * 256)) G: \(Int(green * 256)) B: \(Int(blue * 256))")
            
            HStack {
                Text("Red")
                Slider(value: $red)
            }
            
            HStack {
                Text("Green")
                Slider(value: $green)
            }
            
            HStack {
                Text("Blue")
                Slider(value: $blue)
            }
            
            Button(action: { self.showAlert = true }) {
                Text("Submit")
                    .foregroundColor(.white)
                    .frame(minWidth: 0,
                           maxWidth: 368,
                           minHeight: 60,
                           maxHeight: 60,
                           alignment: .center)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Your Score"),
                      message: Text("\(computeScore())"))
            }
            
        }
    }
    
    func computeScore() -> Int {
        let rD = red - targetRed
        let gD = green - targetGreen
        let bD = blue - targetBlue
        let diff = sqrt(rD * rD + gD * gD + bD * bD)
        return Int((1.0 - diff) * 100.0 + 0.5)
    }
}

struct GuessTheColorView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(GuessColorDifficulty.allCases, id: \.self) { difficulty in
            GuessTheColorView(difficulty: difficulty)
        }
    }
}
