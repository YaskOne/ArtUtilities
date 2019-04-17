//
//  ImageViewUtilities.swift
//  ArtUtilities
//
//  Created by Arthur Ngo Van on 9/6/18.
//  Copyright © 2018 Arthur Ngo Van. All rights reserved.
//

import Foundation
import UIKit

public extension UIImageView {
    
    public func imageFromURL(withSpinner: Bool = true, urlString: String, completion: @escaping (_ image: UIImage) -> Void) {
        guard !urlString.isEmpty, let url = URL(string: urlString) else {
            return
        }
        
        let sv = withSpinner ? self.displaySpinner() : nil

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                if let data = data, let img = UIImage(data: data) {
                    self.image = img
                    self.isHidden = false
                    completion(img)
                }
                if let sv = sv {
                    self.removeSpinner(spinner: sv)
                }
            }
        }
    }
    
    public func imageFromURL(urlString: String) {
        guard !urlString.isEmpty, let url = URL(string: urlString) else {
            return
        }
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                if let data = data, let img = UIImage(data: data) {
                    self.image = img
                    self.isHidden = false
                }
            }
        }
    }
    
}
