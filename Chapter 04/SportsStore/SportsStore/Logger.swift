//
//  Logger.swift
//  SportsStore
//
//  Created by HebeChung on 2016/10/31.
//  Copyright © 2016年 Apress. All rights reserved.
//

import Foundation

let productLogger=Logger<Product>(callback:{(p:Product) in
    print("change:\(p.name) \(p.stockLevel) intems in stock")
    }
)

class Logger<T> where T:NSObject, T:NSCopying {
    
    var detailItems:[T] = [];
    
    var callback:(T)->Void;
    
    var arrayQ=DispatchQueue(label: "arrayQ");
    
    var callBackQ=DispatchQueue(label: "callBackQ");
    
    // 保护回调
    init(callback:@escaping (T)->Void,protect:Bool=true) {
        self.callback=callback
        if protect {
            self.callback={
                (item:T) in
                self.callBackQ.async(execute: {
                callback(item)
                })
            }
        }
    }
    
    // 保护数组
    func logItems(item:T) {
        arrayQ.sync(flags:.barrier, execute: {
        detailItems.append(item.copy() as! T)
            callback(item)}
        )
          }
    
    func processTtems(callback:(T) -> Void) {
        arrayQ.sync(execute: {
            for item in detailItems{
                callback(item)
            }
        })
            }

}
