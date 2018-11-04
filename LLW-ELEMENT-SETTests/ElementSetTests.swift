//
//  ElementSetTests.swift
//  LLW-ELEMENT-SETTests
//
//  Created by Eduardo Domene Junior on 03/11/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import XCTest
@testable import LLW_ELEMENT_SET

class ElementSetTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testReplicaAddOneElement() {
        let replica = ElementSet()
        replica.add(1, timestamp: Date())
        
        XCTAssertEqual(replica.addSet.count, 1)
        XCTAssertEqual(replica.removeSet.count, 0)
        
        XCTAssertEqual(replica.addSet.first?.value, 1)
    }
    
    func testReplicaAddTwoElements() {
        let replica = ElementSet()
        replica.add(1, timestamp: Date())
        replica.add(2, timestamp: Date())
        
        XCTAssertEqual(replica.addSet.count, 2)
        XCTAssertEqual(replica.removeSet.count, 0)
        
        XCTAssertEqual(replica.addSet[0].value, 1)
        XCTAssertEqual(replica.addSet[1].value, 2)
    }
    
    func testReplicaAddTwoOfTheSameElements() {
        let replica = ElementSet()
        replica.add(1, timestamp: Date())
        replica.add(1, timestamp: Date())
        
        XCTAssertEqual(replica.addSet.count, 1)
        XCTAssertEqual(replica.removeSet.count, 0)
        
        XCTAssertEqual(replica.addSet[0].value, 1)
    }
    
    func testReplicaRemoveElement() {
        let replica = ElementSet()
        replica.remove(1, timestamp: Date())
        
        XCTAssertEqual(replica.addSet.count, 0)
        XCTAssertEqual(replica.removeSet.count, 1)
    }
    
    func testReplicaRemoveTwoElements() {
        let replica = ElementSet()
        replica.remove(1, timestamp: Date())
        replica.remove(2, timestamp: Date())
        
        XCTAssertEqual(replica.addSet.count, 0)
        XCTAssertEqual(replica.removeSet.count, 2)
    }
    
    func testReplicaRemoveTwoOfTheSameElements() {
        let replica = ElementSet()
        replica.remove(1, timestamp: Date())
        replica.remove(1, timestamp: Date())
        
        XCTAssertEqual(replica.addSet.count, 0)
        XCTAssertEqual(replica.removeSet.count, 1)
    }
    
    func testReplicaAddAndRemoveElement() {
        let replica = ElementSet()
        replica.add(1, timestamp: Date())
        replica.remove(1, timestamp: Date())
        
        XCTAssertEqual(replica.addSet.count, 1)
        XCTAssertEqual(replica.removeSet.count, 1)
    }
    
    func testReplicaRemoveAndAddElement() {
        let replica = ElementSet()
        replica.add(1, timestamp: Date())
        replica.remove(1, timestamp: Date())
        
        XCTAssertEqual(replica.addSet.count, 1)
        XCTAssertEqual(replica.removeSet.count, 1)
    }
    
    func testReplicaFindElementIndex() {
        let replica = ElementSet()
        replica.add(1, timestamp: Date())
        replica.add(2, timestamp: Date())
        replica.add(3, timestamp: Date())
        
        let index1 = ElementSet.findElementIndexIn(set: replica.addSet, value: 1)
        let index2 = ElementSet.findElementIndexIn(set: replica.addSet, value: 2)
        let index3 = ElementSet.findElementIndexIn(set: replica.addSet, value: 3)
        
        XCTAssertEqual(index1, 0)
        XCTAssertEqual(index2, 1)
        XCTAssertEqual(index3, 2)
    }
    
    func testReplicaFindElementIndexNotFound() {
        let replica = ElementSet()
        replica.add(1, timestamp: Date())
        
        let index1 = ElementSet.findElementIndexIn(set: replica.addSet, value: 2)
        
        XCTAssertEqual(index1, nil)
    }
    
    func testReplicaConvergeElementsAddingTwo() {
        let replica = ElementSet()
        replica.add(1, timestamp: Date())
        replica.add(2, timestamp: Date())
        
        let converged = replica.converge()
        
        XCTAssertEqual(converged.count, 2)
        XCTAssertEqual(converged[0].value, 1)
        XCTAssertEqual(converged[1].value, 2)
    }
    
    func testReplicaConvergeElementsRemovingTwoAndAddingAgain() {
        let replica = ElementSet()
        replica.remove(1, timestamp: Date())
        replica.remove(2, timestamp: Date())
        replica.add(1, timestamp: Date())
        replica.add(2, timestamp: Date())
        
        let converged = replica.converge()
        
        XCTAssertEqual(converged.count, 2)
        XCTAssertEqual(converged[0].value, 1)
        XCTAssertEqual(converged[1].value, 2)
    }
    
    func testReplicaConvergeElementsAddingTwoAndRemovingOne() {
        let replica = ElementSet()
        replica.add(1, timestamp: Date())
        replica.add(2, timestamp: Date())
        replica.remove(1, timestamp: Date())
        
        let converged = replica.converge()
        
        XCTAssertEqual(converged.count, 1)
        XCTAssertEqual(converged[0].value, 2)
    }
    
    func testReplicaConvergeElementsAddingTwoAndRemovingTwo() {
        let replica = ElementSet()
        replica.add(1, timestamp: Date())
        replica.add(2, timestamp: Date())
        replica.remove(1, timestamp: Date())
        replica.remove(2, timestamp: Date())
        
        let converged = replica.converge()
        
        XCTAssertEqual(converged.count, 0)
    }
    
    func testReplicaAddElementAndMerge() {
        let replica1 = ElementSet()
        let replica2 = ElementSet()

        replica1.add(1, timestamp: Date())
        replica2.add(2, timestamp: Date())

        let merged = ElementSet.merge([replica1, replica2])
        let converged = merged.converge()

        XCTAssertEqual(merged.addSet.count, 2)
        XCTAssertEqual(merged.removeSet.count, 0)

        XCTAssertEqual(merged.addSet[0].value, 1)
        XCTAssertEqual(merged.addSet[1].value, 2)
        
        XCTAssertEqual(converged.count, 2)
        XCTAssertEqual(converged[0].value, 1)
        XCTAssertEqual(converged[1].value, 2)
    }
    
    func testReplicaAddElementThenRemoveAndMerge() {
        let replica1 = ElementSet()
        let replica2 = ElementSet()
        
        replica1.add(1, timestamp: Date())
        replica2.add(2, timestamp: Date())
        replica2.remove(1, timestamp: Date())
        
        let merged = ElementSet.merge([replica1, replica2])
        let converged = merged.converge()
        
        XCTAssertEqual(merged.addSet.count, 2)
        XCTAssertEqual(merged.removeSet.count, 1)
        
        XCTAssertEqual(merged.addSet[0].value, 1)
        XCTAssertEqual(merged.addSet[1].value, 2)
        XCTAssertEqual(merged.removeSet[0].value, 1)
        
        XCTAssertEqual(converged.count, 1)
        XCTAssertEqual(converged[0].value, 2)
    }
    
    func testReplicaAddTwoOfTheSameElementAndMerge() {
        let replica1 = ElementSet()
        let replica2 = ElementSet()
        
        replica1.add(1, timestamp: Date())
        replica2.add(1, timestamp: Date())
        
        let merged = ElementSet.merge([replica1, replica2])
        let converged = merged.converge()
        
        XCTAssertEqual(merged.addSet.count, 1)
        XCTAssertEqual(merged.removeSet.count, 0)
        
        XCTAssertEqual(merged.addSet[0].value, 1)
        
        XCTAssertEqual(converged.count, 1)
        XCTAssertEqual(converged[0].value, 1)
    }
    
    func testReplicaRemoveTwoOfTheSameElementAndMerge() {
        let replica1 = ElementSet()
        let replica2 = ElementSet()
        
        replica1.remove(1, timestamp: Date())
        replica2.remove(1, timestamp: Date())
        
        let merged = ElementSet.merge([replica1, replica2])
        let converged = merged.converge()
        
        XCTAssertEqual(merged.addSet.count, 0)
        XCTAssertEqual(merged.removeSet.count, 1)
        
        XCTAssertEqual(converged.count, 0)
    }
    
    func testReplicaRemoveTwoElementsAddAgainAndMerge() {
        let replica1 = ElementSet()
        let replica2 = ElementSet()
        
        replica1.remove(1, timestamp: Date())
        replica2.remove(2, timestamp: Date())
        
        replica1.add(1, timestamp: Date())
        replica2.add(2, timestamp: Date())
        
        let merged = ElementSet.merge([replica1, replica2])
        let converged = merged.converge()
        
        XCTAssertEqual(merged.addSet.count, 2)
        XCTAssertEqual(merged.removeSet.count, 2)
        
        XCTAssertEqual(converged.count, 2)
        XCTAssertEqual(converged[0].value, 1)
        XCTAssertEqual(converged[1].value, 2)
    }
}

