//
// Created by Alex Xandra Albert Sim on 06/12/20.
//

import IOKit

func getIOProperties(className: String) throws -> [[String:Any]] {
    var results = [[String:Any]]()
    let matchDict = IOServiceMatching(className)
    var iterator = io_iterator_t()
    if (IOServiceGetMatchingServices(kIOMasterPortDefault, matchDict, &iterator) == kIOReturnSuccess) {
        var regEntry: io_registry_entry_t = IOIteratorNext(iterator)
        while (regEntry != io_object_t(0)) {
            var properties: Unmanaged<CFMutableDictionary>? = nil
            if (IORegistryEntryCreateCFProperties(regEntry, &properties, kCFAllocatorDefault, 0) == kIOReturnSuccess) {
                guard let prop = properties?.takeUnretainedValue() as? [String:Any] else {
                    throw SpotlightMonitorError.IOKitError(error: className)
                }

                properties?.release()
                results.append(prop)
            }
            IOObjectRelease(regEntry)
            regEntry = IOIteratorNext(iterator)
        }
        IOObjectRelease(iterator)
    }

    return results
}

