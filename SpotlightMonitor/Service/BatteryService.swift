//
// Created by Alex Xandra Albert Sim on 06/12/20.
//

import Foundation
import IOKit.ps

struct BatteryService {
    static func getBatteryInfos() throws -> BatteryInfo {
        let data = try getIOProperties(className: "IOPMPowerSource")
        if (data.count == 0) {
            throw SpotlightMonitorError.IOKitError(error: "No battery found.")
        }

        let battery = data.first!
        guard let chargeInfo = battery["ChargerData"] as? [String:Int] else {
            throw SpotlightMonitorError.IOKitError(error: "No battery charger info.")
        }

        let capacity = try getCapacity()
        let status = getStatus(pSource: battery)

        return BatteryInfo(
            cycleCount: battery["CycleCount"] as? Int ?? 0,
            designCapacity: battery["DesignCapacity"] as? Int ?? 0,
            maxCapacity: battery["MaxCapacity"] as? Int ?? 0,
            currentCapacity: battery["CurrentCapacity"] as? Int ?? 0,
            voltage: battery["Voltage"] as? Int ?? 0,
            amperage: battery["Amperage"] as? Int ?? 0,
            chargingCurrent: chargeInfo["ChargingCurrent"] ?? 0,
            timeRemaining: battery["TimeRemaining"] as? Int ?? 0,
            timeToFull: battery["AvgTimeToFull"] as? Int ?? 65535,
            timeToEmpty: battery["AvgTimeToEmpty"] as? Int ?? 65535,
            isCharging: battery["IsCharging"] as? Bool ?? false,
            status: status,
            capacity: capacity
        )
    }

    private static func getCapacity() throws -> Int {
        let snapshot = IOPSCopyPowerSourcesInfo().takeRetainedValue()
        let sources = IOPSCopyPowerSourcesList(snapshot).takeRetainedValue()

        for ps in sources as Array<CFTypeRef> {
                let info: NSDictionary =
                IOPSGetPowerSourceDescription(snapshot, ps as CFTypeRef).takeUnretainedValue()

            return info[kIOPSCurrentCapacityKey] as? Int ?? 0
        }

        throw SpotlightMonitorError.IOKitPsError(error: "Battery Capacity % not found.")
    }

    private static func getStatus(pSource: [String: Any]) -> BatteryStatus {
        let isAtWarn = pSource["AtWarnLevel"] as? Bool ?? false
        let isAtCrit = pSource["AtCriticalLevel"] as? Bool ?? false

        if isAtWarn {
            return BatteryStatus.Warn
        } else if isAtCrit {
            return BatteryStatus.Critical
        }

        return BatteryStatus.Normal
    }
}