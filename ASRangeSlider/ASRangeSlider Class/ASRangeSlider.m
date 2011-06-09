//
//  ASRangeSlider.m
//  Diamond App
//
//  Created by Avraham Shukron on 5/29/11.
// .
//

#import "ASRangeSlider.h"
#import "SliderThumbView.h"
#import "UIViewExtensions.h"

#define DEFAULT_TRACK_IMAGE @"slider-track-right.png"

FloatRange FloatRangeMake(float min , float max)
{
	FloatRange toReturn;
	toReturn.min = min;
	toReturn.max = max;
	return toReturn;
}

@interface ASRangeSlider()
@property (nonatomic , readwrite) FloatRange spectrum;
@property (nonatomic , retain , readwrite) UIImageView *trackBackgroundView;
@property (nonatomic , retain , readwrite) UIImageView *activeAreaView;
@property (nonatomic, retain , readwrite) SliderThumbView *thumbOne;
@property (nonatomic , retain , readwrite) SliderThumbView *thumbTwo;

@property (nonatomic) float valueOfSliderThumbOne;
@property (nonatomic) float valueOfSliderThumbTwo;

@property (nonatomic , readonly) float rightmostPointOnTrack;
@property (nonatomic , readonly) float leftmostPointOnTrack;

-(void) updateSubviews;
-(void) setValue : (float) value forThumb : (SliderThumbView *) thumb;
-(float) valueForThumb : (SliderThumbView *) thumb;
-(void) createGestureRecognizers;
-(void) handlePan : (UIPanGestureRecognizer *) recognizer;
@end

@implementation ASRangeSlider

@synthesize trackBackgroundView;
@synthesize activeAreaView;
@synthesize thumbOne;
@synthesize thumbTwo;
@synthesize spectrum;
@synthesize leftmostPointOnTrack;
@synthesize rightmostPointOnTrack;

#pragma -
#pragma Properties
-(FloatRange) value
{
	float one = self.valueOfSliderThumbOne;
	float two = self.valueOfSliderThumbTwo;
	return FloatRangeMake(MIN(one,two), MAX(one,two));
}

-(void) setValue:(FloatRange)value
{
	self.valueOfSliderThumbOne = value.min;
	self.valueOfSliderThumbTwo = value.max;
}

-(float) minimumValue
{
	return self.spectrum.min;
}

-(float) maximumValue
{
	return self.spectrum.max;
}

-(SliderThumbView *) leftmostThumb
{
	if (self.valueOfSliderThumbOne <= self.valueOfSliderThumbTwo)
	{
		return self.thumbOne;
	}
	else
	{
		return self.thumbTwo;
	}
}

-(SliderThumbView *) rightmostThumb
{
	if (self.valueOfSliderThumbOne >= self.valueOfSliderThumbTwo)
	{
		return self.thumbOne;
	}
	else
	{
		return self.thumbTwo;
	}
}

-(float) leftmostPointOnTrack
{
	return leftmostPointOnTrack =  self.trackBackgroundView.frame.origin.x;
}

-(float) rightmostPointOnTrack
{
	return self.trackBackgroundView.frame.origin.x + self.trackBackgroundView.frame.size.width;
}

-(float) valueForThumb : (SliderThumbView *) thumb
{
	float trackLength = self.trackBackgroundView.frame.size.width;
	float currentPoint = thumb.center.x;
    float locationPercentage = (currentPoint - self.leftmostPointOnTrack) / trackLength;
	float value = locationPercentage*(self.maximumValue - self.minimumValue) + self.minimumValue;
	return value;
}

-(void) setValue : (float) value forThumb : (SliderThumbView *) thumb
{
	float toSet = MIN(self.maximumValue, value);
	toSet = MAX(self.minimumValue, value);
	
	if (toSet != [self valueForThumb:thumb])
	{
		float valuePrecentage = (toSet - self.minimumValue) / (self.maximumValue - self.minimumValue);
		float relativePosition = valuePrecentage * (self.rightmostPointOnTrack - self.leftmostPointOnTrack);
		float newPosition = relativePosition + self.leftmostPointOnTrack;
		thumb.center = CGPointMake(newPosition, thumb.center.y);
		[self updateSubviews];
		[self sendActionsForControlEvents:UIControlEventValueChanged];
	}
}

-(float) valueOfSliderThumbOne
{
	return [self valueForThumb:self.thumbOne];
}

-(float) valueOfSliderThumbTwo
{
	return [self valueForThumb:self.thumbTwo];
}

-(void) setValueOfSliderThumbOne:(float)valueOfSliderThumbOne
{
	[self setValue:valueOfSliderThumbOne forThumb:self.thumbOne];
}

