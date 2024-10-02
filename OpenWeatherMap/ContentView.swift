//
//  ContentView.swift
//  OpenWeatherMap
//
//  Created by Olaf on 02.10.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationSplitView{
            List{
                Section("PWS"){
                    NavigationLink{
                        UnavailableView()
                    }label: {
                        Label("PWS", systemImage: "house")
                    }
                }
            }
            .navigationTitle("Open Weather Map")
        }detail: {
            UnavailableView()
        }
    }
}

#Preview {
    ContentView()
}
