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


#define PROP(a) \
    [self.appProxy performSelector:@selector(a)]


static NSString *const template = @"%@\nVersion:\t%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@";




@implementation AppInfo


- (instancetype)initWithProxy:(id)appProxy
{
    self = [super init];
    if (self) {
        self.appProxy = appProxy;
    }
    return self;
}




#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"


- (NSString *)name
{
    return PROP(localizedName);
}




- (NSString *)version
{
    return PROP(shortVersionString);
}




- (NSString *)applicationIdentifier
{
    return PROP(applicationIdentifier);
}




- (NSString *)details
{
    return [NSString stringWithFormat:template,
            self.applicationIdentifier,
            self.version,
            PROP(applicationDSID),
            PROP(applicationType),
            PROP(bundleVersion),
            PROP(itemName),
            PROP(minimumSystemVersion),
            PROP(roleIdentifier),
            PROP(sdkVersion),
            PROP(shortVersionString),
            PROP(storeCohortMetadata),
            PROP(teamID),
            PROP(vendorName)];
}


#pragma clang diagnostic pop


@end
