//
//  CardsViewController.swift
//  ProtoTinder
//
//  Created by Jonathan Chen on 6/16/16.
//  Copyright © 2016 Chenlo Park. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    var cardInitialCenter: CGPoint!
    var cardDefaultCenter: CGPoint!
    
    @IBOutlet weak var cardImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cardDefaultCenter = cardImageView.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCardPan(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            
            cardInitialCenter = cardImageView.center
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            cardImageView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
            
            // swiping right
            if (cardImageView.center.x > 160 && translation.x > 0) {
                
                let angle = convertValue(abs(cardImageView.center.x - 160), r1Min: 0, r1Max: 160, r2Min: 0, r2Max: CGFloat(30 * M_PI / 180))
                cardImageView.transform = CGAffineTransformIdentity
                cardImageView.transform = CGAffineTransformRotate(cardImageView.transform, angle)
                
            }
            // swiping left
            else if (cardImageView.center.x < 160 && translation.x < 0) {
                
                let angle = convertValue(abs(cardImageView.center.x - 160), r1Min: 0, r1Max: 160, r2Min: 0, r2Max: CGFloat(-30 * M_PI / 180))
                cardImageView.transform = CGAffineTransformIdentity
                cardImageView.transform = CGAffineTransformRotate(cardImageView.transform, angle)
                
            }
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options:[] , animations: { () -> Void in
                
                if (abs(self.cardImageView.center.x - 160) <= 50) {
                    self.cardImageView.center = self.cardDefaultCenter
                    self.cardImageView.transform = CGAffineTransformIdentity
                } else if (self.cardImageView.center.x - 160 > 50) {
                    self.cardImageView.center = CGPoint(x: self.cardDefaultCenter.x + 320, y: self.cardDefaultCenter.y)
                    
                    self.cardImageView.transform = CGAffineTransformIdentity
                } else if (self.cardImageView.center.x - 160 < -50) {
                    self.cardImageView.center = CGPoint(x: self.cardDefaultCenter.x - 320, y: self.cardDefaultCenter.y)
                    
                    self.cardImageView.transform = CGAffineTransformIdentity
                }
            
                }, completion: { (Bool) -> Void in
                    
                    UIView.animateWithDuration(0.4, delay: 1.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options:[] , animations: { () -> Void in

                    
                    self.cardImageView.center = self.cardDefaultCenter
                    }, completion: nil)
            })


        }
        
    }
    
    @IBAction func onCardTap(sender: UITapGestureRecognizer) {
        
    performSegueWithIdentifier("profileSegue", sender: self)

        
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        var destinationViewController = segue.destinationViewController as! ProfileViewController
        
        destinationViewController.image = self.cardImageView.image
        
    }

}
