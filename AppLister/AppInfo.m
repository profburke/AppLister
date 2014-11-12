//
//  AppInfo.m
//  AppLister
//
//  Created by Matthew Burke on 11/12/14.
//  Copyright (c) 2014 BlueDino Software. All rights reserved.
//

#import "AppInfo.h"

@interface AppInfo ()
@property (nonatomic, strong, readwrite) id appProxy;
@end



@implementation AppInfo


- (instancetype)initWithProxy:(id)appProxy
{
    self = [super init];
    if (self) {
        self.appProxy = appProxy;
    }
    return self;
}




- (NSString *)name
{
    NSString *appIdentifier = [self.appProxy performSelector:@selector(applicationIdentifier)];
    return [[appIdentifier componentsSeparatedByString:@"."] lastObject];
}


@end
