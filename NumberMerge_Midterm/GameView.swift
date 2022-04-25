//
//  GameView.swift
//  NumberMerge_Midterm
//
//  Created by 陳昕喬 on 2022/4/21.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var numberBlocks: NumberArray
    
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
                .opacity(0.8)
            mergeView()
                .padding()
            BlockView()
                .frame(width: 60, height: 60)
                .offset(x: 0, y: 230)
            VStack{
                Text("Score")
                    .foregroundColor(.white)
                    .font(.title)
                Text("\(numberBlocks.score)")
                    .foregroundColor(.white)
                    .font(.title)
            }
            .offset(x: 0, y: -250)
        }
    }
}

struct mergeView: View {
    @EnvironmentObject var numberBlocks: NumberArray
    @State private var isFull = false
    
    var body: some View{
        let columns = Array(repeating: GridItem(), count: 5)
        LazyVGrid(columns: columns) {
            ForEach(0..<25) { index in
                VStack{
                    if numberBlocks.number[index].state == imageState.nonImage
                    {
                        Rectangle()
                            .aspectRatio(1, contentMode: .fit)
                            .opacity(0.5)
                    }
                    else
                    {
                        BlockView(index: index)
                    }
                }
                .onTapGesture {
                    if numberBlocks.number[index].state == imageState.nonImage
                    {
                        numberBlocks.number[index].state = imageState.numberImage
                        numberBlocks.number[index].numberImageName = numberBlocks.nextImageName
                        numberBlocks.nextImageName = Int.random(in: 1...3)
                        numberBlocks.mergeBlocks(index: index)
                    }
                    isFull = numberBlocks.checkFull()
                }
                .alert("YOU DIED", isPresented: $isFull, actions: {
                    
                    Button {
                        numberBlocks.reset()
                    } label: {
                        Text("OK")
                    }
                }, message: {
                    Text("Score:\(numberBlocks.score)")
                })
            }
        }
    }
}

struct BlockView: View{
    var index: Int?
    @EnvironmentObject var numberBlocks: NumberArray
    
    var body: some View{
        ZStack
        {
            Rectangle()
                .aspectRatio(1, contentMode: .fit)
                .opacity(0.5)
            if index != nil
            {
                if numberBlocks.number[index!].state == imageState.numberImage
                {
                    Image("\(numberBlocks.number[index!].numberImageName)")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                    Text("\(numberBlocks.number[index!].numberImageName)")
                        .foregroundColor(.white)
                        .font(.title2)
                        .offset(x: 20, y: 20)
                }
            }
            else
            {
                Image("\(numberBlocks.nextImageName)")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                
                Text("\(numberBlocks.nextImageName)")
                    .foregroundColor(.white)
                    .font(.title2)
                    .offset(x: 20, y: 20)
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
