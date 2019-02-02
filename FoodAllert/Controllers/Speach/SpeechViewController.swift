//
//  SpeechViewController.swift
//  FoodAllert
//
//  Created by Angel Ricardo Solsona Nevero on 16/01/19.
//  Copyright © 2019 José Gil Ramírez S. All rights reserved.
//

import UIKit
import Speech

protocol SpeechViewControllerDelegate: class {
    func textDetected(string: String)
}

class SpeechViewController: UIViewController {

    @IBOutlet weak var detectedTextLabel: UITextView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var containerButton: UIView!
    
    weak var delegate: SpeechViewControllerDelegate?
    
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer(locale: Locale(identifier: "es-MX"))
    var request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    var isRecording = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        containerButton.layer.cornerRadius = startButton.frame.size.width / 2
        startButton.backgroundColor = UIColor.gray
        startButton.layer.cornerRadius = startButton.frame.size.width / 2
        self.requestSpeechAuthorization()
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if isRecording {
            request.endAudio()
            audioEngine.stop()
            //recognitionTask?.cancel()
            self.cancelRecording()
            isRecording = false
            
            UIView.animate(withDuration: 1) {
                self.startButton.frame = CGRect(x: (self.startButton.frame.origin.x - 3.5), y: (self.startButton.frame.origin.y - 3.5), width: 57, height: 57)
                self.startButton.backgroundColor = UIColor.gray
                self.startButton.layer.cornerRadius = self.startButton.frame.size.width / 2
            }
            
//            startButton.backgroundColor = UIColor.gray
//            startButton.layer.cornerRadius = startButton.frame.size.width / 2
        } else {
            self.request = SFSpeechAudioBufferRecognitionRequest()
            self.recordAndRecognizeSpeech()
            isRecording = true
            UIView.animate(withDuration: 1) {
                self.startButton.frame = CGRect(x: (self.startButton.frame.origin.x + 3.5), y: (self.startButton.frame.origin.y + 3.5), width: 50, height: 50)
                self.startButton.backgroundColor = UIColor.red
                self.startButton.layer.cornerRadius = 10
            }
//
        }
    }
    
    @IBAction func continueSpeeach(){
        self.delegate?.textDetected(string: detectedTextLabel.text)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelScan(){
        self.dismiss(animated: true, completion: nil)
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
            self.sendAlert(message: "Ha habido un error en el motor de audio.")
            return print(error)
        }
        guard let myRecognizer = SFSpeechRecognizer() else {
            self.sendAlert(message: "El reconocimiento de voz no es compatible con su ubicación actual.")
            return
        }
        if !myRecognizer.isAvailable {
            self.sendAlert(message: "El reconocimiento de voz no está disponible actualmente. Vuelve a consultar más tarde.")
            // Recognizer is not available right now
            return
        }
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
            if result != nil {
                if let result = result {
                    
                    let bestString = result.bestTranscription.formattedString
                    self.detectedTextLabel.text = bestString
                    
                    
                    for segment in result.bestTranscription.segments {
                        let indexTo = bestString.index(bestString.startIndex, offsetBy: segment.substringRange.location)
                    }
                    
                } else if let error = error {
                    self.sendAlert(message: "Ha habido un error de reconocimiento de voz.")
                    print(error)
                }
            
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
        let alert = UIAlertController(title: "Error del reconocedor de voz", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
