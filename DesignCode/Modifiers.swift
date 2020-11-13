//
//  Modifiers.swift
//  DesignCode
//
//  Created by Vasileios  Gkreen on 13/11/2020.
//  Copyright © 2020 Meng To. All rights reserved.
//

import SwiftUI

struct ShadowModifier: ViewModifier {
	func body(content: Content) -> some View {
		content
			.shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
			.shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
	}
}

struct FontModifier: ViewModifier {
	var style: Font.TextStyle = .body
	
	func body(content: Content) -> some View {
		content
			.font(.system(style, design: .default))
	}
}


struct CustomFontModifier: ViewModifier {
	var type: String = "Regular"
	var size: CGFloat = 16
	
	func body(content: Content) -> some View {
		content.font(.custom("WorkSans-\(type)", size: size))
	}
}
