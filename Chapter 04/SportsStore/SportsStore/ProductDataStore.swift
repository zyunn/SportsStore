//
//  ProductDataStore.swift
//  SportsStore
//
//  Created by HebeChung on 2016/11/3.
//  Copyright © 2016年 Apress. All rights reserved.
//

import Foundation

class ProductDataStore{
    var callback:((Product) -> Void)?;
    private var networkQ:DispatchQueue
    private var uiQ:DispatchQueue;
    lazy var products:[Product] = self.loadData();
    
    init() {
        networkQ = DispatchQueue.global(qos: DispatchQoS.QoSClass.background);
        uiQ = DispatchQueue.main;
    }
    
    private func loadData() -> [Product] {
        for p in productData {
            networkQ.async(execute: {
            let stockConn = NetPool.getConnect();
            let level = stockConn.getStockLevel(name: p.name);
                if (level != nil) {
                    p.stockLevel = level!;
                    self.uiQ.async(execute: {
                        if (self.callback != nil) {
                            self.callback!(p);
                        }
                    })
            }
                NetPool.returnConnect(con: stockConn);
            });
        }
        return productData;
    }
    
    private var productData:[Product] = [
        Product(name:"Kayak", description:"A boat for one person",
                category:"Watersports", price:275.0, stockLevel:0),
        Product(name:"Lifejacket", description:"Protective and fashionable",
                category:"Watersports", price:48.95, stockLevel:0),
        Product(name:"Soccer Ball", description:"FIFA-approved size and weight",
                category:"Soccer", price:19.5, stockLevel:0),
        Product(name:"Corner Flags",
                description:"Give your playing field a professional touch",
                category:"Soccer", price:34.95, stockLevel:0),
        Product(name:"Stadium", description:"Flat-packed 35,000-seat stadium",
                category:"Soccer", price:79500.0, stockLevel:0),
        Product(name:"Thinking Cap", description:"Improve your brain efficiency",
                category:"Chess", price:16.0, stockLevel:0),
        Product(name:"Unsteady Chair",
                description:"Secretly give your opponent a disadvantage",
                category: "Chess", price: 29.95, stockLevel:0),
        Product(name:"Human Chess Board", description:"A fun game for the family",
                category:"Chess", price:75.0, stockLevel:0),
        Product(name:"Bling-Bling King",
                description:"Gold-plated, diamond-studded King",
                category:"Chess", price:1200.0, stockLevel:0)];
    
    
    
    
}
