//
//  WidgetViewController.swift
//  LiveLIke
//
//  Created by Javier Etxarri on 11/8/23.
//

import SwiftUI
import EngagementSDK

class WidgetViewController: UIViewController {
    
    var engagementSDK: EngagementSDK!
    var horizontalPadding: CGFloat!
    var error: Error?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        engagementSDK.getWidget(id: "99e20b30-3b94-47d9-8e29-bf6b6205eda2", kind: .textPoll) { result in
            switch result {
                case .success(let widget):
                    widget.didMove(toParent: self)
                    widget.view.frame = CGRect(x: self.horizontalPadding,
                                               y: widget.view.frame.minY,
                                               width: widget.view.frame.width - 2 * self.horizontalPadding,
                                               height: widget.view.frame.height)
                    self.addChild(widget)
                    self.view.addSubview(widget.view)
                                           
                    // This should not be necessary but it seems that if it does not exists
                    // the poll does not change to interactive mode
                    let nextHour = Date().advanced(by: 3600) // One hour in advanced
                    if widget.widgetModel?.interactiveUntil ?? nextHour > Date() {
                        widget.moveToNextState()
                    }
                   
                case .failure(let error):
                    self.error = error
            }
        }
    }
}
