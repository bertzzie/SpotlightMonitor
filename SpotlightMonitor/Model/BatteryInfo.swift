//
// Created by Alex Xandra Albert Sim on 06/12/20.
//

import Foundation

public struct BatteryInfo {
    public let cycleCount: Int
    public let designCapacity: Int
    public let maxCapacity: Int
    public let currentCapacity: Int

    public let voltage: Int
    public let amperage: Int
    public let chargingCurrent: Int

    public let timeRemaining: Int
    public let timeToFull: Int
    public let timeToEmpty: Int
    public let isCharging: Bool
    public let status: BatteryStatus

    public let capacity: Int
}

public enum BatteryStatus: String, CaseIterable, Codable, Hashable {
    case Normal = "Normal"
    case Warn = "Warn"
    case Critical = "Critical"
}