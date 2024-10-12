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
        }detail: {
            UnavailableView()
        }
        .navigationTitle("Open Weather Map")
        .toolbar{
            //Text(wuStation)
            Button("load", systemImage: "gearshape.arrow.triangle.2.circlepath"){
                Task{
                    await fetchShortRangeForecast()
                   //await fetchCurrent()
                    await fetchFiveDay()
                   
                }
            }
            
        }
    }
    
    @MainActor
    func fetchShortRangeForecast() async{
        let url = URL(string: "https://api.openweathermap.org/data/3.0/stations/66ccf342cbd4230001e7ffea?appid=b416b34806cb6cf5ed4c04c1b30e4e1b")!
        #if DEBUG
            print("Lade 15 min. Intervall der nächsten 7 Stunden")
        #endif
        URLSession.shared.dataTask(with: url) { json, response, error in
            do{
                let json = json
                let decoder = JSONDecoder()
                do{
                    let decodedResponse = try decoder.decode(Stations.self, from: json!)
                    print(decodedResponse)
                    Task {
                        //await shortRange.update(shortRangeForecast: decodedResponse)
                        #if DEBUG
                          //  await shortRange.printShortRange()
                        #endif
                    }
                }catch{
                    #if DEBUG
                     print("Konnte nicht geladen werden")
                    #endif
                }
            }
        }.resume()
    }
    
    
   // https://api.openweathermap.org/data/2.5/forecast?lat=44.34&lon=10.99&appid=b416b34806cb6cf5ed4c04c1b30e4e1b
    @MainActor
    func fetchCurrent() async{
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=52.183&lon=8.417&appid=b416b34806cb6cf5ed4c04c1b30e4e1b&units=metric&lang=de")!
        #if DEBUG
            print("Lade current")
        #endif
        URLSession.shared.dataTask(with: url) { json, response, error in
            do{
                let json = json
                let decoder = JSONDecoder()
                do{
                    let decodedResponse = try decoder.decode(Current.self, from: json!)
                    print(decodedResponse)
                    Task {
                        //await shortRange.update(shortRangeForecast: decodedResponse)
                        #if DEBUG
                          //  await shortRange.printShortRange()
                        #endif
                    }
                }catch{
                    #if DEBUG
                     print("Konnte nicht geladen werden")
                    #endif
                }
            }
        }.resume()
    }
    
    @MainActor
    func fetchFiveDay() async{
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=52.183&lon=8.417&appid=b416b34806cb6cf5ed4c04c1b30e4e1b&units=metric&lang=de")!
        #if DEBUG
            print("Lade current")
        #endif
        URLSession.shared.dataTask(with: url) { json, response, error in
            do{
                let json = json
                let decoder = JSONDecoder()
                print(Date(timeIntervalSince1970: 1727989200))
                do{
                    let decodedResponse = try decoder.decode(FiveDayForecast.self, from: json!)
                    print(decodedResponse)
                    Task {
                        //await shortRange.update(shortRangeForecast: decodedResponse)
                        #if DEBUG
                          //  await shortRange.printShortRange()
                        #endif
                    }
                }catch{
                    #if DEBUG
                     print("Konnte nicht geladen werden")
                    #endif
                }
            }
        }.resume()
    }
    

    func testi(){
        let json  = """
                        {
                            "rain":{
                                        "1h": 0.3
                                    }
                        }
                        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        do{
            let decodedResponse = try decoder.decode(Current.self, from: json)
            print(decodedResponse)
            Task {
                //await shortRange.update(shortRangeForecast: decodedResponse)
                #if DEBUG
                  //  await shortRange.printShortRange()
                #endif
            }
        }catch{
            #if DEBUG
             print("Konnte nicht geladen werden")
            #endif
        }
        
    }
}

#Preview {
    ContentView()
}
