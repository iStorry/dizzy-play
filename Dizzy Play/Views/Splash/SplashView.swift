//
//  SplashView.swift
//  Dizzy Play
//
//  Created by ジャチン on 2017/11/15.
//  Copyright © 2017 ジャチン. All rights reserved.
//

import UIKit
import Advance
import Pastel
import BiometricAuth
import anim

struct Files {

    var extenstion: String
    var url: URL
    var name: String
    init(extenstion: String, url: URL, name: String) {
        self.extenstion = extenstion
        self.url = url
        self.name = name
    }
}
class SplashView: UIViewController {

    let activityView = ActivityView()
    let auth = BiometricAuth(forceThrowsOnChangedDomainState: true)
    let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static var files = [Files]()
    
    @IBOutlet weak var loginBtn: UIButton! {
        didSet {
            loginBtn.layer.cornerRadius = loginBtn.frame.size.height / 2.0
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pastelView = PastelView(frame: view.bounds)
        
        // Custom Direction
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        
        // Custom Duration
        pastelView.animationDuration = 3.0

        // Custom Color
        pastelView.setColors([UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
                              UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
                              UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
                              UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)])
        
        pastelView.startAnimation()
        view.insertSubview(pastelView, at: 0)
    
        activityView.flashing = true
        view.addSubview(activityView)
        
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
            directoryContents.forEach {
                SplashView.files += [Files(
                    extenstion: $0.pathExtension,
                    url: $0.absoluteURL,
                    name: $0.deletingPathExtension().lastPathComponent
                )]
            }
        } catch { print(error.localizedDescription) }
        
        
        
        anim {
            self.loginBtn.frame.origin = CGPoint(x:100, y:100)
            }
            // after that, waits 100 ms
            .wait(0.5)
            // moves box to 0,0 after waiting
            .then {
                //self.loginBtn.frame.origin = CGPoint(x:0, y:0)
            }
            // displays message after all animations are done
            .callback {
                print("Just finished moving 📦 around.")
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = min(view.bounds.width, view.bounds.height) * 0.8
        activityView.bounds.size = CGSize(width: size, height: size)
        activityView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touchLogin(_ sender: UIButton) {
        let feature = "Passcode Screen Auth"
        let reason = "Please Verify Your Identity."
        do { _ = try self.auth.enableAuthentication(forFeature: feature)
        } catch let error as BiometricAuthError { print(error.localizedDescription) }
        catch { print("Something went wrong") }
        auth.requestAuthentication(forFeature: feature, reason: reason, completion:
            {(result, error) in if result {
                self.loginSuccess()
            }
        })
    }
    
    private func loginSuccess() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"navigationMain")
        self.present(viewController, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
