//
//  AppInfo.h
//  AppLister
//
//  Created by Matthew Burke on 11/12/14.
//  Copyright (c) 2014 BlueDino Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSApplicationProxy.h"

@interface AppInfo : NSObject


- (instancetype)initWithProxy:(LSApplicationProxy *)appProxy;
- (NSInteger)propertyCount;
- (id)objectAtIndexedSubscript:(NSInteger)idx;
- (id)objectForKeyedSubscript:(NSString *)key;


@end
