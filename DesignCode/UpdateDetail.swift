//
//  UpdateDetail.swift
//  DesignCode
//
//  Created by Vasileios  Gkreen on 25/09/2020.
//  Copyright © 2020 Meng To. All rights reserved.
//

import SwiftUI

struct UpdateDetail: View {
	
	var update: Update = updateData[0]
	
	
    var body: some View {
		
		List {
			VStack(alignment: .leading) {
				Image(update.image)
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(maxWidth: .infinity)
				
				Text(update.text)
					.frame(maxWidth: .infinity, alignment: .leading)
			}
			.navigationBarTitle(update.title)
		}
		.listStyle(PlainListStyle())
		
    }
}

struct UpdateDetail_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetail()
    }
}
