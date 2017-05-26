//
//  ViewController.swift
//  PublicTest
//
//  Created by GarenChen on 05/26/2017.
//  Copyright (c) 2017 GarenChen. All rights reserved.
//

import UIKit
import PublicTest

class ViewController: UIViewController {

	@IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		
		let service = PublicTest.QiniuService.sharedInstance
		
		service.download(fromUrl: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495789956744&di=82516868217db83179d3a3bb35d6c026&imgtype=0&src=http%3A%2F%2Fimg4.duitang.com%2Fuploads%2Fitem%2F201408%2F30%2F20140830185456_Eijik.jpeg") {[weak self] (seccess, data) in
			
			if let imageData = data {
				
				let image = UIImage.init(data: imageData)
				
				self?.imageView.image = image
				
			}
			
		}
		
		
    }
//
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

