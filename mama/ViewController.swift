//
//  ViewController.swift
//  mama
//
//  Created by Tanishk Deo on 10/19/21.
//

import UIKit
import Speech

class ViewController: UIViewController {
    
    
    
    // TODO:
    // add buttons, change locale to chinese, count ma's 
    
    let input = AVAudioEngine()
    let recognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    var request: SFSpeechAudioBufferRecognitionRequest?
    var task: SFSpeechRecognitionTask?
    
    var startTime: Date?
    var endTime: Date?
    
    var text = ""

    
    @IBOutlet weak var progress: ProgressBar!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progress.initBar()
        progress.setProgressColor(color: UIColor.green)
        
        view.backgroundColor = mama

        // Do any additional setup after loading the view.
    }

    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    @IBAction func startPressed(_ sender: UIButton) {
        transcribe()
    }
    
    func transcribe() {
        input.reset()
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("ERROR: \(error)")
        }
        
 
        
        
        
        request = SFSpeechAudioBufferRecognitionRequest()
        
        guard let request = request else {
            return
        }

        
        let node = input.inputNode
        let format = AVAudioFormat(standardFormatWithSampleRate: 44100, channels: 1)
        node.removeTap(onBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: format) { buffer, _ in
            request.append(buffer)
            
            
        }
        
        if startTime == nil {
            startTime = Date()
        }
        

        
        startButton.setTitle("STOP", for: [])
        
        input.prepare()
        do {
            try input.start()

        } catch {
            print(error)
        }
        
        
        
        
        request.shouldReportPartialResults = true
        
        
        if let recognizer = recognizer, recognizer.isAvailable {
            task = recognizer.recognitionTask(with: request) { result, error in    var isFinal = false
                
                if let result = result {
                    // Update the text view with the results.
                    isFinal = result.isFinal
                    
                    self.text = result.bestTranscription.formattedString
                    
                    let c = CGFloat(self.text.countInstances(of: "Ma"))
                    DispatchQueue.main.async {
                        self.progress.setProgressValue(currentValue: c)
                    }
                    
                }
                
                if error != nil || isFinal {
                    // Stop recognizing speech if there is a problem.
                    self.input.stop()
                    node.removeTap(onBus: 0)

                    self.request = nil
                    self.task = nil

                    self.startButton.isEnabled = true
                    self.startButton.setTitle("Air Power Charged", for: [])
                    self.startButton.isEnabled = false
                    self.displayMa()
                }
            }
            
            
        }
    }
    
    var finalCount = 0
    var finalTime = 0
    
    func displayMa() {
        
        // MOVE
        if let startTime = startTime {
            let time = -Int(startTime.timeIntervalSinceNow)
            let count = text.countInstances(of: "Ma")
            finalCount = count
            finalTime = time
            performSegue(withIdentifier: "Final", sender: nil)
        }

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Final", let vc = segue.destination as? FinalController{
            vc.time = finalTime
            vc.count = finalCount
        }
    }
}


extension String {
    /// stringToFind must be at least 1 character.
    func countInstances(of stringToFind: String) -> Int {
        assert(!stringToFind.isEmpty)
        var count = 0
        var searchRange: Range<String.Index>?
        while let foundRange = range(of: stringToFind, options: [.caseInsensitive], range: searchRange) {
            count += 1
            searchRange = Range(uncheckedBounds: (lower: foundRange.upperBound, upper: endIndex))
        }
        return count
    }
}
