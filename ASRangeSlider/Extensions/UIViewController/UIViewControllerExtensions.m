    //
//  UIViewControllerExtensions.m
//  iSeatU
//
//  Created by Avraham Shukron on 3/28/11.
//  Copyright 2011 appSTUDIO. All rights reserved.
//

#import "UIViewControllerExtensions.h"


@implementation UIViewController (Extensions)

-(void) showErrorMessage : (NSString *)message withTitle : (NSString *)title
{
	UIAlertView *alert = [[UIAlertView alloc] 
						  initWithTitle:title 
						  message:message 
						  delegate:nil 
						  cancelButtonTitle:NSLocalizedString(@"OK",nil) 
						  otherButtonTitles:nil];
	[alert show];
	[alert release];
}

-(void) showErrorMessage : (NSString *)message
{
	[self showErrorMessage:message withTitle:NSLocalizedString(@"Error",nil)];
}

-(void) showErrorMessageWithError : (NSError *) error
{
	[self showErrorMessage:[error localizedDescription]];
}

@end
