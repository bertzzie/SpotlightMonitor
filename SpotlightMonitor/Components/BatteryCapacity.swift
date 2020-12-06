//
// Created by Alex Xandra Albert Sim on 06/12/20.
//

import Foundation
import SwiftUI

struct BatteryCapacity : View {
    var info: BatteryInfo

    var body: some View {
        VStack {
            HStack {
                if #available(OSX 11.0, *) {
                    ProgressView(value: Float(info.capacity) / 100)
                            .accentColor(progressColor(status: info.status))
                } else {
                    Text("Capacity:")
                }

                if info.isCharging {
                    Text(" 🔌 ")
                }

                Text("\(info.capacity)%")
            }

            if info.isCharging {
                HStack {
                    Text("Time to Full")
                    Spacer()
                    Text(minutesToSpanString(min: info.timeToFull))
                }

                Text("Electrical Info")
                    .font(.subheadline)

                HStack {
                    Text("Voltage")
                    Spacer()
                    Text(String(format: "%d mV", info.voltage))
                }
                HStack {
                    Text("Amperage")
                    Spacer()
                    Text(String(format: "%d mA", info.amperage))
                }
                HStack {
                    Text("Charging Current")
                    Spacer()
                    Text(String(format: "%d mA", info.chargingCurrent))
                }
            } else {
                HStack {
                    Text("Time Remaining")
                    Spacer()
                    Text(minutesToSpanString(min: info.timeRemaining))
                }
            }
        }
    }
}

private func progressColor(status: BatteryStatus) -> Color {
    switch status {
    case .Normal: return Color.accentColor
    case .Critical: return Color.red
    case .Warn: return Color.orange
    }
}
