//
// Created by Alex Xandra Albert Sim on 06/12/20.
//

import Foundation
import SwiftUI

struct BatteryStatView: View {
    @State private var info: BatteryInfo = try! BatteryService.getBatteryInfos()

    var body: some View {
        Text("Spotlight Monitor")
            .font(.title)

        List {
            Section(header: Text("Battery")) {
                BatteryCapacity(info: info)
            }
        }
    }
}

struct BatteryStatView_Previews: PreviewProvider {
    static var previews: some View {
        BatteryStatView()
    }
}
