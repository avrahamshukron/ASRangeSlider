//
//  ASRangeSliderViewController.h
//  ASRangeSlider
//
//  Created by Avraham Shukron on 6/9/11.
// .
//

#import <UIKit/UIKit.h>

@class ASRangeSlider;
@interface ASRangeSliderViewController : UIViewController 
{
	IBOutlet UIView *slider1Placeholder;
	IBOutlet UIView *slider2Placeholder;
	IBOutlet UIView *slider3Placeholder;
	
	ASRangeSlider *slider1;
	ASRangeSlider *slider2;
	ASRangeSlider *slider3;
}

-(IBAction) slider1ValueChanged : (id) sender;
-(IBAction) slider2ValueChanged : (id) sender;
-(IBAction) slider3ValueChanged : (id) sender;

@property (nonatomic , retain) UIView *slider1Placeholder;
@property (nonatomic , retain) UIView *slider2Placeholder;
@property (nonatomic , retain) UIView *slider3Placeholder;

@property (nonatomic , retain) ASRangeSlider *slider1;
@property (nonatomic , retain) ASRangeSlider *slider2;
@property (nonatomic , retain) ASRangeSlider *slider3;

@end
