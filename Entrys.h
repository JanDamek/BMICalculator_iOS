//
//  Entrys.h
//  BMI Calculator
//
//  Created by Jan Damek on 23.12.13.
//  Copyright (c) 2013 Jan Damek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Entrys : NSObject <NSCoding>

@property (nonatomic, retain) NSDate * date;
@property (nonatomic) float wheith;
@property (nonatomic) int height;

-(NSString*)dateString;

@end
