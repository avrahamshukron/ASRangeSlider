//
//  SliderThumbView.m
//  Diamond App
//
//  Created by Avraham Shukron on 5/29/11.
// .
//

#import "SliderThumbView.h"
#import "UIViewExtensions.h"

@interface SliderThumbView()
@property (nonatomic , retain , readwrite) UILabel *textLabel;
@property (nonatomic , retain , readwrite) UIImageView *backgroundView;
@end

@implementation SliderThumbView

@synthesize backgroundView;
@synthesize textLabel;

-(id) initWithBackgroundImage : (UIImage *) background
{
    self = [super init];
    if (self) 
	{
        [self setBackgroundImage:background];
		
		textLabel = [[UILabel alloc] initWithFrame:self.frame];
		self.textLabel.backgroundColor = [UIColor clearColor];
		self.textLabel.textColor = [UIColor whiteColor];
		self.textLabel.adjustsFontSizeToFitWidth = YES;
		self.textLabel.textAlignment = UITextAlignmentCenter;
		[self addSubview:textLabel];
		self.textLabel.center = self.centerOfBounds;
	}
    return self;
}

-(id) init
{
	[self initWithBackgroundImage:[UIImage imageNamed:@"slider-handle.png"]];
	return self;
}

-(void) setBackgroundImage : (UIImage *) image
{
	UIImageView *newOne = [[UIImageView alloc] initWithImage:image];
	CGPoint center = self.center;
	self.frame = newOne.frame;
	self.center = center;
	[self.backgroundView removeFromSuperview];
	self.backgroundView = newOne;
	[newOne release];
	
	[self addSubview:self.backgroundView];
	self.backgroundView.center = self.centerOfBounds;
	self.textLabel.frame = self.backgroundView.frame;
	self.textLabel.center = self.centerOfBounds;
	[self bringSubviewToFront:self.textLabel];
}

- (void)dealloc
{
	[backgroundView release];
	[textLabel release];
	[super dealloc];
}

@end
