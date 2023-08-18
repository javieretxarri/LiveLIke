//
//  WidgetSwiftIUI.swift
//  LiveLIke
//
//  Created by Javier Etxarri on 11/8/23.
//

import SwiftUI
import EngagementSDK

struct WidgetSwiftIUI: UIViewControllerRepresentable {
    typealias UIViewControllerType = WidgetViewController
    
    let engagementSDK: EngagementSDK
//    let customTheme: Theme
    let horizontalPadding: CGFloat
    
    func makeUIViewController(context: Context) -> WidgetViewController {
        let widgetViewController = WidgetViewController()
        widgetViewController.engagementSDK = engagementSDK
        widgetViewController.horizontalPadding = horizontalPadding
//        widgetViewController.customTheme = customTheme
        
        return widgetViewController
    }
    
    func updateUIViewController(_ uiViewController: WidgetViewController, context: Context) {
        // Nothing to do
    }
}
