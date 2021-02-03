//
//  road.swift
//  pth
//
//  Created by Riley Gibson on 1/20/21.
//

import SwiftUI
import Darwin

extension Double {
    func truncate(places : Int)-> Double
    {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}

class theRoad: ObservableObject {
    @Published var endBottomPoint: CGPoint
    @Published var endTopPoint: CGPoint
    @Published var endedAngle: Double
    var scene = Scenery()
    var pathTop = Path()
    var pathBottom = Path()
    private var maxX = 0.0
    private var topYPoint: Double = 187
    private var topXPoint: Double = 0
    private var bottomYPoint: Double = 200
    private var bottomXPoint: Double = 0
    private var topRadius: Double = .zero
    private var bottomRadius: Double = .zero
    private var newStartAng: Double = .zero
    private var newEndAng: Double = 270
    private var isClock: Bool = false
    private var didTurn: Int = 0
    
    init() {
        endTopPoint = CGPoint(x: 0, y: 200)
        endBottomPoint = CGPoint(x: 0, y: 200)
        endedAngle = 270
    }
    
    init(startBottomX: Double, startBottomY: Double, startTopX: Double, startTopY: Double, startAngle: Double) {
        topXPoint = startTopX
        topYPoint = startTopY
        bottomXPoint = startBottomX
        bottomYPoint = startBottomY
        newEndAng = startAngle
        endTopPoint = CGPoint(x: 0, y: 200)
        endBottomPoint = CGPoint(x: 0, y: 200)
        endedAngle = 270
        
    }
    
    func setMaxXPoint() {
        maxX = max(topXPoint, bottomXPoint)
    }
    
    func getMaxXPoint() -> Double {
        return maxX
    }
    
    
    func cosDegreesToRad (degree: Double ) -> Double {
        var ret = degree * (Double.pi / 180)
        ret = cos(ret).truncate(places: 10)
        return ret
    }

    func sinDegreesToRad (degree: Double ) -> Double {
        var ret = degree * (Double.pi / 180)
        ret = sin(ret).truncate(places: 10)
        return ret
    }
    
    func newCurve(topCurr: CGPoint, bottomCurr: CGPoint){
        topXPoint = Double(topCurr.x)
        topYPoint = Double(topCurr.y)
        bottomXPoint = Double(bottomCurr.x)
        bottomYPoint = Double(bottomCurr.y)

        if isClock {
            newStartAng = newEndAng + 180
        } else {
            newStartAng = newEndAng - 180
        }
        
        if isClock {
            isClock = false
        } else {
            isClock = true
        }
        
        if topYPoint > 275 {
            if !isClock {
                isClock = true
                newStartAng -= 180
            }
            didTurn += 1
        } else if topYPoint < 100 {
            if isClock {
                isClock = false
                newStartAng += 180
            }
            didTurn += 1
        }

        if newStartAng > 360 {
            let temp = newStartAng - 360
            newStartAng = 180 + temp
            if isClock {
                isClock = false
            } else {
                isClock = true
            }
        } else if newStartAng < 0 {
            let temp = abs(newStartAng)
            newStartAng = 360 - temp
            if isClock {
                isClock = true
            } else {
                isClock = false
            }
        }
        
        if isClock {
            newEndAng = Double.random(in: 1...newStartAng)
        } else {
            newEndAng = Double.random(in: newStartAng...359)
        }
        
        if newEndAng == newStartAng {
            if isClock {
                newEndAng = Double.random(in: 181...359)
            } else {
                newEndAng = Double.random(in: 1...179)
            }
        }
        
        if didTurn == 2 {
            didTurn = 0
            if newStartAng >= 270 || newStartAng <= 90 {
                if isClock {
                    isClock = false
                    newStartAng += 180
                    newEndAng = Double.random(in: newStartAng...270)
                } else {
                    isClock = true
                    newStartAng -= 180
                    newEndAng = Double.random(in: 90...newStartAng)
                }
            }
        }
        
        topRadius = Double.random(in: 30...60)
        bottomRadius = topRadius
        
        if isClock {
            bottomRadius += 4
            topRadius -= 4
        } else {
            topRadius += 4
            bottomRadius -= 4
        }
        
        let angle = newStartAng
        
        if angle <= 90 {
            topYPoint = topYPoint - abs((topRadius * sinDegreesToRad(degree: angle)))
            topXPoint = topXPoint - abs((topRadius * cosDegreesToRad(degree: angle)))
            bottomYPoint = bottomYPoint - abs((bottomRadius * sinDegreesToRad(degree: angle)))
            bottomXPoint = bottomXPoint - abs((bottomRadius * cosDegreesToRad(degree: angle)))
        } else if angle <= 180 {
            topYPoint = topYPoint - abs((topRadius * sinDegreesToRad(degree: angle)))
            topXPoint = topXPoint + abs((topRadius * cosDegreesToRad(degree: angle)))
            bottomYPoint = bottomYPoint - abs((bottomRadius * sinDegreesToRad(degree: angle)))
            bottomXPoint = bottomXPoint + abs((bottomRadius * cosDegreesToRad(degree: angle)))
        } else if angle <= 270 {
            topYPoint = topYPoint + abs((topRadius * sinDegreesToRad(degree: angle)))
            topXPoint = topXPoint + abs((topRadius * cosDegreesToRad(degree: angle)))
            bottomYPoint = bottomYPoint + abs((bottomRadius * sinDegreesToRad(degree: angle)))
            bottomXPoint = bottomXPoint + abs((bottomRadius * cosDegreesToRad(degree: angle)))
        } else if angle <= 360{
            topYPoint = topYPoint + abs((topRadius * sinDegreesToRad(degree: angle)))
            topXPoint = topXPoint - abs((topRadius * cosDegreesToRad(degree: angle)))
            bottomYPoint = bottomYPoint + abs((bottomRadius * sinDegreesToRad(degree: angle)))
            bottomXPoint = bottomXPoint - abs((bottomRadius * cosDegreesToRad(degree: angle)))
        }
    }
    
    func roadBuilder() -> Array<Path> {
        var topPoint: CGPoint
        var bottomPoint: CGPoint
        pathBottom.move(to: CGPoint(x: bottomXPoint, y: bottomYPoint))
        pathTop.move(to: CGPoint(x: topXPoint, y: topYPoint))
        for _ in 1...3 {
            topPoint = pathTop.currentPoint!
            bottomPoint = pathBottom.currentPoint!
            newCurve(topCurr: topPoint, bottomCurr: bottomPoint)
            pathTop.addArc(center: CGPoint(x: topXPoint, y: topYPoint), radius: CGFloat(topRadius), startAngle: .degrees(newStartAng), endAngle: .degrees(newEndAng), clockwise: isClock)
            pathBottom.addArc(center: CGPoint(x: bottomXPoint, y: bottomYPoint), radius: CGFloat(bottomRadius), startAngle: .degrees(newStartAng), endAngle: .degrees(newEndAng), clockwise: isClock)
            scene.sBush03(currPoint: CGPoint(x: topPoint.x, y: topPoint.y - 20))
        }
        bottomXPoint = Double(pathBottom.currentPoint!.x)
        bottomYPoint = Double(pathBottom.currentPoint!.y)
        topXPoint = Double(pathTop.currentPoint!.x)
        topYPoint = Double(pathTop.currentPoint!.y)
        setMaxXPoint()
        return [pathTop, pathBottom, scene.path]
    }
}
