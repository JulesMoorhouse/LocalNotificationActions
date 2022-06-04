//
//  LocalNotificationActionsApp.swift
//  LocalNotificationActions
//
//  Created by Jules Moorhouse on 04/06/2022.
//

import SwiftUI

@main
struct LocalNotificationActionsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @StateObject var dataController: DataController

    init() {
        let dataController = DataController()
        _dataController = StateObject(wrappedValue: dataController)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataController)
        }
    }
}
