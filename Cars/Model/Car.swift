//
//  Car.swift
//  Car
//
//  Created by Никита Бурин on 13.01.2023.
//

import Foundation

enum Car: String, CaseIterable {
    case Bmw, Mercedes, Audi, Toyota, Porsche
}

var carsArray: [String] = {
    var x = [String]()
    for value in Car.allCases {
        x.append(value.rawValue)
    }
    return x
}()

