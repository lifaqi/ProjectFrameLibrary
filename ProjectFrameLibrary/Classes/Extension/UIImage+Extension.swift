//
//  UIImage+Extension.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2022/7/2.
//

import UIKit

extension UIImage {
    /**
     获取图片中的像素颜色值
     - parameter pos: 图片中的位置
     - returns: 颜色值
     */
    func getPixelColor(point: CGPoint) -> UIColor?{
        guard CGRect(origin: CGPoint(x: 0, y: 0), size: self.size).contains(point) else {
            return nil
        }
        
        let pointX = trunc(point.x);
        let pointY = trunc(point.y);
        
        let width = self.size.width;
        let height = self.size.height;
        let colorSpace = CGColorSpaceCreateDeviceRGB();
        var pixelData: [UInt8] = [0, 0, 0, 0]
        
        pixelData.withUnsafeMutableBytes { pointer in
            if let context = CGContext(data: pointer.baseAddress, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue), let cgImage = self.cgImage {
                context.setBlendMode(.copy)
                context.translateBy(x: -pointX, y: pointY - height)
                context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
            }
        }
        
        let red = CGFloat(pixelData[0]) / CGFloat(255.0)
        let green = CGFloat(pixelData[1]) / CGFloat(255.0)
        let blue = CGFloat(pixelData[2]) / CGFloat(255.0)
        let alpha = CGFloat(pixelData[3]) / CGFloat(255.0)
        
        if #available(iOS 10.0, *) {
            return UIColor(displayP3Red: red, green: green, blue: blue, alpha: alpha)
        } else {
            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }
    }
}
