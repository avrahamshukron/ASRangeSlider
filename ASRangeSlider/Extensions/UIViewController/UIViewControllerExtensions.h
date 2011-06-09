//
//  UIViewControllerExtensions.h
//  iSeatU
//
//  Created by Avraham Shukron on 3/28/11.
//  Copyright 2011 appSTUDIO. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (Extensions)

-(void) showErrorMessageWithError : (NSError *) error;

-(void) showErrorMessage : (NSString *) message withTitle : (NSString *) title;

-(void) showErrorMessage : (NSString *) message;

@end
