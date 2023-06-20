//
//  ScriptingCommands.swift
//  MiniSim
//
//  Created by Oskar Kwasniewski on 18/06/2023.
//

import Foundation
import Cocoa

class GetDevicesCommand: NSScriptCommand {
    override func performDefaultImplementation() -> Any? {
        guard let platform = self.evaluatedArguments!["platform"] as? Platform.RawValue else {
            return "Error: Unexpected argument passed"
        }
        
        let encoder = JSONEncoder()
        
        do {
            let devices = try platform == Platform.android.rawValue ? DeviceService.getAndroidDevices() : DeviceService.getIOSDevices()
            
            let encoded = try encoder.encode(devices)
            return String(data: encoded, encoding: .utf8)
        } catch {
            return "Error"
        }
    }
}
