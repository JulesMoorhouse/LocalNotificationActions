//
//  ContentView.swift
//  LocalNotificationActions
//
//  Created by Jules Moorhouse on 04/06/2022.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @EnvironmentObject var dataController: DataController

    var body: some View {
        VStack {
            Button(action: {
                dataController.registerLocal()
            }, label: {
                Text("Register Local")
            })

            Button(action: {
                dataController.scheduleLocal()
            }, label: {
                Text("Schedule Local")
            })
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
