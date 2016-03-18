//
//  comGraphViewController.m
//  BMI Calculator
//
//  Created by Jan Damek on 26.12.13.
//  Copyright (c) 2013 Jan Damek. All rights reserved.
//

#import "comGraphViewController.h"
#import "ECGraph.h"
#import "DisplayView.h"

@interface comGraphViewController ()

@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet DisplayView *graphView;

@end

@implementation comGraphViewController

@synthesize bannerView = _bannerView;
@synthesize graphView = _graphView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.canDisplayBannerAds = true;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_graphView setNeedsDisplay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [_graphView setNeedsDisplay];
}

@end
