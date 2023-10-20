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
        loadWidget()
    }
    
    // MARK: - Init
    private func loadWidget() {
       engagementSDK.getWidgetModel(id: "99e20b30-3b94-47d9-8e29-bf6b6205eda2", kind: .textPoll) { [weak self] result in
          
          switch result {
             case .success(let widgetModel):
                if case let .poll(pollModel) = widgetModel {
                   self?.handlePollModel(pollModel, from: widgetModel)
                }
             case .failure(let error):
                self?.error = error
          }
       }
    }
    
    
    // MARK: - Private
    private func handlePollModel(_ pollModel: PollWidgetModel, from widgetModel: WidgetModel) {
       pollModel.loadInteractionHistory { [weak self] result in
          switch result {
             case .success:
                if let widget = self?.makeWidget(widgetModel: widgetModel) {
                   DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                      self?.presentWidget(widget)
                   }
                }
             case .failure(let error):
                self?.error = error
          }
       }
    }
    
    private func makeWidget(widgetModel: WidgetModel) -> Widget? {
       DefaultWidgetFactory.makeWidget(from: widgetModel)
    }
     
     private func presentWidget(_ widget: Widget){
         widget.view.frame = CGRect(x: horizontalPadding,
                                   y: widget.view.frame.minY,
                                   width: widget.view.frame.width - 2 * horizontalPadding,
                                   height: widget.view.frame.height)
        addChild(widget)
        view.addSubview(widget.view)
        widget.delegate = interactiveTimelineWidgetViewDelegate
        widget.moveToNextState()
     }
}
