//
//  comViewController.m
//  BMI Calculator
//
//  Created by Jan Damek on 23.12.13.
//  Copyright (c) 2013 Jan Damek. All rights reserved.
//

#import "comViewController.h"
#import "Entrys.h"

@interface comViewController (){
    CGRect originalPosition;
}

@property (weak, nonatomic) IBOutlet UIDatePicker *dateSelect;
@property (weak, nonatomic) IBOutlet UITextField *heightEdit;
@property (weak, nonatomic) IBOutlet UISlider *heightSlider;
@property (weak, nonatomic) IBOutlet UITextField *weightEdit;
@property (weak, nonatomic) IBOutlet UISlider *weightSlider;
@property (weak, nonatomic) IBOutlet UILabel *lblBMI;
@property (weak, nonatomic) IBOutlet UILabel *lblNumOfRecords;
@property (weak, nonatomic) IBOutlet UIView *bannerView;

@property (strong, nonatomic, getter = getD)comAppDelegate *d;

-(comAppDelegate*)getD;

@end

@implementation comViewController

@synthesize dateSelect = _dateSelect;
@synthesize heightEdit = _heightEdit;
@synthesize heightSlider = _heightSlider;
@synthesize weightEdit = _weightEdit;
@synthesize weightSlider = _weightSlider;
@synthesize lblBMI = _lblBMI;
@synthesize lblNumOfRecords = _lblNumOfRecords;
@synthesize bannerView = _bannerView;
@synthesize d = _d;

- (void)viewDidLoad
{
    [super viewDidLoad];
	Entrys *e = (Entrys*)[self.d.data lastObject];
    if (e){
        _heightEdit.text = [NSString stringWithFormat:@"%d", e.height ];
        _weightEdit.text = [NSString stringWithFormat:@"%.01f", e.wheith ];
        _heightSlider.value = [_heightEdit.text floatValue];
        _weightSlider.value = [_weightEdit.text floatValue];
    }

    [_bannerView addSubview:[comBannerView getBanerView:self]];
    
    [self.d isPortrait];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self showRecordCount];
    [self calckBMI];
}

- (IBAction)saveData:(UIButton *)sender {
    Entrys *e = [[Entrys alloc] init];
    e.height = [_heightEdit.text intValue];
    e.wheith = [_weightEdit.text floatValue];
    e.date = [_dateSelect date];
    [self.d.data addObject:e];
    [self showRecordCount];
    [self.d storeData];
    
    [self calckBMI];
}

-(void)showRecordCount{
    _lblNumOfRecords.text = [NSString stringWithFormat:@"%d", [self.d.data count]];
}

-(NSString*)getStringFromSlider:(UISlider*)sender{
    return [NSString stringWithFormat:@"%.f", sender.value];
}

- (IBAction)heightSliderValueChange:(UISlider *)sender {
    _heightEdit.text = [self getStringFromSlider:sender];
    [self calckBMI];
}

- (IBAction)weightSliderValueChange:(UISlider *)sender {
    _weightEdit.text = [self getStringFromSlider:sender];
    [self calckBMI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    originalPosition = self.view.frame;
    
    int newPosition = textField.frame.origin.y;
    
    if (newPosition>162){
        newPosition = 0 - (newPosition - 162);
    } else newPosition = 0;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    self.view.frame = CGRectMake(self.view.frame.origin.x,newPosition,self.view.frame.size.width,self.view.frame.size.height);
    [UIView commitAnimations];

    [self calckBMI];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    self.view.frame = originalPosition;
    [UIView commitAnimations];
    
    float intValue = [textField.text floatValue];
    if (textField == _heightEdit){
        _heightSlider.value = intValue;
    } else if (textField == _weightEdit){
        _weightSlider.value = intValue;
    }
    [self calckBMI];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}

-(comAppDelegate*)getD{
    if (!_d) {
      _d = (comAppDelegate*)[[UIApplication sharedApplication]delegate];
    }
    return  _d;
}

-(void) calckBMI{
    int heightInt = [_heightEdit.text intValue];
    float weight = [_weightEdit.text floatValue];
    float height = heightInt * 1.0;
    float bmi = (weight*weight) / height;
    _lblBMI.text = [NSString stringWithFormat:@"%.02f", bmi];
}

@end
