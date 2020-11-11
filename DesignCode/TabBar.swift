//
//  TabBar.swift
//  DesignCode
//
//  Created by Vasileios  Gkreen on 25/09/2020.
//  Copyright © 2020 Meng To. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
		TabView {
			Home()
				.tabItem {
					Image(systemName: "house")
					Text("Home")
				}
		}
		.edgesIgnoringSafeArea(.top)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
