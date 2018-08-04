//
//  ViewController.swift
//  Tuturu
//
//  Created by md760 on 30.07.2018.
//  Copyright © 2018 md760. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var tuturuButton: UIButton!
    @IBOutlet weak var underView: UIView!
    
    private var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    var audioPlayer: AVAudioPlayer!
    
    func playSoundWith(fileName: String, audioExtension: String) -> Void {
        
        let audioUrl: URL!
        audioUrl = Bundle.main.url(forResource: fileName, withExtension: audioExtension)
        
        if audioUrl == nil {
            print("audioUrl == nil")
        } else {
            
            do {
                audioPlayer = try AVAudioPlayer.init(contentsOf: audioUrl)
                audioPlayer.prepareToPlay()
                audioPlayer.play()
                
            } catch let error {
                print(error)
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    @IBAction func tuturu(_ sender: Any) {
        score += 1
        countLabel.text = " \(score)"
        if score % 5 == 0 {
            superAnimation()
        } else if score % 11 == 0 {
            johnCenaAnimation()
        } else {
            standartAnimation()
        }
    }
    
    private func standartAnimation() {
        //diorganie + zvuk
        
        UIView.animate(withDuration: 0.1, delay: 0, options: [.repeat, .autoreverse, .curveLinear], animations: {
            UIView.setAnimationRepeatCount(3)
            self.tuturuButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi / -28 )
            self.tuturuButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 28 )
            
        },
                       completion: { finished in
                        self.tuturuButton.transform = CGAffineTransform.identity
                        print("Save done")
        })
        
        playSoundWith(fileName: "tuturu", audioExtension: "mp3")
        // tuturuButton.shake(count: 3, for: 0.3, withTranslation: 6)
        
    }
    private func superAnimation() {
        //tupaet nogoi + grugoi zvuk
        print("superAnimation")
        playSoundWith(fileName: "bisTuturu", audioExtension: "mp3")
        
        
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.underView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 8 )
        }) { [weak self] _ in
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                self?.underView.transform = CGAffineTransform.identity
            })
            
        }
        
    }
    
    private let duration: TimeInterval = 5
    func multiPosition(_ firstPos: CGPoint, _ secondPos: CGPoint) {
        func simplePosition(_ pos: CGPoint) {
            UIView.animate(withDuration: self.duration, animations: {
                self.tuturuButton.frame.origin = pos
            }, completion: nil)
        }
        
        UIView.animate(withDuration: self.duration, animations: {
            self.tuturuButton.frame.origin = firstPos
        }, completion: { finished in
            simplePosition(secondPos)
            self.tuturuButton.transform = CGAffineTransform.identity
        })
    }
    
    private func johnCenaAnimation() {
        //vse krujlyaet i animashka uvelichevaetsya + starwars sound
        print("starWarsAnimation")
        playSoundWith(fileName: "superTuturu", audioExtension: "mp3")
        UIView.animate(withDuration: 0.2, animations: {
            self.multiPosition(CGPoint(x: self.tuturuButton.frame.origin.x - 100, y: self.tuturuButton.frame.origin.y), self.tuturuButton.frame.origin)
        }) { [weak self] _ in
        
        UIView.animate(withDuration: 1.5, animations: { [weak self] in
            self?.tuturuButton.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            
            UIView.animate(withDuration: 1.5, delay: 1.5, options: [] , animations: { [weak self] in
                self?.tuturuButton.transform = CGAffineTransform.identity
            })
            
            UIView.animate(withDuration: 1.5, animations: { [weak self] in
                self?.countLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi )
                self?.nameLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi )
            }) { [weak self] _ in
                
                UIView.animate(withDuration: 1.5, animations: { [weak self] in
                    self?.countLabel.transform = CGAffineTransform.identity
                    self?.nameLabel.transform = CGAffineTransform.identity
                })
              }
          })
        }
    }
}
