//
//  ViewController.swift
//  guestNumber
//
//  Created by 簡立維 on 2019/7/19.
//  Copyright © 2019 Kyowa Kirin. All rights reserved.
//

import UIKit
import AVKit


class ViewController: UIViewController {

    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!

    @IBOutlet weak var rightHand: UIImageView!
    @IBOutlet weak var leftHand: UIImageView!
    
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var showImage: UIImageView!
    
    @IBOutlet weak var recordTimes: UILabel!
    @IBOutlet weak var showAnswer: UILabel!
    @IBOutlet weak var answerSlider: UISlider!
    @IBOutlet weak var speakLabel: UILabel!
    
    
    @IBOutlet weak var submitButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        answerLabel.text = String(Int.random(in: 0...30))
        answerLabel.isHidden = true
        answerSlider.value = Float(maxLabel.text!)! - 1
        showAnswer.text = String(Int(maxLabel.text!)! - 1)
        
    }

    @IBAction func showAnswerSlider(_ sender: Any) {
        showAnswer.text = String(Int(answerSlider.value))
    }

    @IBAction func checkAnswerButton(_ sender: Any) {
        
        recordTimes.text = String(Int(recordTimes.text!)! + 1);
        
        if(Int(answerSlider.value) > Int(answerLabel.text!)!)
        {
            maxLabel.text = String(Int(answerSlider.value))
            answerSlider.value -= 1
            answerSlider.maximumValue = Float(answerSlider.value)
            errorSpeak()
        }
        else
        {
            if(Int(answerSlider.value) < Int(answerLabel.text!)!)
            {
                minLabel.text = String(Int(answerSlider.value))
                answerSlider.value += 1
                answerSlider.minimumValue = Float(answerSlider.value)
                errorSpeak()
            }
            else
            {
                submitButton.isEnabled = false
                answerLabel.text = String(Int(answerSlider.value))
                answerLabel.isHidden = false
                stateLabel.text! = "答對啦，答案就是\(answerLabel.text!)"
                let showImageRnd = String(Int.random(in: 1...4))
                showImage.image = UIImage(named: "0\(showImageRnd).jpg")
                showImage.isHidden = false
                speak()
            }
        }
    }
    
    func getNumber(bigNumber : String , smallNumber : String) -> Int{
        
        var returnInt : Int = 0
        returnInt = Int(bigNumber)! - Int(smallNumber)!
        return returnInt
    }
    
    func errorSpeak()
    {
        stateLabel.text = ""
        if(Int(recordTimes.text!)! > 5)
        {
            stateLabel.text! = "錯超過\(Int(recordTimes.text!)!)次了啦，"
        }
        stateLabel.text! += "答錯啦，範圍是\(Int(answerSlider.minimumValue))到\(Int(answerSlider.maximumValue))"
        speak()
    }
    
    func speak()
    {
        //1.設定要說的話
        let speechLitcher = AVSpeechUtterance(string: stateLabel.text! )
        //2.設定中文語言
        speechLitcher.voice = AVSpeechSynthesisVoice(language: "zh-TW")
        let Speak = AVSpeechSynthesizer()
        //3.開始說話
        Speak.speak(speechLitcher)
        
    }
    
//    func mediaPlay()
//    {
//        let url = URL(string : "https://www.youtube.com/watch?v=iWHxZlTh89k")
//        {
//        let item = AVPlayerItem(url : url)
//        let player = AVQueuePlayer()
//
//        let playerViewController = AVPlayerViewController()
//        playerViewController.player = player
//        present(playerViewController, animated: true, completion: {
//            playerViewController.player?.play()})
//
//        }
//    }
    
}

