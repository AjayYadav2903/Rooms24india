//
//  EditImageViewController.swift
//  AirVting
//
//  Created by Admin on 7/2/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

enum PhotoFilterState {
    case filter
    case brightness
    case crop
}

protocol EditImageViewControllerDelegate: class {
    func didFinishEditImage(image: UIImage)
}

class EditImageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, AKImageCropperViewDelegate{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnCrop: UIButton!
    @IBOutlet weak var btnContrast: UIButton!
    @IBOutlet weak var segmentView: UISegmentedControl!
    @IBOutlet weak var constraintHeighCollectionView: NSLayoutConstraint!
    @IBOutlet weak var constraintHeighSliderView: NSLayoutConstraint!
    @IBOutlet weak var constraintHeighRotateView: NSLayoutConstraint!
    var inputImage: UIImage? = UIImage(named: "picture")
    @IBOutlet weak var headerButtonsView: UIView!
    fileprivate var smallImage: UIImage?
    fileprivate var currentFilteredImage: UIImage?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sliderContrast: UISlider!
    fileprivate var filterIndex = 0
    fileprivate let context = CIContext(options: nil)
    
    @IBOutlet weak var cropContentView: UIView!
    var rotateAngle: Double = 0
    
    // choose mode which the controller will return filtered image to
    enum ReturnMode {
        case MediaPicker
        case EditProfile
    }
    var returnMode: ReturnMode = .MediaPicker   // default
    
    weak var delegate: EditImageViewControllerDelegate?
    
    private var cropView: AKImageCropperView {
        return cropViewStoryboard
    }
    
    @IBOutlet weak var cropViewStoryboard: AKImageCropperView!
    
    fileprivate let filterNameList = [
        "No Filter",
        "CIPhotoEffectChrome",
        "CIPhotoEffectFade",
        "CIPhotoEffectInstant",
        "CIPhotoEffectMono",
        "CIPhotoEffectNoir",
        "CIPhotoEffectProcess",
        "CIPhotoEffectTonal",
        "CIPhotoEffectTransfer",
        "CILinearToSRGBToneCurve",
        "CISRGBToneCurveToLinear"
    ]
    
    fileprivate let filterDisplayNameList = [
        "Normal",
        "Chrome",
        "Fade",
        "Instant",
        "Mono",
        "Noir",
        "Process",
        "Tonal",
        "Transfer",
        "Tone",
        "Linear"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        filterState = .filter
        segmentView.selectedSegmentIndex = 1
        
        cropView.delegate = self
        imageView?.image = inputImage!
      //  inputImage = inputImage!.resizeImage(maxLenght: 1000)
        
      //  smallImage = inputImage!.resizeImage(maxLenght: 150)
        
        collectionView.reloadData()
       // self.collectionView.updateBackground()
      //  segmentView.setTitleFont(font: UIFont(name: "OpenSans-Regular", size: 10))
      //  self.segmentView.setOldLayout(normalColor: UIColor.white, selectedColor: UIColor.darkText)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    //MARK: - Actions
    @IBAction func segmentDidChangeValue(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            filterState = .crop
            cropView.image = currentFilteredImage ?? inputImage
            cropView.showOverlayView(animationDuration: 0.3)
            break
        case 1:
            filterState = .filter
            imageView.image = currentFilteredImage ?? inputImage
            rotateAngle = 0.0
            if didChangeBrightness && imageView.image != nil {
                inputImage = imageView.image
             //   smallImage = imageView.image!.resizeImage(maxLenght: 150)
                collectionView.reloadData()
            //    self.collectionView.updateBackground()
            }
            break
        default:
            break
        }
    }
    
