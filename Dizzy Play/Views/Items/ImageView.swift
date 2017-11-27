//
//  ImageView.swift
//  Dizzy Play
//
//  Created by ジャチン on 2017/11/15.
//  Copyright © 2017 ジャチン. All rights reserved.
//

import UIKit

class ImageView: UIViewController {
    
    @IBOutlet weak var itemView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ImageView : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "titleView", for: indexPath) as! ItemCell
        return cell
    }
    
    
}
