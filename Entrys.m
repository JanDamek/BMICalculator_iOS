//
//  Entrys.m
//  BMI Calculator
//
//  Created by Jan Damek on 23.12.13.
//  Copyright (c) 2013 Jan Damek. All rights reserved.
//

#import "Entrys.h"
@interface Entrys () {
    NSDateFormatter *df;
}
@end

@implementation Entrys

@synthesize date;
@synthesize wheith;
@synthesize height;

#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad

-(id)init{
    self = [super init];
    
    df = [[NSDateFormatter alloc]init];
    if (IDIOM==IPAD){
        df.dateStyle = NSDateFormatterFullStyle;
    } else
        df.dateStyle = NSDateFormatterShortStyle;
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [self init];
    
    date = [aDecoder decodeObjectForKey:@"date"];
    wheith = [aDecoder decodeFloatForKey:@"weight"];
    height = [aDecoder decodeIntForKey:@"height"];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:date forKey:@"date"];
    [aCoder encodeFloat:wheith forKey:@"weight"];
    [aCoder encodeInt:height forKey:@"height"];
}

-(NSString *)dateString{
    return [df stringFromDate:date];
}

-(NSComparisonResult) compare:(Entrys*) other {
    NSComparisonResult cr = [self.date compare:other.date];
    return cr;
}


@end
