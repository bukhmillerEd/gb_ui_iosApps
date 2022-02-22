//
//  CustomPushAnimator.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 08.11.2021.
//

import UIKit

final class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return 1
	}
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		guard let source = transitionContext.viewController(forKey: .from) else { return }
		guard let destination = transitionContext.viewController(forKey: .to) else { return }
		
		setAnchorPoint(anchorPoint: CGPoint(x: 1, y: 0), forView: destination.view)
		
		transitionContext.containerView.addSubview(destination.view)
		destination.view.frame = source.view.frame
		destination.view.transform = CGAffineTransform(rotationAngle: -.pi / 2)
		
		setAnchorPoint(anchorPoint: CGPoint(x: 0, y: 0), forView: source.view)
		
		UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
														delay: 0,
														options: .calculationModePaced,
														animations: {
			UIView.addKeyframe(withRelativeStartTime: 0,
												 relativeDuration: 0.75,
												 animations: {
				source.view.transform = CGAffineTransform(rotationAngle: .pi / 2)
			})
			UIView.addKeyframe(withRelativeStartTime: 0.2,
												 relativeDuration: 0.4,
												 animations: {
				destination.view.transform = CGAffineTransform(rotationAngle: 2 * .pi )

			})
		}) { finished in
			if finished && !transitionContext.transitionWasCancelled {
				source.view.transform = .identity
			}
			transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
		}
		
		
	}
	
	func setAnchorPoint(anchorPoint: CGPoint, forView view: UIView) {
			var newPoint = CGPoint(x: view.bounds.size.width * anchorPoint.x,
														 y: view.bounds.size.height * anchorPoint.y)

			var oldPoint = CGPoint(x: view.bounds.size.width * view.layer.anchorPoint.x,
														 y: view.bounds.size.height * view.layer.anchorPoint.y)

			newPoint = newPoint.applying(view.transform)
			oldPoint = oldPoint.applying(view.transform)

			var position = view.layer.position
			position.x -= oldPoint.x
			position.x += newPoint.x

			position.y -= oldPoint.y
			position.y += newPoint.y

			view.layer.position = position
			view.layer.anchorPoint = anchorPoint
	}
	
	
}

