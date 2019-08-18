//
//  GCDWebServer.swift
//  Dgtle
//
//  Created by yfm on 2019/7/30.
//  Copyright © 2019 yfm. All rights reserved.
//

import Foundation
import GCDWebServer

class GCDWebServerManager {
    static let webServicePath = "http://localhost:9999"

    static let shared = GCDWebServerManager()
    var webServer: GCDWebServer!
    private init() {
        webServer = GCDWebServer()
    }
    
    func startWebServer() {
        if isSimulator { return }
        webServer.addGETHandler(forBasePath: "/", directoryPath: NSHomeDirectory(), indexFilename: "", cacheAge: 3600, allowRangeRequests: true)
        webServer.start(withPort: 9999, bonjourName: "")
        
    }
    
    func stopWebServer() {
        if isSimulator { return }
        if webServer.isRunning {
            webServer.stop()
        }
    }
}
