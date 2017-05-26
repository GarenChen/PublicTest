//
//  QiniuTool.swift
//  MatchDay
//
//  Created by Garen on 16/9/29.
//  Copyright © 2016年 MatchDay. All rights reserved.
//

import UIKit

class QiniuImageTool {
	
	public static var uuidForfileName: String {
		return NSUUID().uuidString.lowercased().replacingOccurrences(of: "-", with:"")
	}
	
	public static var dateForKey: String {
		let formatter = DateFormatter()
		formatter.dateFormat = "YYYYMMdd"
		return formatter.string(from: Date())
	}

	/// 计算缩小的比例
    public static func getScale(fromSize:CGSize, lessThan size:CGSize) -> CGFloat {
        let H = size.height / fromSize.height
        let W = size.width / fromSize.width
        return H > W ? W : H
    }
	
	/// 缩小图片
    public static func setImage(_ image:UIImage?, toScale scale:CGFloat) -> UIImage? {
		
        if scale >= 1.0 {
            return image
        }
		
        if let origin = image {
            UIGraphicsBeginImageContext(CGSize(width:origin.size.width * scale, height:origin.size.height * scale))
            origin.draw(in: CGRect(x: 0, y: 0, width:origin.size.width * scale, height:origin.size.height * scale))
            let finalImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext()
            return finalImage
        }
		
        return nil
    }
    
    /// 获取图片数据
    public static func getData(fromImage image:UIImage, toQuality:CGFloat) -> Data? {

        guard let data = UIImageJPEGRepresentation(image, toQuality) else {
			
			#if DEBUG
				print("<QiuNiu> 转换图片Quality失败！")
			#endif
			
			return nil
        }
        return data
    }
	
	/// 获取图片数据
    public static func getData(fromImage image:UIImage, lessThan size:CGSize, quality:CGFloat) -> Data? {
		
        let scale = self.getScale(fromSize: image.size, lessThan: size)
		
		guard let scaled = self.setImage(image, toScale: scale) else {
			return nil
		}
		
        return self.getData(fromImage:scaled, toQuality:quality)
    }
    
    
    
}
