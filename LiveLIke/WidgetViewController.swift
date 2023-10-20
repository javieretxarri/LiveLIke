//
//  WidgetViewController.swift
//  LiveLIke
//
//  Created by Javier Etxarri on 11/8/23.
//

import UIKit
import EngagementSDK

class WidgetViewController: UIViewController {
    private let  interactiveTimelineWidgetViewDelegate = InteractiveTimelineWidgetViewDelegate()

    var engagementSDK: EngagementSDK!
    var horizontalPadding: CGFloat!
    var error: Error?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        engagementSDK.getWidgetModel(id: "99e20b30-3b94-47d9-8e29-bf6b6205eda2", kind: .textPoll) { result in
            switch result {
                case .success(let widget):
                    
                    self.handleResult(widgetModel: widget)
                    
                case .failure(let error):
                    self.error = error
            }
        }
    }
    
    func presentWidget(widget: Widget){
        DispatchQueue.main.async { [weak self] in
            if let self = self {
//                widget.theme = self.customTheme
                widget.view.frame = CGRect(x: self.horizontalPadding,
                                           y: widget.view.frame.minY,
                                           width: widget.view.frame.width - 2 * self.horizontalPadding,
                                           height: widget.view.frame.height)
                self.addChild(widget)
                self.view.addSubview(widget.view)
                widget.delegate = self.interactiveTimelineWidgetViewDelegate
                widget.moveToNextState()
            }
        }
    }
    
    func handleResult(widgetModel: WidgetModel) {
        if case let .poll(pollModel) = widgetModel {
            pollModel.loadInteractionHistory { result in
                switch result {
                    case .success(_):
                        let widget = DefaultWidgetFactory.makeWidget(from: widgetModel)
                        if let widget {
                            self.presentWidget(widget: widget)
                        }
                        
                    case .failure(let error):
                        self.error = error
                }
            }
        }
    }
}
