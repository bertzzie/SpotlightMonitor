//
// Created by Alex Xandra Albert Sim on 06/12/20.
//

import Foundation

func minutesToSpanString(min: Int) -> String {
    let (h, m) = (min / 60, min % 60)

    return String(format: "%02d:%02d", h, m)
}