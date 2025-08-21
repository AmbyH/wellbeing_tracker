//
//  WellbeingTrackerWidgetBundle.swift
//  WellbeingTrackerWidget
//
//  Created by Amboise on 16/8/2025.
//

import WidgetKit
import SwiftUI

@main
struct WellbeingTrackerWidgetBundle: WidgetBundle {
    var body: some Widget {
        WellbeingTrackerWidget()
        WellbeingTrackerWidgetControl()
        WellbeingTrackerWidgetLiveActivity()
    }
}
