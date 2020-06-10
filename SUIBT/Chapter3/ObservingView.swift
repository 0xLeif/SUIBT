//
//  ObservingView.swift
//  SUIBT
//
//  Created by Zach Eriksen on 6/9/20.
//  Copyright © 2020 oneleif. All rights reserved.
//

import SwiftUI
import Combine

class SimpleTimer: ObservableObject {
    var timer: Timer?
    @Published var counter = 0
    
    init() {
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(updateCounter),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc func updateCounter() {
        counter += 1
        
        print(counter)
    }
    
    func killTimer() {
        defer {
            timer = nil
        }
        
        timer?.invalidate()
    }
}

struct ObservingView: View {
    @ObservedObject var timer = SimpleTimer()
    
    var body: some View {
        VStack {
            Path { path in
                path.move(to: CGPoint(x: 100, y: 100))
                path.addArc(center: CGPoint(x: 100, y: 200), radius: 10, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 30), clockwise: true)
                path.addCurve(to: <#T##CGPoint#>, control1: <#T##CGPoint#>, control2: <#T##CGPoint#>)
            }
            .fill(Color.red)
            Text("Hello, World!\n\(timer.counter)").font(.body).foregroundColor(.red)
        }
    }
}

struct ObservingView_Previews: PreviewProvider {
    static var previews: some View {
        ObservingView()
    }
}
