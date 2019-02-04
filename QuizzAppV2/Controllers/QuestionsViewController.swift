//
//  ViewController.swift
//  QuizzAppV2
//
//  Created by Jersan Balago on 07/09/2018.
//  Copyright © 2018 Jersan Balago. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var pickedAnswer: Bool = false
    var questionNumber: Int = 0
    var score: Int = 0
    
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Question"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = .center
        label.backgroundColor = UIColor.rgb(red: 32, green: 132, blue: 210)
        label.numberOfLines = 0
        return label
    }()
    
    let falseButton: UIButton = {
        let button = UIButton()
        button.setTitle("False", for: .normal)
        button.backgroundColor = UIColor.green
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.layer.backgroundColor = UIColor.rgb(red: 49, green: 163, blue: 67).cgColor
        button.addTarget(self, action: #selector(falsePressed), for: .touchUpInside)
        return button
    }()
    
    @objc func falsePressed() {
        pickedAnswer = false
        answerPressed()
    }
    
    let trueButton: UIButton = {
        let button = UIButton()
        button.setTitle("True", for: .normal)
        button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.layer.backgroundColor = UIColor.rgb(red: 201, green: 63, blue: 69).cgColor
        button.addTarget(self, action: #selector(truePressed), for: .touchUpInside)
        return button
    }()
    
    @objc func truePressed() {
        pickedAnswer = true
        answerPressed()
    }
    
    func answerPressed() {
        checkAnswer()
        nextQuestion()
    }
    
    func checkAnswer() {
        let questionAnswer = allQuestions.list[questionNumber - 1].questionAnswer
        if questionAnswer == pickedAnswer {
            ProgressHUD.showSuccess("Correct")
            score += 1
        }
        else {
            ProgressHUD.showError("Wrong!")
        }
    }
    
    func nextQuestion() {
        
        if questionNumber < allQuestions.list.count {
            questionNumber += 1
            questionLabel.text = allQuestions.list[questionNumber - 1].questionText
        }
        else {
            let alert = UIAlertController(title: "Finished", message: "Do you want to start over?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
            }
            alert.addAction(restartAction)
            present(alert, animated: false, completion: nil)
        }
        
        updateUI()
    }
    
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber)/\(allQuestions.list.count)"
        let initialSize = CGFloat(view.frame.size.width) / CGFloat(allQuestions.list.count)
        progressBar.frame.size.width = initialSize * CGFloat(questionNumber)
    }
    
    func startOver() {
        questionNumber = 0
        score = 0
        nextQuestion()
    }
    
    let progressLabel: UILabel = {
        let label = UILabel()
        label.text = "x/13"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 22)
        label.textAlignment = .right
        return label
    }()
    
    let progressBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.rgb(red: 32, green: 132, blue: 210)
        
        setupViews()
        nextQuestion()
    }
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setupViews() {
        
        view.addSubview(questionLabel)
        questionLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height:290)
        
        setupButtons()
        setupProgressScoreLabels()
    }
    
    fileprivate func setupButtons() {
        let buttonsStackView = UIStackView(arrangedSubviews: [falseButton, trueButton])
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 20
        
        view.addSubview(buttonsStackView)
        buttonsStackView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 25, paddingBottom: 200, paddingRight: 25, width: 0, height: 56)
    }
    
    fileprivate func setupProgressScoreLabels() {
        let stackView = UIStackView(arrangedSubviews: [progressLabel, scoreLabel])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        view.addSubview(progressBar)
        progressBar.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 14)
        
        view.addSubview(stackView)
        stackView.anchor(top: nil, left: view.leftAnchor, bottom: progressBar.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 50)
    
    }
}
