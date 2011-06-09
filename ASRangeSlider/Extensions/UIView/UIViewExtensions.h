//
//  untitled.h
//  iSeatU
//
//  Created by Avraham Shukron on 3/5/11.
//  Copyright 2011 appSTUDIO. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (Extensions) 

-(BOOL) rectIntersectBounds : (CGRect) rect;
 
-(BOOL) rectIntersectBounds:(CGRect)rect fromLocalCoordinateSystemOfView : (UIView *) aView;

-(BOOL) isMovementAwayFromCenter : (UIPanGestureRecognizer *) recognizer;

@property (readonly) CGPoint centerOfBounds;

-(CGFloat) distanceBetweenPoint:(CGPoint)firstPoint andPoint:(CGPoint) secondPoint;

-(CGPoint) vectorBetweenPoint:(CGPoint) firstPoint andPoint:(CGPoint) secondPoint;

-(CGFloat) dotProductOfVectorA:(CGPoint)vectorA andVectorB:(CGPoint)vectorB;

-(CGFloat) lengthOfVector:(CGPoint)vector;

-(CGFloat) angleBetweenVectorA:(CGPoint)vectorA andVectorB:(CGPoint)vectorB;

@end
