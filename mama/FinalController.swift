//
//  FinalController.swift
//  mama
//
//  Created by Tanishk Deo on 1/5/22.
//

import UIKit

class FinalController: UIViewController {
    
    var time = 0
    var count = 0

    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var score: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = mama
        score.text = "Score: \(count)"
        duration.text = "Time: \(time)s"

        // Do any additional setup after loading the view.
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
