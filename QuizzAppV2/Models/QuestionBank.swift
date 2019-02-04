//
//  QuestionBank.swift
//  QuizzAppV2
//
//  Created by Jersan Balago on 12/09/2018.
//  Copyright © 2018 Jersan Balago. All rights reserved.
//

import UIKit

class QuestionBank {
    
    var list = [Question]()
    
    init() {
        
        list.append(Question(text: "Dog != dog", answer: true))
        list.append(Question(text: "Java the first programming language", answer: false))
        
    }
}
