//
//  ContentView.swift
//  SoundTest
//
//  Created by Permyakov Vladislav on 07.02.2022.
//

import SwiftUI
import AVFoundation





struct ContentView: View {
//    private let audioEngine = AVAudioEngine()
//    private let delegate = Delegate()
    @State private var engine = AVAudioEngine()
    @State private var distortion = AVAudioUnitDistortion()
    @State private var reverb = AVAudioUnitReverb()
    @State private var audioBuffer = AVAudioPCMBuffer()
    @State private var outputFile = AVAudioFile()
    @State private var delay = AVAudioUnitDelay()
    @State private var isRealTime = true
    @State var showingOptions = false
    init(){
        initializeAudioEngine()
        startRecording()
    }
    
    var body: some View {
        Button("CUm"){
            showingOptions = true
        }
        .confirmationDialog("cum", isPresented: $showingOptions){
            Button("Blut"){
                for input in AVAudioSession.sharedInstance().availableInputs!{
                    if input.portType == AVAudioSession.Port.bluetoothA2DP || input.portType == AVAudioSession.Port.bluetoothHFP || input.portType == AVAudioSession.Port.bluetoothLE{
                        
                        do {
                            try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSession.PortOverride.none)
                        } catch let error as NSError {
                            print("audioSession error turning off speaker: \(error.localizedDescription)")
                        }
                        
                        do {
                            try AVAudioSession.sharedInstance().setPreferredInput(input)
                        }catch _ {
                            print("cannot set mic ")
                        }
                        break
                    }
                }
            }
            
            Button("built"){
                for input in AVAudioSession.sharedInstance().availableInputs!{
                    if input.portType == AVAudioSession.Port.builtInMic || input.portType == AVAudioSession.Port.builtInReceiver  {
                        do {
                            try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSession.PortOverride.none)
                        } catch let error as NSError {
                            print("audioSession error turning off speaker: \(error.localizedDescription)")
                        }
                        
                        do {
                            try AVAudioSession.sharedInstance().setPreferredInput(input)
                        }catch _ {
                            print("cannot set mic ")
                        }
                        break
                    }
                }
            }
        }
        //            var deviceAction = UIAlertAction()
                    //                    var headphonesExist = false
                    //
                    //                    let audioSession = AVAudioSession.sharedInstance()
                    //                    let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//                    let currentRoute = audioSession.currentRoute
