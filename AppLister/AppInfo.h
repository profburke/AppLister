//
//  AppInfo.h
//  AppLister
//
//  Created by Matthew Burke on 11/12/14.
//  Copyright (c) 2014-2015 BlueDino Software. Availble under the MIT License. See the file, LICENSE, for details.
//
// http://www.andreas-kurtz.de/2014/09/malicious-apps-ios8.html
//

#import <Foundation/Foundation.h>
#import "LSApplicationProxy.h"

@interface AppInfo : NSObject

@property (nonatomic, readonly) NSString *filterdata; // so we can build predicates for filtering
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *type;
@property (nonatomic, readonly) NSString *version;
@property (nonatomic, readonly) BOOL isUserApp;

- (instancetype)initWithProxy:(LSApplicationProxy *)appProxy;
- (NSInteger)propertyCount;
- (id)objectAtIndexedSubscript:(NSInteger)idx;
- (id)objectForKeyedSubscript:(NSString *)key;

@end
