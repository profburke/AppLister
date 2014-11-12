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

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *version;
@property (nonatomic, readonly) NSString *applicationIdentifier;
@property (nonatomic, readonly) NSString *details;

- (instancetype)initWithProxy:(LSApplicationProxy *)appProxy;

@end
