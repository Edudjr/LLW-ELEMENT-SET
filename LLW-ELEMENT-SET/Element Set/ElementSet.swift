//
//  ElementSet.swift
//  LLW-ELEMENT-SET
//
//  Created by Eduardo Domene Junior on 03/11/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import Foundation

class ElementSet {
    typealias Operation = (value: Int, timestamp: Date)
    
    var addSet = [Element]()
    var removeSet = [Element]()
    
    struct Element {
        var timestamp: Date
        var value: Int
    }
    
    func add(_ value: Int, timestamp: Date) {
        addSet = addToSet(set: addSet, value: value, timestamp: timestamp)
    }
    
    func remove(_ value: Int, timestamp: Date) {
        removeSet = addToSet(set: removeSet, value: value, timestamp: timestamp)
    }
    
    func converged() -> [Element] {
        var elements = [Element]()
        for element in addSet {
            if let index = ElementSet.findElementIndexIn(set: removeSet, value: element.value) {
                if element.timestamp > removeSet[index].timestamp {
                    elements.append(element)
                }
            } else {
                elements.append(element)
            }
        }
            
        return elements
    }
    
    private func addToSet(set: [Element], value: Int, timestamp: Date) -> [Element] {
        var newSet = set
        let index = newSet.index { element in
            element.value == value
        }

        //If item is found, just update the timestamp
        if let i = index {
            newSet[i].timestamp = timestamp
        }
        //Else, create element in set
        else {
            let element = Element(timestamp: timestamp, value: value)
            newSet.append(element)
        }
        return newSet
    }
}

// MARK: Class Methods
extension ElementSet {
    static func merged(_ elementSets: [ElementSet]) -> ElementSet {
        var unifiedAddSet = [Element]()
        var unifiedRemoveSet = [Element]()
        
        for elementSet in elementSets {
            //Check if unified contains current element, if positive, check the timestamp
            for element in elementSet.addSet {
                if let index = findElementIndexIn(set: unifiedAddSet, value: element.value) {
                    if element.timestamp > unifiedAddSet[index].timestamp {
                        unifiedAddSet[index] = element
                    }
                } else {
                    unifiedAddSet.append(element)
                }
            }
            
            //Same for remove
            for element in elementSet.removeSet {
                if let index = findElementIndexIn(set: unifiedRemoveSet, value: element.value) {
                    if element.timestamp > unifiedRemoveSet[index].timestamp {
                        unifiedRemoveSet[index] = element
                    }
                } else {
                    unifiedRemoveSet.append(element)
                }
            }
        }
        
        let elementSet = ElementSet()
        elementSet.addSet = unifiedAddSet
        elementSet.removeSet = unifiedRemoveSet
        
        return elementSet
    }
    
    static func findElementIndexIn(set: [Element], value: Int) -> Int? {
        let index = set.index { element in
            element.value == value
        }
        
        return index
    }
}
