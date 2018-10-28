//
//  MultipeerCommunicator.swift
//  TinkoffChat
//
//  Created by Artur on 28/10/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

import Foundation
import MultipeerConnectivity


protocol Communicator {
    func sendMessage(string: String, to userID: String, completionHandler: ((_ success: Bool, _ error: Error?) -> ())?)
    var delegate: CommunicatorDelagate? {get set}
    var online: Bool {get set}
}

protocol CommunicatorDelagate {
    func didFoundUser(userID: String, userName: String)
    func didLostUser(userID: String)
    
    func failedToStartBrowsingForUsers(error: Error)
    func failedToStartAdvertising(error: Error)
    
    func didRecieveMessage(text: String, fromUser: String, toUser: String)
}

class MultipeerCommunicator: NSObject, Communicator {
    
    func sendMessage(string: String, to userID: String, completionHandler: ((Bool, Error?) -> ())?) {
        print("fff")
    }
    
    var delegate: CommunicatorDelagate?
    
    var online: Bool
    private let myPeerID = MCPeerID(displayName: UIDevice.current.name)
    private let session: MCSession

    let advertiser: MCNearbyServiceAdvertiser
    let browser : MCNearbyServiceBrowser

    
    
    init(delegate: CommunicatorDelagate?, online: Bool) {
        
        self.advertiser = MCNearbyServiceAdvertiser(peer: myPeerID, discoveryInfo: nil, serviceType: "tinkoff-chat")
        
        self.browser = MCNearbyServiceBrowser(peer: myPeerID, serviceType: "tinkoff-chat")

        self.delegate = delegate
        self.online = online
        self.session = MCSession(peer: myPeerID)
        
        super.init()
        
        self.advertiser.startAdvertisingPeer()
        self.browser.startBrowsingForPeers()
        
        self.advertiser.delegate = self
        self.browser.delegate = self
    }
    
    deinit {
        self.advertiser.stopAdvertisingPeer()
        self.browser.stopBrowsingForPeers()
    }
    
    
}


extension MultipeerCommunicator: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
    
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        if session.connectedPeers.contains(peerID) {
            invitationHandler(false, nil)
        } else {
            invitationHandler(true, session)
        }
    }
}


extension MultipeerCommunicator: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        browser.invitePeer(peerID, to: session, withContext: nil, timeout: 10)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        print("lost \(peerID)")
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        print("lost \(error)")
    }
    

}

