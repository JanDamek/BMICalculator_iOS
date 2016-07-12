//
//  comViewController.m
//  BMI Calculator
//
//  Created by Jan Damek on 23.12.13.
//  Copyright (c) 2013 Jan Damek. All rights reserved.
//
@import GoogleMobileAds;

#import "comViewController.h"
#import "Entrys.h"
#import "ServiceTools.h"

@interface comViewController (){
    CGRect originalPosition;
}

@property (weak, nonatomic) IBOutlet UIDatePicker *dateSelect;
@property (weak, nonatomic) IBOutlet UITextField *heightEdit;
@property (weak, nonatomic) IBOutlet UITextField *weightEdit;
@property (weak, nonatomic) IBOutlet UILabel *lblBMI;
@property (weak, nonatomic) IBOutlet UILabel *lblNumOfRecords;
@property (weak, nonatomic) IBOutlet GADBannerView *bannerView;

@property (strong, nonatomic, getter = getD)comAppDelegate *d;

-(comAppDelegate*)getD;

@end

@implementation comViewController

@synthesize dateSelect = _dateSelect;
@synthesize heightEdit = _heightEdit;
@synthesize weightEdit = _weightEdit;
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
    }
    
    [ServiceTools GADInitialization:_bannerView rootViewController:self];
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
    _lblNumOfRecords.text = [NSString stringWithFormat:@"%lu", (unsigned long)[self.d.data count]];
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
    
    if (newPosition>232){
        newPosition = 0 - (newPosition - 232);
    } else newPosition = 0;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    self.view.frame = CGRectMake(self.view.frame.origin.x,newPosition,self.view.frame.size.width,self.view.frame.size.height);
    [UIView commitAnimations];

    [self calckBMI];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    self.view.frame = originalPosition;
    [UIView commitAnimations];
    
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
    _lblBMI.text = [ServiceTools calcBMIfromWeight:_weightEdit.text height:_heightEdit.text];
}

@end
