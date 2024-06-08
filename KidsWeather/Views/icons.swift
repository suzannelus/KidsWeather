//
//  icons.swift
//  KidsWeather
//
//  Created by Suzanne Lustenhouwer on 08/06/2024.
//

import Foundation
import SwiftUI

struct Cloudy: View {
    var body: some View {
        ZStack {
            //Image("cloudbackground")
           //     .resizable()
            //    .scaledToFit()
            CloudShape()
                .padding(20)
                .foregroundColor(.gray)
                .shadow(radius: 10)
        }
    }
}

#Preview {
    Cloudy()
    
}


struct Sunny: View {
    var body: some View {
        ZStack {
           // Color.blue
            Image("cloudbackground")
                .resizable()
                .scaledToFit()
            Circle()
                .foregroundColor(.yellow)
                .padding(260)
            
          
            
            ForEach(0..<8) { ray in
                Capsule()
                    .foregroundColor(.yellow)
                    .offset(x: 380)
                    .frame(width:  140, height: 40)
                    .rotationEffect(Angle(degrees: 45 * Double(ray)))
                    
            }
                
            
        }
    }
}

#Preview {
    Sunny()
}


struct CloudShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = rect.width
        let height = rect.height
        
        // Start at bottom-left
        path.move(to: CGPoint(x: 0.26 * width, y: 0.66 * height))
        
        //  left curve
        path.addCurve(to: CGPoint(x: 0.29 *  width, y: 0.4 * height),
                      control1: CGPoint(x: 0.045 * width, y: 0.66 * height),
                      control2: CGPoint(x: 0.04 * width, y: 0.38 * height))
        
        // Top  curve
        path.addCurve(to: CGPoint(x: 0.76 * width, y: 0.45 * height),
                      control1: CGPoint(x: 0.38 * width, y: 0.22 * height),
                      control2: CGPoint(x: 0.67 * width, y: 0.2 * height))
        
        //  right curve
        path.addCurve(to: CGPoint(x: 0.8 * width, y: 0.66 * height),
                      control1: CGPoint(x: 0.99 * width, y: 0.4 * height),
                      control2: CGPoint(x: 0.999 * width, y: 0.67 * height))
        return path
    }
}


struct shapeWithArc:Shape{
    func path(in rect: CGRect) -> Path {
        Path{ path in
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addArc(center: CGPoint(x: rect.midX, y: rect.minY), radius: rect.height / 2, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 180), clockwise: false)
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        }
    }
}

struct QuadShape: Shape{
    func path(in rect: CGRect) -> Path {
        Path{ path in
            path.move(to: .zero)
            path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.midY), control: CGPoint(x: rect.maxX - 50, y: rect.midY - 100))
        }
    }
}


struct WaterShape: Shape{
    func path(in rect: CGRect) -> Path {
        Path{path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.midY), control: CGPoint(x: rect.width * 0.25, y: rect.height * 0.40))
            path.addQuadCurve(to: CGPoint(x: rect.maxY, y: rect.midY), control: CGPoint(x: rect.width * 0.75, y: rect.height * 0.60))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
    }
}
