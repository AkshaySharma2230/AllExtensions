//
//  UIImage+Extension.swift
//  Extentions
//
//  Created by Akshay Kumar on 28/05/23.
//

import Foundation
import UIKit
import Photos

extension UIImage {
    
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    func maskWithColor(_ color: UIColor) -> UIImage? {
        
        let maskImage = self.cgImage
        let width = self.size.width
        let height = self.size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let bitmapContext = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) //needs rawValue of bitmapInfo
        
        bitmapContext?.clip(to: bounds, mask: maskImage!)
        bitmapContext?.setFillColor(color.cgColor)
        bitmapContext?.fill(bounds)
        
        //is it nil?
        if let cImage = bitmapContext?.makeImage() {
            let coloredImage = UIImage(cgImage: cImage)
            
            return coloredImage
            
        } else {
            return nil
        }
    }
    
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / self.size.width
        let heightRatio = targetSize.height / self.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            //newSize = CGSize(size.width * heightRatio, size.height * heightRatio)
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            //newSize = CGSize(size.width * widthRatio,  size.height * widthRatio)
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        //let rect = CGRect(0, 0, newSize.width, newSize.height)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
        // MARK: - UIImage+Resize
        func compressTo(_ expectedSizeInMb:Int) -> UIImage? {
            let sizeInBytes = expectedSizeInMb * 1024 * 1024
            var needCompress:Bool = true
            var imgData:Data?
            var compressingValue:CGFloat = 1.0
            while (needCompress && compressingValue > 0.0) {
                if let data:Data = self.jpegData(compressionQuality: compressingValue) {
                if data.count < sizeInBytes {
                    needCompress = false
                    imgData = data
                } else {
                    compressingValue -= 0.1
                }
            }
        }

        if let data = imgData {
            if (data.count < sizeInBytes) {
                return UIImage(data: data)
            }
        }
            return nil
        }
}



let imgCache = NSCache<NSString, AnyObject>()


extension UIImageView {
    
    // public var isContentInset: Bool = false
    
    public func setImageFromURl(_ urlString: String) {
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        let size = self.frame.size;
        activityIndicator.frame = CGRect.init(x: 0.0, y: 0.0, width: 44, height: 44)
        // activityIndicator.color = (Utils.AppColors.Green)
        activityIndicator.startAnimating()
        //activityIndicator.backgroundColor = UIColor.white
        // add spinner when image not avaialble
        if self.image == nil{
            activityIndicator.center = CGPoint(x: (size.width/2), y: (size.height/2)); // set center spinner
            self.addSubview(activityIndicator) // add spinner
        }else{
            
        }
        // check cached image
        if let cachedImage = imgCache.object(forKey: urlString as NSString) as? UIImage {
            
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = CATransitionType.fade
            //self.layer.add(transition, forKey: nil)
            
            self.image = cachedImage
            activityIndicator.removeFromSuperview() // removed spinner when cachedImage
            return
        }
        // loading image by URL
        //URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
        let encodeUrl: String? = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        URLSession.shared.dataTask(with: URL(string: encodeUrl!)!, completionHandler: { (data, response, error) -> Void in
            if error != nil {
//                print(error ?? "No Error")
                activityIndicator.removeFromSuperview() // removed spinner when image loaded
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                activityIndicator.removeFromSuperview() // removed spinner when image loaded
                
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.fade
                // self.layer.add(transition, forKey: nil)
                
                if image != nil {
                    self.image = image
                    imgCache.setObject(image!, forKey: urlString as NSString)
                }
            })
            
        }).resume()
    }
}

extension UIImage {
    convenience init?(url: URL?) {
        guard let url = url else { return nil }
        
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)
        } catch {
//            print("Cannot load image from url: \(url) with error: \(error)")
            return nil
        }
    }
}

//Generte Thumbnail from Video URL
extension URL {
    
    func generateThumbnail() -> UIImage? {
        do {
            let asset = AVURLAsset(url: self)
            let imageGenerator = AVAssetImageGenerator(asset: asset)
            imageGenerator.appliesPreferredTrackTransform = true
            // Select the right one based on which version you are using
            // Swift 4.2
            let cgImage = try imageGenerator.copyCGImage(at: .zero, actualTime: nil)
            
            return UIImage(cgImage: cgImage)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

extension UIImageView {
    var contentClippingRect: CGRect {
        guard let image = image else { return bounds }
        guard contentMode == .scaleAspectFit else { return bounds }
        guard image.size.width > 0 && image.size.height > 0 else { return bounds }
        
        let scale: CGFloat
        if image.size.width > image.size.height {
            scale = bounds.width / image.size.width
        } else {
            scale = bounds.height / image.size.height
        }
        
        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let x = (bounds.width - size.width) / 2.0
        let y = (bounds.height - size.height) / 2.0
        
        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
}
