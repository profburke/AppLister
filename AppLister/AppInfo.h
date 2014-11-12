//
//  AppInfo.h
//  AppLister
//
//  Created by Matthew Burke on 11/12/14.
//  Copyright (c) 2014 BlueDino Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppInfo : NSObject

@property (nonatomic, readonly) NSString *name;

- (instancetype)initWithProxy:(id)appProxy;

@end
