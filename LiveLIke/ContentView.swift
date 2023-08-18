//
//  ContentView.swift
//  LiveLIke
//
//  Created by Javier Etxarri on 11/8/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("This is main view")
            }
            NavigationLink("Click here and go to the Poll") {
                WidgetSwiftIUI(engagementSDK: EngamenteSDK.shared.engagementSDK, horizontalPadding: 15)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
