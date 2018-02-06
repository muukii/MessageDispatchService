//
//  main.swift
//  MessageDispatchService
//
//  Created by muukii on 2/6/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import Foundation

@objc
protocol MessageDispatchServiceProtocol {

}

final class MessageDispatcher : MessageDispatchServiceProtocol {

}

class ServiceDelegate : NSObject, NSXPCListenerDelegate {

  func listener(_ listener: NSXPCListener!, shouldAcceptNewConnection newConnection: NSXPCConnection!) -> Bool {

    newConnection.exportedInterface = NSXPCInterface.init(with: MessageDispatchServiceProtocol.self)

    let exportedObject = MessageDispatcher()
    newConnection.exportedObject = exportedObject
    newConnection.resume()
    return true
  }
}

// Create the listener and resume it:
//
let delegate = ServiceDelegate()
let listener = NSXPCListener.service()

listener.delegate = delegate
listener.resume()
