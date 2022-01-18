//
//  StartController.swift
//  mama
//
//  Created by Tanishk Deo on 1/5/22.
//

import UIKit

let mama = UIColor(red: 0.06, green: 0.24, blue: 0.28, alpha: 1.00)

class StartController: UIViewController {

    @IBOutlet weak var story4: UIImageView!
    @IBOutlet weak var story3: UIImageView!
    @IBOutlet weak var story2: UIImageView!
    @IBOutlet weak var splash: UIImageView!
    @IBOutlet weak var story1: UIImageView!
    @IBOutlet weak var bonus: UIImageView!
    
    var current = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = mama
        splash.image = UIImage(named: "background")
        story1.image = UIImage(named: "story1")
        story2.image = UIImage(named: "story2")
        story3.image = UIImage(named: "story3")
        story4.image = UIImage(named: "story4")
        bonus.image = UIImage(named: "day")
        updatePage()
        
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap)))
    }
    
    @objc func onTap() {
        current += 1
        updatePage()
    }
    
    func updatePage() {
        splash.isHidden = (current != 0)
        bonus.isHidden = (current != 1)
        story1.isHidden = (current != 2)
        story2.isHidden = (current != 3)
        story3.isHidden = (current != 4)
        story4.isHidden = (current != 5)
        
        if current == 6 {
            showMain()
        }
        
        if current == 1 {
            view.backgroundColor = UIColor(red: 0.94, green: 0.39, blue: 0.33, alpha: 1.00)
        } else {
            view.backgroundColor = mama 
        }
    }

    
    func showMain() {
        performSegue(withIdentifier: "Main", sender: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

