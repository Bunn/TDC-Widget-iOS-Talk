//
//  DataHandler.h
//  TDCWidget
//
//  Created by Fernando Bunn on 5/8/16.
//  Copyright © 2016 iDevzilla. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataHandler : NSObject

+ (void)updateDataWithArray:(NSArray *)array;
+ (NSArray *)sharedData;

@end
