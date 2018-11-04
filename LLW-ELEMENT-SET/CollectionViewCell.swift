//
//  CollectionViewCell.swift
//  LLW-ELEMENT-SET
//
//  Created by Eduardo Domene Junior on 04/11/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import UIKit

protocol CollectionViewCellDelegate: class {
    func didChange(elementSet: ElementSet?)
}

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var elements: UILabel!
    @IBOutlet weak var input: UITextField!
    var elementSet: ElementSet?
    weak var delegate: CollectionViewCellDelegate?
    
    @IBAction func add(_ sender: Any) {
        if let value = Int(input.text ?? "") {
            elementSet?.add(value, timestamp: Date())
            delegate?.didChange(elementSet: self.elementSet)
            input.text = ""
        }
    }
    
    @IBAction func subtract(_ sender: Any) {
        if let value = Int(input.text ?? "") {
            elementSet?.remove(value, timestamp: Date())
            delegate?.didChange(elementSet: self.elementSet)
            input.text = ""
        }
    }
}
