//
//  EngamenteSDK.swift
//  LiveLIke
//
//  Created by Javier Etxarri on 11/8/23.
//

import Foundation
import EngagementSDK

class EngamenteSDK {
    static let shared = EngamenteSDK()
    let engagementSDK: EngagementSDK
    
    private init() {
        let sdkConfig = EngagementSDKConfig(clientID: "CLIENTID")
        engagementSDK = EngagementSDK(config: sdkConfig)
    }
}
