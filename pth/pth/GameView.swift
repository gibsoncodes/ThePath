//
//  GameView.swift
//  pth
//
//  Created by Riley Gibson on 1/29/21.
//

import SwiftUI
/*
struct GameView: View {
    var body: some View {
        
    }
}
 */
var instance = theRoad()
var path = instance.roadBuilder()
struct roadWork: View {
    @State private var pathTop = path[0]
    @State private var pathBottom = path[1]
    @State private var scenery = path[2]
    @State private var percentage: CGFloat = .zero
    @State private var offset: Double = 0.0
    @State private var xpoint = 0.0
    @State private var numberOfPaths: Int = 0
    var body: some View {
        ZStack {
            Color(red: 0, green: 0, blue: 0, opacity: 0.08)
            pathTop
            .stroke(style: StrokeStyle(lineWidth: 3.0, lineCap: .round))
            .fill(Color.black)
            .offset(x: CGFloat(offset), y: 0.0)
            pathBottom
            .stroke(style: StrokeStyle(lineWidth: 3.0, lineCap: .round))
            .fill(Color.black)
            .offset(x: CGFloat(offset), y: 0.0)
            scenery
            .stroke(style: StrokeStyle(lineWidth: 3.0, lineCap: .round))
            .fill(Color.black)
            .offset(x: CGFloat(offset), y: 0.0)
            Button(action: {
                path = instance.roadBuilder()
                pathTop = path[0]
                pathBottom = path[1]
                scenery = path[2]
                self.xpoint = Double(pathTop.currentPoint!.x)
            }) {
                Text("MERP")
            }
        }.onAppear {
            withAnimation(.linear(duration: 10.0)) { self.offset = (xpoint * -1) }
        }
        .ignoresSafeArea()
    }
    
}
