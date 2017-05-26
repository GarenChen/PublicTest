//
//  QiniuService.swift
//  MatchDay
//
//  Created by Garen on 16/9/29.
//  Copyright © 2016年 MatchDay. All rights reserved.
//

import UIKit
import Qiniu

// add error code
public typealias QiniuCompleteCallback = (QNResponseInfo?, String?) -> Swift.Void


open class QiniuService {
	
	private init() {}
    
    public static let sharedInstance = QiniuService()

	public static func instance(defualtToken: String, chatTocken: String) {
		QiniuService.sharedInstance.QINIU_DEFAULT_TOKEN = defualtToken
		QiniuService.sharedInstance.QINIU_CHAT_TOKEN = chatTocken
	}
	
    let manager = QNUploadManager()
    
	var QINIU_CHAT_TOKEN = ""
    var QINIU_DEFAULT_TOKEN = ""
	
	
	/// 通过defaultToken上传
	public func upload(defaultData data:Data,
	            key:String,
	            option:QNUploadOption = QNUploadOption.defaultOptions(),
	            callback:@escaping QiniuCompleteCallback) {
		
		 upload(data: data, key: key, token: self.QINIU_DEFAULT_TOKEN, option: option, callback: callback)
		
	}
	
	
	/// 通过chatToken上传
	public func upload(ChatData data:Data,
	            key:String,
	            option:QNUploadOption = QNUploadOption.defaultOptions(),
	            callback:@escaping QiniuCompleteCallback) {

		 upload(data: data, key: key, token: self.QINIU_CHAT_TOKEN, option: option, callback: callback)

	}
	
    public func upload(data:Data,
                key:String,
                token:String,
                option:QNUploadOption,
                callback:@escaping QiniuCompleteCallback) {

        manager?.put(data,
                     key: key,
                     token: token,
                     complete: { (info, key, resp) in
						
					 #if DEBUG
						print("<QiuNiu> upload data,key=\(key) info=\(info), resp=\(resp)")
					 #endif
						callback(info, key)
						
		}, option: option)
    }
	
	
	public func download(fromUrl:String,
						 callback:((Bool, Data?) -> Void)?) {
		
		DispatchQueue.global().async {
			
			if let imageUrl = URL(string: fromUrl) {

				do {
					let imageData = try Data.init(contentsOf: imageUrl)
					
					#if DEBUG
						print("<QiuNiu> 下载成功")
					#endif
					
					DispatchQueue.main.async {
						callback?(true, imageData)
					}
					
				} catch let error {
					
					#if DEBUG
						print("<QiuNiu> 下载数据失败：\(error)")
					#endif
					
					DispatchQueue.main.async {
						callback?(false, nil)
					}
				}
				
			}
		}
	}

}



