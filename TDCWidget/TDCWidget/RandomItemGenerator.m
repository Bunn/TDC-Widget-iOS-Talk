//
//  RandomItemGenerator.m
//  TDCWidget
//
//  Created by Fernando Bunn on 5/8/16.
//  Copyright © 2016 iDevzilla. All rights reserved.
//

#import "RandomItemGenerator.h"

@implementation RandomItemGenerator

+ (NSString *)newItem {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Items" ofType:@"plist"];
    NSArray *list = [NSArray arrayWithContentsOfFile:plistPath];
    
    NSInteger randomIndex = arc4random_uniform((uint32_t)list.count);
    return [list objectAtIndex:randomIndex];
}

@end
