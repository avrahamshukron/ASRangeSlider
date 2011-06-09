//
//  ASRangeSliderViewController.m
//  ASRangeSlider
//
//  Created by Avraham Shukron on 6/9/11.
// .
//

#import "ASRangeSliderViewController.h"
#import "ASRangeSlider.h"


@interface ASRangeSliderViewController()
-(void) createSliders;
-(void) updateSlider1Labels;
-(void) updateSlider2Labels;
-(void) updateSlider3Labels;
@end

@implementation ASRangeSliderViewController

@synthesize slider1;
@synthesize slider2;
@synthesize slider3;

@synthesize slider1Placeholder;
@synthesize slider2Placeholder;
@synthesize slider3Placeholder;

- (void)dealloc
{
    [super dealloc];
	[slider3Placeholder release];
	[slider2Placeholder release];
	[slider1Placeholder release];
	
	[slider1 release];
	[slider2 release];
	[slider3 release];
}

#pragma mark - View lifecycle

-(void) createSliders
{
	CGRect frame;
	frame.origin = CGPointZero;
	
	slider1 = [[ASRangeSlider alloc] initWithSpectrum:FloatRangeMake(0.0, 5.0)];
	[self.slider1 setThumbBackgroundImage:[UIImage imageNamed:@"slider-handle.png"]];
	frame.size = self.slider1Placeholder.frame.size;
	self.slider1.frame = frame;
	
	[self.slider1Placeholder addSubview:self.slider1];
	//[self.slider1 addTarget:self action:@selector(slider1ValueChanged:) forControlEvents:UIControlEventValueChanged];
	self.slider1.value=FloatRangeMake(1.0, 3.9);
    
    
	slider2 = [[ASRangeSlider alloc] initWithSpectrum:FloatRangeMake(0.0, 20.0)];
	[self.slider2 setThumbBackgroundImage:[UIImage imageNamed:@"glass-round-red-green-button.png"]];
	frame.size =self.slider2Placeholder.frame.size;
	self.slider2.frame = frame;
	self.slider2.activeAreaView.backgroundColor = [UIColor colorWithRed:(180.0/256.0) green:(24.0/256.0) blue:(34.0/256.0) alpha:0.5];
    [self.slider2Placeholder addSubview:self.slider2];
	[self.slider2 addTarget:self action:@selector(slider2ValueChanged:) forControlEvents:UIControlEventValueChanged];
	self.slider2.value=FloatRangeMake(5, 15);
    
    
	slider3 = [[ASRangeSlider alloc] initWithSpectrum:FloatRangeMake(1.0,10.0)];
	[self.slider3 setThumbBackgroundImage:[UIImage imageNamed:@"blank-button-round-blue.png"]];
	frame.size =self.slider3Placeholder.frame.size;
	self.slider3.frame = frame;
	[self.slider3Placeholder addSubview:self.slider3];
	[self.slider3 addTarget:self action:@selector(slider3ValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.slider3.value = FloatRangeMake(1.0, 10.0);
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	[self createSliders];
	[self updateSlider1Labels];
	[self updateSlider2Labels];
	[self updateSlider3Labels];
}


-(IBAction) slider2ValueChanged : (id) sender
{
	[self updateSlider2Labels];
}

-(IBAction) slider1ValueChanged : (id) sender
{ 
	[self updateSlider1Labels];
}

-(IBAction) slider3ValueChanged : (id) sender
{   
	[self updateSlider3Labels];
}

-(void) updateSlider3Labels
{
	FloatRange r = self.slider3.value;
	self.slider3.rightmostThumb.textLabel.text = [NSString stringWithFormat:@"%.2f", r.max];
    self.slider3.leftmostThumb.textLabel.text = [NSString stringWithFormat:@"%.2f",r.min];
}

-(void) updateSlider2Labels
{
	FloatRange r = self.slider2.value;
    self.slider2.leftmostThumb.textLabel.text = [NSString stringWithFormat:@"%.2f", r.min];
	self.slider2.rightmostThumb.textLabel.text = [NSString stringWithFormat:@"%.2f", r.max];

}

-(void) updateSlider1Labels
{
	FloatRange r = self.slider1.value;
    self.slider1.leftmostThumb.textLabel.text = [NSString stringWithFormat:@"%.2f", r.min];
	self.slider1.rightmostThumb.textLabel.text = [NSString stringWithFormat:@"%.2f", r.max];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
	self.slider3 = nil;
	self.slider2 = nil;
	self.slider1 = nil;
	
	self.slider1Placeholder = nil;
	self.slider2Placeholder = nil;
	self.slider3Placeholder = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
