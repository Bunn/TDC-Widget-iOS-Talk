//
//  DataHandler.m
//  TDCWidget
//
//  Created by Fernando Bunn on 5/8/16.
//  Copyright © 2016 iDevzilla. All rights reserved.
//

#import "DataHandler.h"

#define APP_GROUP @"group.com.tdcwidget"
#define DATA_KEY @"data_key"

@implementation DataHandler

+ (void)updateDataWithArray:(NSArray *)array {
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:APP_GROUP];
    [shared setObject:array forKey:DATA_KEY];
    [shared synchronize];
}


+ (NSArray *)sharedData {
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:APP_GROUP];
    return [shared objectForKey:DATA_KEY];
}

@end
