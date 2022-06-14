//
//  ContentView.swift
//  SocialWatchApp WatchKit Extension
//
//  Created by Aydın Serhat SEZEN on 14.06.2022.
//

import SwiftUI
import WatchConnectivity

struct ContentView: View {
    @ObservedObject var model = ViewModelWatch()
    @State private var EnrouteText = "Enroute"

    var body: some View {
        ZStack {
            if self.model.session.isReachable && self.model.messageText == "true" {
                MainListView()
            } else {
                Text("Cihazınızda oturum açınız!")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
