//
//  AppInfo.m
//  AppLister
//
//  Created by Matthew Burke on 11/12/14.
//  Copyright (c) 2014 BlueDino Software. All rights reserved.
//

#import "AppInfo.h"


@interface AppInfo ()
@property (nonatomic, strong, readwrite) LSApplicationProxy *appProxy;
@end




@implementation AppInfo


- (instancetype)initWithProxy:(LSApplicationProxy *)appProxy
{
    self = [super init];
    if (self) {
        self.appProxy = appProxy;
    }
    return self;
}




- (NSString *)name
{
    return self.appProxy.localizedName;
}




- (NSString *)version
{
    return self.appProxy.shortVersionString;
}




- (NSString *)applicationIdentifier
{
    return self.appProxy.applicationIdentifier;
}




// TODO: Improve the formatting of this information
- (NSString *)details
{
    NSArray *propertyNames = @[@"applicationIdentifier", @"applicationDSID",
                               @"applicationType", @"bundleVersion", @"itemName", @"minimumSystemVersion",
                               @"roleIdentifier", @"sdkVersion", @"shortVersionString", @"storeCohortMetadata",
                               @"teamID", @"vendorName", @"dynamicDiskUsage", @"itemID", @"staticDiskUsage", @"storeFront",
                               @"appStoreReceiptURL", @"bundleContainerURL", @"bundleExecutable", @"bundleIdentifier",
                               @"bundleType", @"bundleURL", @"bundleVersion", @"containerURL", @"dataContainerURL",
                               @"localizedShortName", @"signerIdentity",
                               @"localizedName"
                               ];

    NSMutableArray *properties = [NSMutableArray array];
    for (NSString *prop in propertyNames) {
        [properties addObject:[NSString stringWithFormat:@"%@:\t%@", prop, [self.appProxy valueForKey:prop]]];
    }
    return [properties componentsJoinedByString:@"\n"];
}




@end
