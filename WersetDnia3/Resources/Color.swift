//
//  Color.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 30/03/2021.
//

import SwiftUI

public struct GradientColor {
    public let start: Color
    public let end: Color
    
    init(start: Color, end: Color) {
        self.start = start
        self.end = end
    }
    
    public func getGradient() -> Gradient {
        return Gradient(colors: [start, end])
    }
}

enum GradientColors {
    static let green = GradientColor(start: Color("0BCDF7"), end: Color("A2FEAE"))
    static let blu = GradientColor(start: Color("0591FF"), end: Color("29D9FE"))
    static let bluPurpl = GradientColor(start: Color("4ABBFB"), end: Color("8C00FF"))
    static let purple = GradientColor(start: Color("741DF4"), end: Color("C501B0"))
    static let prplPink = GradientColor(start: Color("BC05AF"), end: Color("FF1378"))
    static let prplNeon = GradientColor(start: Color("FE019A"), end: Color("FE0BF4"))
    static let orngPink = GradientColor(start: Color("FF8E2D"), end: Color("FF4E7A"))
}

extension Color {

    func uiColor() -> UIColor {

        let components = self.components()
        return UIColor(red: components.r, green: components.g, blue: components.b, alpha: components.a)
    }

    private func components() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {

        let scanner = Scanner(string: self.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0

        let result = scanner.scanHexInt64(&hexNumber)
        if result {
            r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            a = CGFloat(hexNumber & 0x000000ff) / 255
        }
        return (r, g, b, a)
    }
}
