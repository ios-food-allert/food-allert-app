//
//  SpeechViewController.swift
//  FoodAllert
//
//  Created by Angel Ricardo Solsona Nevero on 16/01/19.
//  Copyright © 2019 José Gil Ramírez S. All rights reserved.
//

import UIKit
import Speech

class SpeechViewController: UIViewController {

    @IBOutlet weak var detectedTextLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer(locale: Locale(identifier: "es-MX"))
    var request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    var isRecording = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.requestSpeechAuthorization()
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if isRecording == true {
            //audioEngine.stop()
            //recognitionTask?.cancel()
            self.cancelRecording()
            isRecording = false
            startButton.backgroundColor = UIColor.gray
        } else {
            self.request = SFSpeechAudioBufferRecognitionRequest()
            self.recordAndRecognizeSpeech()
            isRecording = true
            startButton.backgroundColor = UIColor.red
        }
    }
    
    func cancelRecording() {
        request.endAudio()
        audioEngine.stop()
        let node = audioEngine.inputNode
        node.removeTap(onBus: 0)
        recognitionTask?.cancel()
    }
    
    func recordAndRecognizeSpeech() {
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.request.append(buffer)
        }
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            self.sendAlert(message: "There has been an audio engine error.")
            return print(error)
        }
        guard let myRecognizer = SFSpeechRecognizer() else {
            self.sendAlert(message: "Speech recognition is not supported for your current locale.")
            return
        }
        if !myRecognizer.isAvailable {
            self.sendAlert(message: "Speech recognition is not currently available. Check back at a later time.")
            // Recognizer is not available right now
            return
        }
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
            if let result = result {
                
                let bestString = result.bestTranscription.formattedString
                self.detectedTextLabel.text = bestString
                
                
                for segment in result.bestTranscription.segments {
                    let indexTo = bestString.index(bestString.startIndex, offsetBy: segment.substringRange.location)
                }
            } else if let error = error {
                self.sendAlert(message: "There has been a speech recognition error.")
                print(error)
            }
        })
    }

    
    func requestSpeechAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.startButton.isEnabled = true
                case .denied:
                    self.startButton.isEnabled = false
                    self.detectedTextLabel.text = "Acceso no permitido al reconocimiento de voz"
                case .restricted:
                    self.startButton.isEnabled = false
                    self.detectedTextLabel.text = "Reconocimiento de voz restringido en este dispositivoSpeech recognition restricted on this device"
                case .notDetermined:
                    self.startButton.isEnabled = false
                    self.detectedTextLabel.text = "Reconocimiento de voz aún no autorizado"
                }
            }
        }
    }
    
    func sendAlert(message: String) {
        let alert = UIAlertController(title: "Speech Recognizer Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
