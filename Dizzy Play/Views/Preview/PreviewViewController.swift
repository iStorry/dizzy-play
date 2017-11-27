//
//  PreviewViewController.swift
//  Dizzy Play
//
//  Created by ジャチン on 2017/11/16.
//  Copyright © 2017 ジャチン. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var img = ""
    var index = IndexPath()

    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        imageView.frame = self.view.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = "Amsterdam"
        imageView.image = UIImage(contentsOfFile: img)
        self.view.addSubview(imageView)
    }
    
    @available(iOS 9.0, *)
    override var previewActionItems: [UIPreviewActionItem] {
        let item1 = UIPreviewAction(title: "Remove", style: .destructive) {
            (action, vc) in
            self.remove()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
        return [item1]
    }
    
    func remove() {
        let fileManager = FileManager.default
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let basic = SplashView.files[index.row]
        let file_name = "\(basic.name).\(basic.extenstion)"
        do {
            try fileManager.removeItem(atPath: documentsPath + "/" + file_name)
            SplashView.files.remove(at: self.index.row)
        } catch {
            print("Could not clear temp folder: \(error)")
        }
    }
        //
        
       // if files.
        
//        if fileManager.fileExists(atPath: path.name) {
//            print("Yes")
//           // try fileManager.removeItem(atPath: path.name)
//        } else {
//            print("File does not exist")
//        }
    
//
//    func previewActionItems() -> [UIPreviewActionItem] {
//
//        let likeAction = UIPreviewAction(title: "Like", style: .default) { (action, viewController) ->
//
//            Void in
//
//            print("Like it? ")
//
//        }
//
//        let deleteAction = UIPreviewAction(title: "Delete", style: .destructive) { (action, viewController) -> Void in
//
//            print("Deleted this !! ")
//
//        }
//
//        return [likeAction, deleteAction]
//
//    }

//    func previewActionItems() -> [UIPreviewActionItem] {
//        let deleteAction = UIPreviewAction(title: "Remove Picture", style: .destructive) { (action, viewController) -> Void in
//            print("You deleted the photo")
//        }
//        return [deleteAction]
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
