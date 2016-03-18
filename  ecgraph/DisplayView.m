//
//  DisplayView.m
//  ECGraphic
//
//  Created by ris on 10-4-17.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DisplayView.h"
#import "ECCommon.h"
#import "ECGraphPoint.h"
#import "ECGraphLine.h"
#import "ECGraphItem.h"
#import "comAppDelegate.h"
#import "Entrys.h"

@interface DisplayView ()

@end

@implementation DisplayView

-(NSArray*)getData{
	
    comAppDelegate *d = (comAppDelegate*)[[UIApplication sharedApplication]delegate];
	
	NSMutableArray *points1 = [[NSMutableArray alloc] init];
    for (Entrys *e in d.data) {
        ECGraphPoint *point = [[ECGraphPoint alloc] init];
        point.yValue = [e bmi];
        point.xDateValue = e.date;
        
        [points1 addObject:point];
    }
    
	ECGraphLine *line1 = [[ECGraphLine alloc] init];
	line1.isXDate = YES;
	line1.points = points1;
	//line1.color = [UIColor blackColor];
	line1.defaultColor = 2;
	
	return @[line1];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    comAppDelegate *d = (comAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    CGRect cr;
//    if([d isIPad]){
//        if ([d isPortrait]){
//            cr = CGRectMake(20, -340, rect.size.width-20, rect.size.height-50);
//        } else
//            cr = CGRectMake(20, -270, rect.size.width-20, rect.size.height-40);
//    }else
    if (rect.size.height<450){
        cr = CGRectMake(0, 125, rect.size.width, rect.size.height-30);
    } else if (rect.size.height<700){
        cr = CGRectMake(0, 45, rect.size.width, rect.size.height-30);
    } else if (rect.size.height<960){
        cr = CGRectMake(0, -350, rect.size.width, rect.size.height-50);
    } else
        cr = CGRectMake(0, -450, rect.size.width, rect.size.height-50);

    //366 = 125
    //454 = 45
    //518 = 45
    
    //960 = -125
    
    
    CGContextRef _context = UIGraphicsGetCurrentContext();
    
    ECGraph *graph = [[ECGraph alloc] initWithFrame:cr withContext:_context isPortrait:[d isPortrait]];

        [graph setXaxisTitle:NSLocalizedString(@"Date", nil)];
        [graph setYaxisTitle:NSLocalizedString(@"BMI", nil)];
        [graph setGraphicTitle:NSLocalizedString(@"BMI Graph",nil)];
        [graph setXaxisDateFormat:@"dd-YYYY"];
        [graph setDelegate:self];
        [graph setBackgroundColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1]];
        [graph setPointType:ECGraphPointTypeSquare];

	[graph drawCurveWithLines:[self getData] lineWidth:2 color:[UIColor blackColor]];
}


@end
