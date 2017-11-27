//
//  ListView.swift
//  Dizzy Play
//
//  Created by ジャチン on 2017/11/15.
//  Copyright © 2017 ジャチン. All rights reserved.
//

import UIKit
import ImagePicker
import Lightbox
import PeekPop

private let reuseIdentifier = "cell"

let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

class ListView: UITableViewController, PeekPopPreviewingDelegate {
    
    var files = [Files]()
    
    let iconColors = [
        UIColor(red:0.67, green:0.91, blue:0.86, alpha:1.00),
        UIColor(red:0.72, green:0.86, blue:0.95, alpha:1.00),
        UIColor(red:0.97, green:0.76, blue:0.73, alpha:1.00),
        UIColor(red:0.96, green:0.82, blue:0.68, alpha:1.00),
        UIColor(red:0.98, green:0.92, blue:0.65, alpha:1.00),
        UIColor(red:0.71, green:0.93, blue:0.80, alpha:1.00)
    ]
    
    var peekPop: PeekPop?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        files = SplashView.files
        peekPop = PeekPop(viewController: self)
        _ = peekPop?.registerForPreviewingWithDelegate(self, sourceView: tableView)
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // Do any additional setup after loading the view.
    }
    
    @objc func loadList(){
        //load data here
        files = SplashView.files
        UIView.transition(with: tableView, duration: 0.35, options: .transitionCrossDissolve, animations: {
            self.tableView.reloadData()
        })
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func previewingContext(_ previewingContext: PreviewingContext, viewControllerForLocation location: CGPoint) -> UIViewController? {
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        if let previewViewController = storyboard.instantiateViewController(withIdentifier: "PreviewViewController") as? PreviewViewController {
            if let indexPath = tableView.indexPathForRow(at: location){
                let selectedImage = files[indexPath.row].url.path
                previewingContext.sourceRect = tableView.rectForRow(at: indexPath)
                previewViewController.index = indexPath
                previewViewController.img = selectedImage
                return previewViewController
            }
            
        }
        return nil
    }
    
    func previewingContext(_ previewingContext: PreviewingContext, commitViewController viewControllerToCommit: UIViewController) {
        self.navigationController?.pushViewController(viewControllerToCommit, animated: false)
    }

    
    @IBAction func openSheet(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Select Option", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Add Images", style: .default , handler:{ (UIAlertAction)in
            self.showPhotoLibrary()
        }))
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive , handler:{ (UIAlertAction)in
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    private func showPhotoLibrary() {
        let imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    // MARK: UICollectionViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ListCell
        cell.imgView.image = UIImage(contentsOfFile: files[indexPath.row].url.path)
        return cell
    }
    private func getFirstChar(data: String) -> String {
        let item = String(describing: data.uppercased().first!)
        return item
    }
}
extension ListView: ImagePickerDelegate {
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        guard images.count > 0 else { return }
        let lightboxImages = images.map {
            return LightboxImage(image: $0)
        }
        let lightbox = LightboxController(images: lightboxImages, startIndex: 0)
        imagePicker.present(lightbox, animated: true, completion: nil)
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        guard images.count > 0 else { return }
        let path = try! FileManager.default.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
        images.forEach {
            let image_path = path.appendingPathComponent("\(randomString(length: 13)).jpg")
            let data = UIImageJPEGRepresentation($0, 1.0)
            do { try data!.write(to: image_path); self.getUpdates() }
            catch { print("Error : \(error)")}
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    private func getUpdates() {
        do {
            SplashView.files.removeAll()
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
            directoryContents.forEach {
                SplashView.files += [Files(
                    extenstion: $0.pathExtension,
                    url: $0.absoluteURL,
                    name: $0.deletingPathExtension().lastPathComponent
                    )]
            }
            files = SplashView.files
            tableView.reloadData()
        } catch { print(error.localizedDescription) }
    }
    
    
}
extension ListView: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let padding: CGFloat = 25
//        let collectionCellSize = collectionView.frame.size.width - padding
//        return CGSize(width: collectionCellSize/3, height: collectionCellSize/3)
//
//    }
}
