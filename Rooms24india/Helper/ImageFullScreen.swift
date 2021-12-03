//
//  ImageFullScreen.swift
//  AirVTing
//
//  Created by Thanh Gieng on 11/20/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import ImageSlideshow

class ImageFullScreen: ImageSlideshow {
    open fileprivate(set) var slideshowFullScreenTransitioningDelegate: ZoomAnimatedTransitioningDelegate?
    open func presentFullScreenImageController(from controller: UIViewController) -> FullScreenSlideshowViewController {
        let fullscreen = FullScreenSlideshowViewController()
        fullscreen.pageSelected = {[weak self] (page: Int) in
            self?.setCurrentPage(page, animated: false)
        }
        fullscreen.initialPage = currentPage
        fullscreen.inputs = images
        fullscreen.modalPresentationStyle = .fullScreen
        slideshowFullScreenTransitioningDelegate = ZoomAnimatedTransitioningDelegate(slideshowView: self, slideshowController: fullscreen)
        fullscreen.transitioningDelegate = slideshowFullScreenTransitioningDelegate
        controller.present(fullscreen, animated: true, completion: nil)
        return fullscreen
    }
}
