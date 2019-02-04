//
//  QuestionModel.swift
//  QuizzAppV2
//
//  Created by Jersan Balago on 12/09/2018.
//  Copyright © 2018 Jersan Balago. All rights reserved.
//

import UIKit

class Question {
    
    let questionText: String
    let questionAnswer: Bool
    
    init(text: String, answer: Bool) {
        questionText = text
        questionAnswer = answer
    }
    
}
