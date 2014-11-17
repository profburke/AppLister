//
//  AppInfo.h
//  AppLister
//
//  Created by Matthew Burke on 11/12/14.
//  Copyright (c) 2014 BlueDino Software. Availble under the MIT License. See the file, LICENSE, for details.
//
// http://www.andreas-kurtz.de/2014/09/malicious-apps-ios8.html
//

#import <Foundation/Foundation.h>
#import "LSApplicationProxy.h"

@interface AppInfo : NSObject

@property (nonatomic, readonly) NSString *filterdata; // so we can build predicates for filtering

- (instancetype)initWithProxy:(LSApplicationProxy *)appProxy;
- (NSInteger)propertyCount;
- (id)objectAtIndexedSubscript:(NSInteger)idx;
- (id)objectForKeyedSubscript:(NSString *)key;


@end
