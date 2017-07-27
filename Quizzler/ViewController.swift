//
//  ViewController.swift
//  Quizzler
//
//  Created by Vibhanshu Vaibhav on 22/07/2017.
//  Copyright (c) 2017 Vibhanshu Vaibhav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    
    let questionBank = QuestionBank().list
    var questionIndex : Int = 0
    var score : Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        nextQuestion()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            checkAnswer(answer: true)
        }
        else if sender.tag == 2{
            checkAnswer(answer: false)
        }
        
        questionIndex += 1
        nextQuestion()
    }
    
    
    func updateUI() {
        progressLabel.text = "\(questionIndex + 1)/13"
        scoreLabel.text = "Score:\(score)"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionIndex + 1)
    }
    

    func nextQuestion() {
        if questionIndex == questionBank.endIndex{
            let alert = UIAlertController(title: "Awesome!", message: "You've finished the quiz, do you want to start over?", preferredStyle: .alert)
            
            let restart = UIAlertAction(title: "Restart", style: .default, handler:
            { (UIAlertAction) in
                self.startOver()
            })
            
            alert.addAction(restart)
            
            present(alert, animated: true, completion: nil)
        }
        else {
            let nextQuestion = questionBank[questionIndex].question
            questionLabel.text = nextQuestion
            updateUI()
        }
    }
    
    
    func checkAnswer(answer: Bool) {
        let correctAnswer = questionBank[questionIndex].answer
        if answer == correctAnswer {
            ProgressHUD.showSuccess("Correct!")
            score += 1
        }
        else {
            ProgressHUD.showError("Incorrect!")
        }
        updateUI()
    }
    
    
    func startOver() {
        questionIndex = 0
        score = 0
        viewDidLoad()
    }
    
}
