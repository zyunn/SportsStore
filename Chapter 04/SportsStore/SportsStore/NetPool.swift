//
//  NetPool.swift
//  SportsStore
//
//  Created by HebeChung on 2016/11/1.
//  Copyright © 2016年 Apress. All rights reserved.
//

import Foundation

public class NetPool {
    private let connectCount=3
    private var connections=[NetworkConnection]()
    private var semaphore:DispatchSemaphore
    private var queue:DispatchQueue
    
    init() {
        for _ in 0..<connectCount {
            self.connections.append(NetworkConnection())
        }
        semaphore=DispatchSemaphore(value: connectCount)
        queue=DispatchQueue(label: "networkpoolQ")
    }
    
    private func doGetConnection() -> NetworkConnection{
        var  result :NetworkConnection?=nil
        if semaphore.wait(timeout: DispatchTime.distantFuture)==DispatchTimeoutResult.success{
            queue.async {
                result=self.connections.remove(at: 0)
            }
        }
        return result!
    }
    
    private func doReturnConnection(networkConnection:NetworkConnection){
        semaphore.signal();
        connections.append(networkConnection)
    }
   
    // 这里素用的单列模式
    class func getConnect()->NetworkConnection{
        return sharedInstance.doGetConnection()
    }
    
    class func returnConnect(con:NetworkConnection){
        sharedInstance.doReturnConnection(networkConnection: con)
    }

    private class var sharedInstance:NetPool{
        get{
            struct SingletonWrapper{
                static let singleton=NetPool()
            }
            
            return SingletonWrapper.singleton
        }
    }
    
    
    
    
}
