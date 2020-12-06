//
//  AppDelegate.swift
//  SpotlightMonitor
//
//  Created by Alex Xandra Albert Sim on 06/12/20.
//
//

import Cocoa
import SwiftUI


@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let batteryStatView = BatteryStatView()


        // Create the window and set the content view.
        window = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 1024, height: 768),
                styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                backing: .buffered, defer: false)

        window.isReleasedWhenClosed = false
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: batteryStatView)
        window.makeKeyAndOrderFront(nil)

        // remove title bar etc so it can be light spotlight
        window.titleVisibility = .hidden
        window.titlebarAppearsTransparent = true
        window.styleMask.insert(.fullSizeContentView)
        window.styleMask.remove(.closable)
        window.styleMask.remove(.fullScreen)
        window.styleMask.remove(.miniaturizable)
        window.styleMask.remove(.resizable)
    }


    func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
    }



}
