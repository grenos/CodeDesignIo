//
//  UpdateStore.swift
//  DesignCode
//
//  Created by Vasileios  Gkreen on 25/09/2020.
//  Copyright © 2020 Meng To. All rights reserved.
//

import SwiftUI
import Combine


class UpdateStore: ObservableObject {
	@Published var updates: [Update] = updateData
}
