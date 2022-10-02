//
//  HeroStats.swift
//  ApiImageData
//
//  Created by Naing Linn Aung on 10/1/22.
//

import Foundation


struct HeroStats: Decodable {
    let localized_name: String
    let primary_attr:String
    let attack_type: String
    let legs: Int
    let img: String
}


