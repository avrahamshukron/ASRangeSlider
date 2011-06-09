//
//  ASRangeSlider.h
//  ASRangeSlider
//
//  Created by Avraham Shukron on 5/29/11.
// .
//

#import <UIKit/UIKit.h>
#import "SliderThumbView.h"


/**
 *	This struct represents a range of floating-point values.
 *	I didn't use the NSRange since it can be used only with integers.
 */
typedef struct
{
	float min;
	float max;
}FloatRange;

/**
 *	Psuedo Constructor for FloatRange.
 */
FloatRange FloatRangeMake(float min , float max);

/**
 *	ASRangeSlider
 *	This class provides the functionality of a slider with two thumbs that the area between them represents selected range within 
 *	a given spectrum.
 */
@interface ASRangeSlider : UIControl
{
	@private
	UIImageView *trackBackgroundView;
	UIImageView *activeAreaView;
	SliderThumbView *thumbOne;
	SliderThumbView *thumbTwo;
	FloatRange spectrum;
}


/**
 * Default Constructor.
 *	Initialize the RangeSlider. 
 *		@param spectrum
 *		A FloatRange that represents the absolute range of the slider, means the minimum and maximum values that can be 
 *		contained inside the slider.
 */
-(id) initWithSpectrum : (FloatRange) spectrum;

-(void) setTrackBackgroundImage : (UIImage *) image;
-(void) setThumbBackgroundImage : (UIImage *) image;
-(void) setActiveAreaBackgroundImage : (UIImage *) image;

/**
 * Property spectrum
 *		A FloatRange that represents the absolute range of the slider, means the minimum and maximum values that can be 
 *		contained inside the slider.
 */
@property (nonatomic , readonly) FloatRange spectrum;

/**
 * Property trackBackgroundView
 *		A UIImageView that will be displayed as the track for the sliders.
 */
@property (nonatomic , retain , readonly) UIImageView *trackBackgroundView;

/**
 * Property activeAreaView
 *		A UIImageView that will be displayed on top of the track, but only in the area that is between the two thumbs of the sliders.
 *		This area visualize the selected range of the RangeSlider. 
 */
@property (nonatomic , retain , readonly) UIImageView *activeAreaView;

/**
 * Property rightmostThumb
 *		This property is readonly, and will return one of the two SliderThumbView objects that the RangeSlider contains.
 *		The thumb that will be returned is the one that at the moment of calling this method will be the rightmost one.
 *		You should not keep a reference to the result of this method because each one of the thumbs can be rightmost at any moment 
 *		depending only on the user's action.
 */
@property (nonatomic , readonly) SliderThumbView *rightmostThumb;

/**
 * Property leftmostThumb
 *		This property is readonly, and will return one of the two SliderThumbView objects that the RangeSlider contains.
 *		The thumb that will be returned is the one that at the moment of calling this method will be the leftmost one.
 *		You should not keep a reference to the result of this method because each one of the thumbs can be leftmost at any moment 
 *		depending only on the user's action.
 */
@property (nonatomic , readonly) SliderThumbView *leftmostThumb;

/**
 * Property minimumValue
 *		A float that represents the absolute minimum of the slider. 
 */
@property (nonatomic , readonly) float minimumValue;

/**
 * Property maximumValue
 *		A float that represents the absolute maximum of the slider. 
 */
@property (nonatomic , readonly) float maximumValue;

/**
 * Property value
 *		A FloatRange that represents the selected range within the spectrum of the slider. 
 *		The value is calculated by finding the relative location of each one of the thumbs on the track, and then multiplying it with
 *		with the spectrum width, and then adding the minimumValue to get the correct starting point.
 *		The ratio between the width of the activeArea  and the whole track  is the same ratio between the width of the value and the 
*		spectrum.	
 */
@property (nonatomic) FloatRange value;

@end