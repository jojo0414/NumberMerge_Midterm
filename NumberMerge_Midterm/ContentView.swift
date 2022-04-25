//
//  ContentView.swift
//  NumberMerge_Midterm
//
//  Created by 陳昕喬 on 2022/4/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var numberBlock = NumberArray()
    
    var body: some View {
        GameView()
            .environmentObject(numberBlock)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
