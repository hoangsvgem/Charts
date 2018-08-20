//
//  HalfPieChartViewController.swift
//  ChartsDemo-iOS
//
//  Created by Jacob Christie on 2017-07-09.
//  Copyright © 2017 jc. All rights reserved.
//

import UIKit
import Charts
class HalfPieChartViewController: DemoBaseViewController {

    @IBOutlet var chartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup(pieChartView: chartView)
        
        chartView.delegate = self
        
        chartView.holeColor = .white
        chartView.transparentCircleColor = NSUIColor.white.withAlphaComponent(0.43)
        chartView.transparentCircleRadiusPercent = 0
        chartView.holeRadiusPercent = 0.48
        chartView.rotationEnabled = false
        chartView.maxAngle = 180 // Half chart
        chartView.rotationAngle = 180 // Rotate to make the half on the upper side
        chartView.centerTextOffset = CGPoint(x: 0, y: -20)
        chartView.drawSlicesUnderHoleEnabled = true
        let l = chartView.legend
        l.horizontalAlignment = .center
        l.verticalAlignment = .top
        l.orientation = .horizontal
        l.drawInside = false
        l.xEntrySpace = 7
        l.yEntrySpace = 0
        l.yOffset = 0
        chartView.centerAttributedText = NSMutableAttributedString(string: "mBI")
        self.updateChartData()
//        chartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack) 
    }
    
    override func updateChartData() {
        if self.shouldHideData {
            chartView.data = nil
            return
        }
        
        self.setDataCount(2, range: 1)
    }

    func setDataCount(_ count: Int, range: UInt32) {
        let entries = (0..<count).map { (i) -> PieChartDataEntry in
            // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
            return PieChartDataEntry(value: 1,
                                     label: parties[i % parties.count])
        }
        
        let set = PieChartDataSet(values: entries, label: "Election Results")
        set.sliceSpace = 0
        set.selectionShift = 5
        set.colors = ChartColorTemplates.material()
        
        let data = PieChartData(dataSet: set)
        
        data.setDrawValues(false)
        chartView.drawEntryLabelsEnabled = false
        chartView.data = data
        
        chartView.setNeedsDisplay()
    }
}
