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
    @State private var pitch = AVAudioUnitEQ(numberOfBands: 1)
//    @State private var reverb = AVAudioUnitReverb()
    @State private var te = AVAudioUnitEffect()
    
    
    @State private var delay = AVAudioUnitDelay()
    @State private var isRealTime = true
    @State var showingOptions = false
    @State var delayInt: Float = 1000.0
    @State var type: Float = 0
    @State var bandwith: Float = 0.05
    init(){
        initializeAudioEngine(first: true)
    }
    
    var body: some View {
        VStack{
            Button("Gae"){
                for input in AVAudioSession.sharedInstance().availableInputs!{
                    if input.portType == AVAudioSession.Port.builtInMic || input.portType == AVAudioSession.Port.builtInReceiver  {
                        do {
                            try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSession.PortOverride.none)
                        } catch let error as NSError {
                            print("audioSession error turning off speaker: \(error.localizedDescription)")
                        }
                        
                        do {
                            try AVAudioSession.sharedInstance().setPreferredInput(input)
                            try engine.start()
                        }catch _ {
                            print("cannot set mic ")
                        }
                        break
                    }
                }
            }
            Text("freq \(delayInt)")
            Slider(value: $delayInt, in: 1...1000, step: 1)
            Text("type #\(type)")
            Slider(value: $type, in: 0...10 , step: 1)
            Text("bandwidth \(bandwith)")
            Slider(value: $bandwith, in: 0.05...5.0 , step: 0.05)
        }
        .onChange(of: delayInt, perform: {_ in
            
            pitch.bands[0].frequency = delayInt
            pitch.bands[0].bandwidth = bandwith
            pitch.bands[0].filterType = AVAudioUnitEQFilterType(rawValue: Int(type))!
            pitch.bands[0].bypass = false
        })
        .onChange(of: type, perform: {_ in
            
            pitch.bands[0].frequency = delayInt
            pitch.bands[0].bandwidth = bandwith
            pitch.bands[0].filterType = AVAudioUnitEQFilterType(rawValue: Int(type))!
            pitch.bands[0].bypass = false
        })
        .onChange(of: bandwith, perform: {_ in
            
            pitch.bands[0].frequency = delayInt
            pitch.bands[0].bandwidth = bandwith
            pitch.bands[0].filterType = AVAudioUnitEQFilterType(rawValue: Int(type))!
            pitch.bands[0].bypass = false
        })
        
        
       
        
        
        
        
//        }
    
//
//        Button("CUm"){
////            showingOptions = true
////            reverb.loadFactoryPreset(.cathedral)
////            reverb.wetDryMix = 100 //0-100 range
//
//    //
//
//        }
//
//        .confirmationDialog("cum", isPresented: $showingOptions){
//            Button("Blut"){
//                for input in AVAudioSession.sharedInstance().availableInputs!{
//                    if input.portType == AVAudioSession.Port.bluetoothA2DP || input.portType == AVAudioSession.Port.bluetoothHFP || input.portType == AVAudioSession.Port.bluetoothLE{
//
//                        do {
//                            try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSession.PortOverride.none)
//                        } catch let error as NSError {
//                            print("audioSession error turning off speaker: \(error.localizedDescription)")
//                        }
//
//                        do {
//                            try AVAudioSession.sharedInstance().setPreferredInput(input)
//                        }catch _ {
//                            print("cannot set mic ")
//                        }
//                        break
//                    }
//                }
//            }
//
//            Button("built"){
//                for input in AVAudioSession.sharedInstance().availableInputs!{
//                    if input.portType == AVAudioSession.Port.builtInMic || input.portType == AVAudioSession.Port.builtInReceiver  {
//                        do {
//                            try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSession.PortOverride.none)
//                        } catch let error as NSError {
//                            print("audioSession error turning off speaker: \(error.localizedDescription)")
//                        }
//
//                        do {
//                            try AVAudioSession.sharedInstance().setPreferredInput(input)
//                        }catch _ {
//                            print("cannot set mic ")
//                        }
//                        break
//                    }
//                }
//            }
//        }
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
    
    
    
    
    
    func initializeAudioEngine(first: Bool = false) {
        
        engine.stop()
        engine.reset()
        engine = AVAudioEngine()
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
        if first{
        let input = engine.inputNode
        pitch.bands[0].filterType = .highPass
        pitch.bands[0].frequency = 15000
        pitch.bands[0].bandwidth = bandwith
        pitch.bands[0].bypass = false
//        engine.detach(pitch)
        engine.attach(pitch)
        input.removeTap(onBus: 0)
        let format = input.inputFormat(forBus: 0)
        
        
        engine.connect(input, to: pitch, format: format)
        engine.connect(pitch, to: engine.mainMixerNode, format: format)
            engine.prepare()
        }
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
