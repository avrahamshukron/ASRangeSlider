//
//  untitled.m
//  iSeatU
//
//  Created by Avraham Shukron on 3/5/11.
//  Copyright 2011 appSTUDIO. All rights reserved.
//

#import "UIViewExtensions.h"
#import <math.h>

@implementation UIView (Extensions)

-(BOOL) rectIntersectBounds : (CGRect) rect
{
	return CGRectIntersectsRect(self.bounds, rect);
}

-(BOOL) rectIntersectBounds:(CGRect)rect fromLocalCoordinateSystemOfView : (UIView *) aView
{
	CGRect newRect = [self convertRect:rect fromView:aView];
	return [self rectIntersectBounds:newRect];
}

-(BOOL) isMovementAwayFromCenter : (UIPanGestureRecognizer *) recognizer
{
	CGPoint location = [recognizer locationInView:self];
	CGPoint translation = [recognizer translationInView:self];
	BOOL awayOnX = ((location.x > self.center.x && translation.x > 0)
					|| (location.x < self.center.x && translation.x < 0)
					);
	BOOL awayOnY = ((location.y > self.center.y && translation.y > 0)
					|| (location.y < self.center.y && translation.y < 0)
					);
	
	return (awayOnX && awayOnY);
}

-(CGPoint) centerOfBounds
{
	return CGPointMake((self.bounds.size.width - self.bounds.origin.x) / 2, (self.bounds.size.height - self.bounds.origin.y) / 2);
}

//These are two helper function for point trig calculations:

-(CGFloat)distanceBetweenPoint:(CGPoint)firstPoint andPoint:(CGPoint	) secondPoint{
	CGFloat distance;
	
	//Square difference in x
	CGFloat xDifferenceSquared = pow(firstPoint.x - secondPoint.x, 2);
	
	// Square difference in y
	CGFloat yDifferenceSquared = pow(firstPoint.y - secondPoint.y, 2);
	
	// Add and take Square root
	distance = sqrt(xDifferenceSquared + yDifferenceSquared);
	return distance;	
}

-(CGPoint) vectorBetweenPoint:(CGPoint) firstPoint andPoint:(CGPoint) secondPoint
{
	return CGPointMake(firstPoint.x - secondPoint.x, firstPoint.y - secondPoint.y);	
}

-(CGFloat) dotProductOfVectorA:(CGPoint) vectorA andVectorB:(CGPoint)vectorB
{
	return ((vectorA.x * vectorB.x) + (vectorA.y * vectorB.y));
}

-(CGFloat)lengthOfVector:(CGPoint)vector
{
	return sqrt(pow(vector.x,2) + pow(vector.y,2));
}

-(CGFloat) angleBetweenVectorA:(CGPoint)vectorA andVectorB:(CGPoint)vectorB
{
	/* Calculated by the formula:
	 *
	 *	alpha = u*v / ||u|| * ||v||
	 */
	
	CGFloat dotProduct = [self dotProductOfVectorA:vectorA andVectorB:vectorB];
	CGFloat lengthA = [self lengthOfVector:vectorA];
	CGFloat lengthB = [self lengthOfVector:vectorB];
	
	return acosf(dotProduct / (lengthA * lengthB));
}

@end