//                    for input in audioSession.availableInputs!{
//                        if input.portType == AVAudioSession.Port.bluetoothA2DP || input.portType == AVAudioSession.Port.bluetoothHFP || input.portType == AVAudioSession.Port.bluetoothLE{
//                                            let localAction = UIAlertAction(title: input.portName, style: .default, handler: {
//                                                (alert: UIAlertAction!) -> Void in
//
//                                                do {
//                                                    try audioSession.overrideOutputAudioPort(AVAudioSession.PortOverride.none)
//                                                } catch let error as NSError {
//                                                    print("audioSession error turning off speaker: \(error.localizedDescription)")
//                                                }
//
//                                                do {
//                                                    try audioSession.setPreferredInput(input)
//                                                }catch _ {
//                                                    print("cannot set mic ")
//                                                }
//
//
//                                            })
//
//                            for description in currentRoute.outputs {
//                                if description.portType == AVAudioSession.Port.bluetoothA2DP {
//                                    localAction.setValue(true, forKey: "checked")
//                                    break
//                                }else if description.portType == AVAudioSession.Port.bluetoothHFP {
//                                        localAction.setValue(true, forKey: "checked")
//                                        break
//                                }else if description.portType == AVAudioSession.Port.bluetoothLE{
//                                    localAction.setValue(true, forKey: "checked")
//                                    break
//                                }
//                            }
//                            localAction.setValue(UIImage(named:"bluetooth.png"), forKey: "image")
//                                optionMenu.addAction(localAction)
//
//                        } else if input.portType == AVAudioSession.Port.builtInMic || input.portType == AVAudioSession.Port.builtInReceiver  {
//
//                            deviceAction = UIAlertAction(title: "iPhone", style: .default, handler: {
//                                (alert: UIAlertAction!) -> Void in
//
//                                do {
//                                    try audioSession.overrideOutputAudioPort(AVAudioSession.PortOverride.none)
//                                } catch let error as NSError {
//                                    print("audioSession error turning off speaker: \(error.localizedDescription)")
//                                }
//
//                                do {
//                                    try audioSession.setPreferredInput(input)
//                                }catch _ {
//                                    print("cannot set mic ")
//                                }
//
//                            })
//
//                            for description in currentRoute.outputs {
//                                if description.portType == AVAudioSession.Port.builtInMic || description.portType  == AVAudioSession.Port.builtInReceiver {
//                                    deviceAction.setValue(true, forKey: "checked")
//                                    break
//                                }
//                            }
//
//                        } else if input.portType == AVAudioSession.Port.headphones || input.portType == AVAudioSession.Port.headsetMic {
//                            headphonesExist = true
//                            let localAction = UIAlertAction(title: "Headphones", style: .default, handler: {
//                                (alert: UIAlertAction!) -> Void in
//
//                                do {
//                                    try audioSession.overrideOutputAudioPort(AVAudioSession.PortOverride.none)
//                                } catch let error as NSError {
//                                    print("audioSession error turning off speaker: \(error.localizedDescription)")
//                                }
//
//                                do {
//                                    try audioSession.setPreferredInput(input)
//                                }catch _ {
//                                    print("cannot set mic ")
//                                }
//                            })
//                            for description in currentRoute.outputs {
//                                if description.portType == AVAudioSession.Port.headphones {
//                                    localAction.setValue(true, forKey: "checked")
//                                    break
//                                } else if description.portType == AVAudioSession.Port.headsetMic {
//                                    localAction.setValue(true, forKey: "checked")
//                                    break
//                                }
//                            }
//
//                            optionMenu.addAction(localAction)
//                        }
//                    }
//
//                    if !headphonesExist {
//                        optionMenu.addAction(deviceAction)
//                    }
//
//                    let speakerOutput = UIAlertAction(title: "Speaker", style: .default, handler: {
//                        (alert: UIAlertAction!) -> Void in
//
//                        do {
//                            try audioSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
//                        } catch let error as NSError {
//                            print("audioSession error turning on speaker: \(error.localizedDescription)")
//                        }
//                    })
//                    for description in currentRoute.outputs {
//                        if description.portType == AVAudioSession.Port.builtInSpeaker{
//                            speakerOutput.setValue(true, forKey: "checked")
//                            break
//                        }
//                    }
//                    speakerOutput.setValue(UIImage(named:"speaker.png"), forKey: "image")
//                    optionMenu.addAction(speakerOutput)
//
//                    let cancelAction = UIAlertAction(title: "Hide", style: .cancel, handler: {
//                        (alert: UIAlertAction!) -> Void in
//
//                    })
//                    optionMenu.addAction(cancelAction)
////                    self.present(optionMenu, animated: true, completion: nil)
        
            
    }
    
    func startRecording() {

        let mixer = engine.mainMixerNode
        let format = mixer.outputFormat(forBus: 0)

//        mixer.installTap(onBus: 0, bufferSize: 1024, format: format, block:
//            { (buffer: AVAudioPCMBuffer!, time: AVAudioTime!) -> Void in
//
//                print(NSString(string: "writing"))
////                do{
////                    try self.outputFile.write(from: buffer)
////                }
////                catch {
////                    print(NSString(string: "Write failed"));
////                }
//        })
    }

    func stopRecording() {

        engine.mainMixerNode.removeTap(onBus: 0)
        engine.stop()
    }
    
    
    
    func initializeAudioEngine() {
        
        engine.stop()
        engine.reset()
        engine = AVAudioEngine()
        isRealTime = true
        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord,mode: .voiceChat, options: [.allowBluetooth, .allowBluetoothA2DP, .allowAirPlay, .defaultToSpeaker])
//
//            let ioBufferDuration = 128.0 / 44100.0
//            
//            try AVAudioSession.sharedInstance().setPreferredIOBufferDuration(ioBufferDuration)
//
        } catch {}
//
        for input in AVAudioSession.sharedInstance().availableInputs!{
            if input.portType == AVAudioSession.Port.bluetoothA2DP || input.portType == AVAudioSession.Port.bluetoothHFP || input.portType == AVAudioSession.Port.bluetoothLE{
                
                do {
                    try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSession.PortOverride.none)
                } catch let error as NSError {
                    print("audioSession error turning off speaker: \(error.localizedDescription)")
                }
                
                do {
                    try AVAudioSession.sharedInstance().setPreferredInput(input)
                }catch _ {
                    print("cannot set mic ")
                }
                break
            }
        }
//            assertionFailure("AVAudioSession setup error: \(error)")
//        }

//        let fileUrl = URL(fileURLWithPath: "/NewRecording.caf")//URLFor("/NewRecording.caf")
//        print(fileUrl)
//        do {
//
//            try outputFile = AVAudioFile(forWriting:  fileUrl, settings: engine.mainMixerNode.outputFormat(forBus: 0).settings)
//        }
//        catch {
//
//        }

        let input = engine.inputNode
        
        input.removeTap(onBus: 0)
        let format = input.inputFormat(forBus: 0)
//
//        //settings for reverb
        reverb.loadFactoryPreset(.mediumChamber)
        reverb.wetDryMix = 0 //0-100 range
        engine.attach(reverb)
//
        delay.delayTime = 0.2 // 0-2 range
        engine.attach(delay)
//
//        //settings for distortion
//        distortion.loadFactoryPreset(.drumsBitBrush)
//        distortion.wetDryMix = 20 //0-100 range
//        engine.attach(distortion)
//
//
//        engine.connect(input, to: reverb, format: format)
//        engine.connect(reverb, to: distortion, format: format)
//        engine.connect(distortion, to: delay, format: format)
        engine.connect(input, to: reverb, format: format)
        engine.connect(reverb, to: delay, format: format)
        engine.connect(delay, to: engine.mainMixerNode, format: format)

//        assert(engine.inputNode != nil)

//        isReverbOn = false

        try! engine.start()
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
