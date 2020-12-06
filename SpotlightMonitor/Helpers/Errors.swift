//
// Created by Alex Xandra Albert Sim on 06/12/20.
//

import Foundation

enum SpotlightMonitorError : Error {
    case IOKitError(error: String)
    case IOKitPsError(error: String)
}