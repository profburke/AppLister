//
//  AppInfo.h
//  AppLister
//
//  Created by Matthew Burke on 11/12/14.
//  Copyright (c) 2014 BlueDino Software. Availble under the MIT License. See the file, LICENSE, for details.
//

#import <Foundation/Foundation.h>
#import "LSApplicationProxy.h"

@interface AppInfo : NSObject


- (instancetype)initWithProxy:(LSApplicationProxy *)appProxy;
- (NSInteger)propertyCount;
- (id)objectAtIndexedSubscript:(NSInteger)idx;
- (id)objectForKeyedSubscript:(NSString *)key;


@end
