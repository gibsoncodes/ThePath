//
//  Trees.swift
//  pth
//
//  Created by Riley Gibson on 1/28/21.
//

import SwiftUI

class Scenery {
    var path = Path()
    func sBush01 (currPoint: CGPoint) -> Path {
        var point = currPoint
        path.move(to: point)
        path.addLine(to: CGPoint(x: point.x, y: (point.y - 10)))
        path.move(to: CGPoint(x: point.x, y: point.y - 5))
        point = path.currentPoint!
        path.addLine(to: CGPoint(x: (point.x + 3), y: (point.y - 4)))
        path.move(to: point)
        path.addLine(to: CGPoint(x: (point.x - 3), y: (point.y - 4)))
        return path
        //.stroke(style: StrokeStyle(lineWidth: 1.0   , lineCap: .butt))
        //.fill(Color.black)
    }
    func sBush02 (currPoint: CGPoint) -> Path {
        var point = currPoint
        path.move(to: point)
        path.addLine(to: CGPoint(x: point.x, y: (point.y - 5)))
        point = path.currentPoint!
        path.addLine(to: CGPoint(x: (point.x + 3), y: (point.y - 4)))
        path.move(to: point)
        path.addLine(to: CGPoint(x: (point.x - 3), y: (point.y - 4)))
        return path
        
        //.stroke(style: StrokeStyle(lineWidth: 2.0   , lineCap: .butt))
        //.fill(Color.black)
    }
    func sBush03 (currPoint: CGPoint) -> Path {
        let point = currPoint
        path.move(to: point)
        path.addLine(to: CGPoint(x: point.x, y: (point.y - 5)))
        path.move(to: point)
        path.addLine(to: CGPoint(x: (point.x + 5), y: (point.y - 4)))
        path.move(to: point)
        path.addLine(to: CGPoint(x: (point.x - 5), y: (point.y - 4)))
    
        return path
    }
    func sBush04 (currPoint: CGPoint) -> Path {
        var point = currPoint
        path.move(to: point)
        path.addLine(to: CGPoint(x: point.x, y: (point.y - 10)))
        point = path.currentPoint!
        path.addLine(to: CGPoint(x: point.x, y: (point.y + 5)))
        point = path.currentPoint!
        path.addLine(to: CGPoint(x: (point.x + 3), y: (point.y - 5)))
        point = path.currentPoint!
        path.addLine(to: CGPoint(x: (point.x - 3), y: (point.y + 5)))
        point = path.currentPoint!
        path.addLine(to: CGPoint(x: (point.x - 3), y: (point.y - 5)))
        return path
    }
    func sBush05 (currPoint: CGPoint) -> Path {
        var point = currPoint
        path.move(to: point)
        path.addLine(to: CGPoint(x: point.x, y: (point.y - 10)))
        point = path.currentPoint!
        path.addLine(to: CGPoint(x: point.x, y: (point.y + 5)))
        point = path.currentPoint!
        path.addLine(to: CGPoint(x: (point.x + 3), y: (point.y - 5)))
        point = path.currentPoint!
        path.addLine(to: CGPoint(x: (point.x - 3), y: (point.y + 5)))
        point = path.currentPoint!
        path.addLine(to: CGPoint(x: (point.x - 3), y: (point.y - 5)))

        return path
    }
}

struct SceneryStruct: View {
    var body: some View {
        ZStack {
            Scenery().sBush02(currPoint: CGPoint(x: CGFloat(100), y: CGFloat(100)))
                .stroke(style: StrokeStyle(lineWidth: 2.0   , lineCap: .round))
                .fill(Color.black)
                .ignoresSafeArea()
            Scenery().sBush01(currPoint: CGPoint(x: CGFloat(120), y: CGFloat(100)))
                .stroke(style: StrokeStyle(lineWidth: 2.0   , lineCap: .round))
                .fill(Color.black)
                .ignoresSafeArea()
            Scenery().sBush04(currPoint: CGPoint(x: CGFloat(140), y: CGFloat(100)))
                .stroke(style: StrokeStyle(lineWidth: 2.0   , lineCap: .round))
                .fill(Color.black)
                .ignoresSafeArea()
        }
    }
}
