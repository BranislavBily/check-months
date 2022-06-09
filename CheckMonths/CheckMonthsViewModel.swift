//
//  CheckMonthsViewModel.swift
//  CheckMonths
//
//  Created by Branislav Bilý on 20.02.2022.
//

import SwiftUI
import CoreSpotlight

class CheckMonthsViewModel: ObservableObject {
    
    private var monthsCZToNormal: [String:String] = [
        "leden":"januar",
        "unor":"februar",
        "brezen":"march",
        "duben":"april",
        "kveten":"may",
        "cerven":"june",
        "cervenec":"july",
        "srpen":"august",
        "zari":"september",
        "rijen":"october",
        "listopad":"november",
        "prosinec":"december"
    ]
    
    private var monthsNormalToCZ: [String:String] = [
        "januar":"leden",
        "februar":"unor",
        "march":"brezen",
        "april":"duben",
        "may":"kveten",
        "june":"cerven",
        "july":"cervenec",
        "august":"srpen",
        "september":"zari",
        "october":"rijen",
        "november":"listopad",
        "december":"prosinec"
    ]
    
    func findMonth(key: String, state: Bool) -> String {
        let modifiedKey = key.lowercased()
        let result: [String : String] = {
            if(state) {
                return self.monthsNormalToCZ.filter { $0.key.starts(with: modifiedKey)}
            } else {
                return self.monthsCZToNormal.filter { $0.key.starts(with: modifiedKey)}
            }
        }()
        if (result.count == 1) {
            return result[result.startIndex].value
        }
        return "No Match"
    }
    
    func setupSearchableContent() {
        var searchableItems = [CSSearchableItem]()
        
        for(czech, _) in monthsCZToNormal {
            let translation = monthsCZToNormal[czech]!
            
            let searchableItemAttributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
            
            searchableItemAttributeSet.title = czech
            searchableItemAttributeSet.contentDescription = translation
            
            
            var keywords = [String]()
            
            for key in monthsCZToNormal.keys {
                keywords.append(key)
            }
            searchableItemAttributeSet.keywords = keywords
        
            let searchableItem = CSSearchableItem(uniqueIdentifier: "com.branislavbily.CheckMonths.\(czech)", domainIdentifier: "months", attributeSet: searchableItemAttributeSet)
            
            searchableItems.append(searchableItem)
            
            CSSearchableIndex.default().indexSearchableItems(searchableItems) { (error) -> Void in
                    if error != nil {
                        print(error?.localizedDescription ?? "Error")
                    }
                }
            
        }
    }
}
