//
//  Selection.swift
//  Instagram
//
//  Created by Junho Choi on 6/18/20.
//  Copyright © 2020 Junho Choi. All rights reserved.
//

import Foundation
import SwiftUI

enum Selection: Int, CaseIterable, Identifiable{
    case grid
    case table
    
    var id: UUID{
        return UUID()
    }
    
    var image: Image{
        switch self{
        case .grid :
            return Image(systemName: "square.grid.2x2.fill")
        case .table :
            return Image(systemName: "list.dash")
        }
    }
}
