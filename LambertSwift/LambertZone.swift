//
//  LambertZone.swift
//  LambertSwift
//
//  Created by Yannick Heinrich on 03/12/15.
//  Copyright © 2015 yageek. All rights reserved.
//

import Foundation
/**
 Enum grouping all element about zones.
*/
public enum LambertZone :Int{
    case I = 0
    case II
    case III
    case IV
    case II_E
    case L93
    
    var n:Double {
        get {
            switch self {
            case .I: return 0.7604059656
            case .II : return 0.7289686274
            case .III: return 0.6959127966
            case .IV : return 0.6712679322
            case .II_E : return 0.7289686274
            case .L93: return 0.7256077650
            }
        }
    }
    var c:Double {
        get {
            switch self {
            case .I: return 11603796.98
            case .II : return 11745793.39
            case .III: return 11947992.52
            case .IV : return 12136281.99
            case .II_E : return 11745793.39
            case .L93: return 11754255.426
            }
        }
    }
    
    var xs :Double {
        get {
            switch self {
            case .I: return 600000.0
            case .II : return 600000.0
            case .III: return 600000.0
            case .IV : return 234.358
            case .II_E : return 600000.0
            case .L93: return 700000.0
            }
        }
    }
    
    var ys :Double {
        get {
            switch self {
            case .I: return 5657616.674
            case .II : return 6199695.768
            case .III: return 6791905.085
            case .IV : return 7239161.542
            case .II_E : return 8199695.768
            case .L93: return 12655612.050
            }
        }
    }

    
    
}