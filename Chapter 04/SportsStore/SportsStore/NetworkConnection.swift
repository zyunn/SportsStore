//
//  NetworkConnection.swift
//  SportsStore
//  模拟服务器
//  Created by HebeChung on 2016/11/1.
//  Copyright © 2016年 Apress. All rights reserved.
//

import Foundation

class NetworkConnection{
    private let stockData:[String:Int]=["Kayak":10,"Lifejacket":14,"Soccer Ball":32,
                                        "Stadium":4,"Thinking Cap":8 ,"Unsteady Chair":3,
                                        "Human Chess Board":2,"Bling-Bling King":4
                                        ]
    
    func getStockLevel(name:String) -> Int? {
        Thread.sleep(forTimeInterval: Double(2000))
        return stockData[name];
    }
    
}


