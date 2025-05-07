//
//  PieChart.swift
//  Meninet
//
//  Created by HLD on 19/05/2024.
//

import SwiftUI

struct PieChart: View {
    var data: [Double]
    var colors: [Color]
    
    private var angles: [Angle] {
        var angles = [Angle]()
        let total = data.reduce(0, +)
        var startAngle = Angle(degrees: 0)
        
        for value in data {
            let endAngle = startAngle + Angle(degrees: 360 * (value / total))
            angles.append(startAngle)
            angles.append(endAngle)
            startAngle = endAngle
        }
        return angles
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<self.data.count) { index in
                    PieSlice(startAngle: self.angles[index * 2], endAngle: self.angles[index * 2 + 1])
                        .fill(self.colors[index])
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .frame(width: geometry.size.width * 0.55, height: geometry.size.width * 0.75)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
    }
}