-(void) setValueOfSliderThumbTwo:(float)valueOfSliderThumbTwo
{
	[self setValue:valueOfSliderThumbTwo forThumb:self.thumbTwo];
}

-(void) setFrame:(CGRect)aframe
{
	if ( ! CGRectEqualToRect(self.frame, aframe))
	{
		FloatRange valueNow = self.value;
		[super setFrame:aframe];
		CGRect frame =self.trackBackgroundView.frame;
		frame.size.width = aframe.size.width - (self.thumbOne.frame.size.width);
		self.trackBackgroundView.frame = frame;
		self.trackBackgroundView.center = self.centerOfBounds;
		self.activeAreaView.center = self.centerOfBounds;
		
		CGPoint thumbCenter = self.thumbOne.center;
		thumbCenter.y = self.centerOfBounds.y;
		self.thumbOne.center = thumbCenter;
		
		thumbCenter.x = self.thumbTwo.center.x;
		self.thumbTwo.center = thumbCenter;
		
		self.value = valueNow;
	}
}

#pragma -
#pragma Initialization

-(id) initWithSpectrum:(FloatRange)aSpectrum
{
	self = [super init];
    if (self) 
	{
		self.spectrum = aSpectrum;
		
		trackBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:DEFAULT_TRACK_IMAGE]];
		activeAreaView = [[UIImageView alloc] initWithFrame:self.trackBackgroundView.frame];
		thumbOne = [[SliderThumbView alloc] init];
		thumbTwo = [[SliderThumbView alloc] init];
		
		[self createGestureRecognizers];
		
		[self addSubview:trackBackgroundView];
		CGRect frame;
		frame.origin = CGPointZero;
		frame.size = self.trackBackgroundView.frame.size;
		frame.size.width += self.rightmostThumb.frame.size.width;
		self.frame = frame;
		
		self.activeAreaView.backgroundColor = [UIColor colorWithRed:(93.0/255.0) green:(177.0/255.0) blue:(255.0/255.0) alpha:0.5];
		[self addSubview:activeAreaView];
		self.activeAreaView.center = self.trackBackgroundView.centerOfBounds;
		
		[self addSubview:thumbOne];
		self.thumbOne.center = CGPointMake(self.thumbOne.frame.size.width/2, self.frame.size.height / 2);
		
		[self addSubview:thumbTwo];
		self.thumbTwo.center = CGPointMake(self.frame.size.width - self.thumbTwo.frame.size.width/2, self.frame.size.height / 2);
		
		self.value = FloatRangeMake(self.minimumValue, self.maximumValue);
    }
    return self;
}

-(void) createGestureRecognizers
{
	UIPanGestureRecognizer *pgr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
	[self.thumbOne addGestureRecognizer:pgr];
	[pgr release];
	
	pgr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
	[self.thumbTwo addGestureRecognizer:pgr];
	[pgr release];
}

-(void) handlePan:(UIPanGestureRecognizer *)recognizer
{
	SliderThumbView *sender = (SliderThumbView *)recognizer.view;
	if ((recognizer.state == UIGestureRecognizerStateChanged) ||
        (recognizer.state == UIGestureRecognizerStateEnded)) 
	{
        CGPoint translation = [recognizer translationInView:self];
		// New location before limitations
        CGFloat newXPoint = sender.center.x + translation.x;
		
		// Applying the limitations
        newXPoint = MIN(newXPoint , self.rightmostPointOnTrack);
        newXPoint = MAX(newXPoint , self.leftmostPointOnTrack);
		
		float relativePosition = (newXPoint - self.leftmostPointOnTrack) / (self.rightmostPointOnTrack - self.leftmostPointOnTrack);
		float value = (relativePosition * (self.maximumValue - self.minimumValue) + self.minimumValue);
		 
		[self setValue:value forThumb:sender];
		// Resetting
        [recognizer setTranslation:CGPointZero inView:self];
    }
}

-(void) updateSubviews
{
	self.activeAreaView.frame = CGRectMake(self.rightmostThumb.center.x, self.activeAreaView.frame.origin.y, self.leftmostThumb.center.x - self.rightmostThumb.center.x, self.activeAreaView.frame.size.height);
}

-(void) setTrackBackgroundImage : (UIImage *) image
{
	self.trackBackgroundView.image = image;
}

-(void) setThumbBackgroundImage : (UIImage *) image
{
	[self.thumbOne setBackgroundImage:image];
	[self.thumbTwo setBackgroundImage:image];
}

-(void) setActiveAreaBackgroundImage : (UIImage *) image
{
	self.activeAreaView.image = image;
}

- (void)dealloc
{
	[thumbOne release];
	[thumbTwo release];
	[trackBackgroundView release];
	[activeAreaView release];
    [super dealloc];
}

@end
