//
//  CustomPopAnimator.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 08.11.2021.
//

import UIKit

final class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
	
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return 1
	}
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		guard let source = transitionContext.viewController(forKey: .from) else { return }
		guard let destination = transitionContext.viewController(forKey: .to) else { return }
		
		transitionContext.containerView.addSubview(destination.view)
		transitionContext.containerView.sendSubviewToBack(destination.view)
		
		destination.view.frame = source.view.frame

		destination.view.transform = CGAffineTransform(rotationAngle: .pi / 2)
		
		UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
														delay: 0,
														options: .calculationModePaced,
														animations: {
			UIView.addKeyframe(withRelativeStartTime: 0,
												 relativeDuration: 0.4,
												 animations: {
				destination.view.transform = CGAffineTransform(rotationAngle:  -2 * .pi)
			})
			UIView.addKeyframe(withRelativeStartTime: 0.4,
												 relativeDuration: 0.4,
												 animations: {
				source.view.transform = CGAffineTransform(rotationAngle: -.pi / 2)
			})
		}) { finished in
			if finished && !transitionContext.transitionWasCancelled {
				source.removeFromParent()
			} else if transitionContext.transitionWasCancelled {
				destination.view.transform = .identity
			}
			transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
		}
	}
	
	
	
}
