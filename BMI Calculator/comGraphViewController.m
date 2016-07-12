//
//  comGraphViewController.m
//  BMI Calculator
//
//  Created by Jan Damek on 26.12.13.
//  Copyright (c) 2013 Jan Damek. All rights reserved.
//

@import GoogleMobileAds;
@import Charts;

#import "comGraphViewController.h"
#import "ServiceTools.h"
#import "comAppDelegate.h"
#import "Entrys.h"

@interface comGraphViewController ()


@property (weak, nonatomic) IBOutlet GADBannerView *bannerView;
@property (weak, nonatomic) IBOutlet BarChartView *graphView;

@end

@implementation comGraphViewController

@synthesize bannerView = _bannerView;
@synthesize graphView = _graphView;

- (void)viewDidLoad
{
    [super viewDidLoad];

    [_graphView setData:[self getData]];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_graphView setNeedsDisplay];
    [ServiceTools GADInitialization:_bannerView rootViewController:self];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [_graphView setNeedsDisplay];
}

-(BarChartData*)getData{
    
    comAppDelegate *d = (comAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    int i = 0;
    NSMutableArray<BarChartDataEntry*>* points = [[NSMutableArray alloc]init];
    NSMutableArray<NSString*>* days = [[NSMutableArray alloc]init];
    for (Entrys *e in d.data) {
        BarChartDataEntry *point = [[BarChartDataEntry alloc] init];
        point.value = [[ServiceTools calcBMIfromWeightFloat:e.wheith heightInt:e.height] floatValue];
        point.xIndex = i++;
        
        [points addObject:point];
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"dd.mm yyyy HH:mm"];
        NSString *nsstr = [format stringFromDate:e.date];
        [days addObject:nsstr];
    }
    
    BarChartDataSet *bmis = [[BarChartDataSet alloc] initWithYVals:points label:@"BMI"];
    BarChartData *result = [[BarChartData alloc]initWithXVals:days dataSet:bmis];
    return result;
}

@end
