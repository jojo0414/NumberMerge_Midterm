//
//  numberArray.swift
//  NumberMerge_Midterm
//
//  Created by 陳昕喬 on 2022/4/22.
//

import Foundation
import SwiftUI

enum imageState{
    case nonImage, numberImage
}

class NumberArray: ObservableObject{
    @Published var number: [NumberBlock]
    @Published var nextImageName: Int
    @Published var score: Int
    
    init()
    {
        number = [NumberBlock](repeating: NumberBlock(state: imageState.nonImage, numberImageName: 0), count: 25)
        nextImageName = Int.random(in: 1...3)
        score = 0
    }
    
    func reset()
    {
        number = [NumberBlock](repeating: NumberBlock(state: imageState.nonImage, numberImageName: 0), count: 25)
        nextImageName = Int.random(in: 1...3)
        score = 0
    }
    
    func getNeighbor(index: Int) -> [Int]
    {
        var neighbor = [Int]()
        
        //check top
        if index - 5 >= 0
        {
            neighbor.append(index - 5)
        }
        
        //check left
        if (index - 1) / 5 == index / 5 && index - 1 >= 0
        {
            neighbor.append(index - 1)
        }
        
        //check right
        if (index + 1) / 5 == index / 5
        {
            neighbor.append(index + 1)
        }
        
        //check bottom
        if index + 5 < 25
        {
            neighbor.append(index + 5)
        }
        
        return neighbor
    }
    
    func mergeBlocks(index: Int)
    {
        var isMergered = false
        let neighbor = getNeighbor(index: index)
        for i in neighbor
        {
            if self.number[i].state == imageState.numberImage && self.number[index].numberImageName == self.number[i].numberImageName
            {
                isMergered = true
                self.number[i].state = imageState.nonImage
                self.number[i].numberImageName = 0
            }
        }
        if isMergered == true
        {
            self.score += 1
            self.number[index].numberImageName += 1
            mergeBlocks(index: index)
        }
    }
    
    func checkFull() -> Bool
    {
        var isFull = true
        for i in Range(0...24)
        {
            if self.number[i].state == imageState.nonImage
            {
                isFull = false
            }
        }
        return isFull
    }
    
    struct NumberBlock{
        var state: imageState
        var numberImageName: Int
    }
}
