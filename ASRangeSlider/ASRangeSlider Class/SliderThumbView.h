//
//  SliderThumbView.h
//  Diamond App
//
//  Created by Avraham Shukron on 5/29/11.
// .
//

#import <UIKit/UIKit.h>

@interface SliderThumbView : UIView 
{
	@private
	UIImageView *backgroundView;
	UILabel *textLabel;
}

@property (nonatomic , retain , readonly) UIImageView *backgroundView;
@property (nonatomic , retain , readonly) UILabel *textLabel;
-(id) init;
-(id) initWithBackgroundImage : (UIImage *) background;
-(void) setBackgroundImage : (UIImage *) image;
@end
