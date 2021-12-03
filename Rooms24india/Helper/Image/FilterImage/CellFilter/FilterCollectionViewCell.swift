//
//  FilterCollectionViewCell.swift
//  AirVting
//
//  Created by Admin on 7/2/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgSampleFilter: UIImageView!
    @IBOutlet weak var lbNameFilter: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
      //  lbNameFilter.font = fontH4
      //  lbNameFilter.textColor = textColorH4
    }
    
    func displayContent(fullNameFilter: String,name: String){
        lbNameFilter.text = name
        let inputImage = UIImage(named: "picture")!
        let context = CIContext(options: nil)
        /*
        if let currentFilter = CIFilter(name: fullNameFilter) {
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            currentFilter.setValue(0.5, forKey: kCIInputIntensityKey)
            
            if let output = currentFilter.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    let processedImage = UIImage(cgImage: cgimg)

                    imgSampleFilter.image = processedImage
                }
            }
        }
 */
        let ciContext = CIContext(options: nil)
        let coreImage = CIImage(image: inputImage)
        let filter = CIFilter(name: fullNameFilter )
        filter!.setDefaults()
        filter!.setValue(coreImage, forKey: kCIInputImageKey)
        let filteredImageData = filter!.value(forKey: kCIOutputImageKey) as! CIImage
        let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent)
        let imageForButton = UIImage(cgImage: filteredImageRef!)
        imgSampleFilter.image = imageForButton
    }
}