    @IBAction func didTouchBack(_ sender: Any) {
        if returnMode == .MediaPicker {
            self.navigationController?.popViewController(animated: true)
        } else {    // EditProfile
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func didTouchNext(_ sender: Any) {
        if returnMode == .MediaPicker {
//            let vc = UIStoryboard(name: "Posts", bundle: nil).instantiateViewController(withIdentifier: "NewPostViewController") as! NewPostViewController
//            vc.currentMedia = currentFilteredImage ?? inputImage
//            app.mainNav?.pushViewController(vc, animated: true)
        } else {    // EditProfile
            let filteredImage = currentFilteredImage ?? inputImage
            delegate?.didFinishEditImage(image: filteredImage!)
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func didTouchChangeButtons(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        switch sender {
        case btnCrop:
            filterState = .crop
            break
        case btnContrast:
            filterState = .brightness
            break
        default: break
        }
    }
    
    @IBAction func didTouchCrop(_ sender: Any) {
        currentFilteredImage = cropView.croppedImage
        cropView.image = currentFilteredImage
        inputImage = currentFilteredImage
      //  smallImage = currentFilteredImage?.resizeImage(maxLenght: 150)
        imageView.image = currentFilteredImage
        collectionView.reloadData()
       // self.collectionView.updateBackground()
    }
    
    @IBAction func didTouchRotate(_ sender: Any) {
        rotateAngle -= Double.pi/2
        let rotate = 2*Double.pi + rotateAngle
        cropView.rotate(rotate)
        if self.rotateAngle <= -2 * Double.pi {
            self.rotateAngle = 0.0
        }
    }
    
    var didChangeBrightness = false
    @IBAction func didChangeContrastSliderValue(_ sender: UISlider) {
        if let image = self.inputImage {
          //  self.currentFilteredImage =  image.updateBrightness(brightness: sender.value)
            self.imageView.image = currentFilteredImage
            cropView.image = currentFilteredImage
            didChangeBrightness = true
        }
    }
    
    var _filterState: PhotoFilterState = .filter
    var filterState: PhotoFilterState {
        get {
            return _filterState
        }
        set {
            _filterState = newValue
            switch newValue {
            case .filter:
                imageView.image = currentFilteredImage
                headerButtonsView.isHidden = true
                constraintHeighCollectionView.constant = 140
                constraintHeighSliderView.constant = 0
                constraintHeighRotateView.constant = 0
                cropContentView.isHidden = true
                break
            case .crop:
                headerButtonsView.isHidden = false
                btnContrast.isSelected = false
                btnCrop.isSelected = true
                constraintHeighCollectionView.constant = 0
                constraintHeighSliderView.constant = 0
                constraintHeighRotateView.constant = 60
                cropContentView.isHidden = false
                break
            case .brightness:
                headerButtonsView.isHidden = false
                btnContrast.isSelected = true
                btnCrop.isSelected = false
                constraintHeighCollectionView.constant = 0
                constraintHeighSliderView.constant = 60
                constraintHeighRotateView.constant = 0
                cropContentView.isHidden = true
                break
            }
        }
    }
    
    
    //MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterNameList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! FilterCollectionViewCell
        var filteredImage = smallImage
        if indexPath.row != 0 {
           // filteredImage = smallImage!.applyFilter(filterName: filterNameList[indexPath.row])
        }
        cell.imgSampleFilter.image = filteredImage
        cell.lbNameFilter.text = filterDisplayNameList[indexPath.row]
        if filterIndex == indexPath.row {
         //   cell.lbNameFilter.textColor = textColorH4_Active
        }
        else {
            
         //   cell.lbNameFilter.textColor = textColorH4
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if filterIndex == indexPath.row {
            return
        }
        filterIndex = indexPath.row
        if filterIndex != 0 {
            applyFilter()
            
        } else {
            imageView?.image = inputImage
        }
        scrollCollectionViewToIndex(itemIndex: indexPath.item)
        self.updateCellHighlight()
        self.sliderContrast.value = 0
    }
    
    
    func updateCellHighlight() {
        if let selectedCell = collectionView?.cellForItem(at: IndexPath(row: filterIndex, section: 0)) {
            let cell = selectedCell as! FilterCollectionViewCell
           // cell.lbNameFilter.textColor = textColorH4_Active
        }
        
        for i in 0...filterNameList.count - 1 {
            if i != filterIndex {
                if let unselectedCell = collectionView?.cellForItem(at: IndexPath(row: i, section: 0)) {
                    let cell = unselectedCell as! FilterCollectionViewCell
                 //   cell.lbNameFilter.textColor = textColorH4
                }
            }
        }
    }
    
    func applyFilter() {
        let filterName = filterNameList[filterIndex]
        if let image = self.inputImage {
//            let filteredImage = image.applyFilter(filterName: filterName)
//            imageView?.image = filteredImage
//            currentFilteredImage = filteredImage
        }
    }
    
    
    func scrollCollectionViewToIndex(itemIndex: Int) {
        let indexPath = IndexPath(item: itemIndex, section: 0)
        self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    //MARK: AKImageCropperDelegate
    func imageCropperViewDidChangeCropRect(view: AKImageCropperView, cropRect rect: CGRect) {
    }
    
}
