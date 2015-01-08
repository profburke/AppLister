//
//  AppInfo.m
//  AppLister
//
//  Created by Matthew Burke on 11/12/14.
//  Copyright (c) 2014 BlueDino Software. Availble under the MIT License. See the file, LICENSE, for details.
//

#import "AppInfo.h"



@interface AppInfo ()
@property (nonatomic, strong, readwrite) LSApplicationProxy *appProxy;
@end


static NSArray *propertyNames;
static NSString *const NAME_KEY = @"localizedName";
static NSString *const APPID_KEY = @"applicationIdentifier";
static NSString *const TYPE_KEY = @"applicationType";
static NSString *const VERSION_KEY = @"shortVersionString";


@implementation AppInfo


- (instancetype)initWithProxy:(LSApplicationProxy *)appProxy
{
    self = [super init];
    if (self) {
        self.appProxy = appProxy;
    }
    return self;
}




- (NSInteger)propertyCount
{
    return propertyNames.count;
}




- (NSString *)filterdata
{
    NSString *_filterData = [NSString stringWithFormat:@"%@ %@",
                             [self objectForKeyedSubscript:NAME_KEY],
                             [self objectForKeyedSubscript:APPID_KEY]];
    return _filterData;
}




- (NSString *)name
{
    return self[NAME_KEY];
}




- (NSString *)type
{
    return self[TYPE_KEY];
}




- (NSString *)version
{
    return self[VERSION_KEY];
}




- (BOOL)isUserApp
{
    return ([self.type isEqualToString:@"User"]);
}




#pragma mark - Custom Subscripting


- (id)objectAtIndexedSubscript:(NSInteger)idx
{
    return propertyNames[idx];
}




- (id)objectForKeyedSubscript:(NSString *)key
{
    NSString *description = [[self.appProxy valueForKey:key] description];
    if (!description) {
        description = @"(null)";
    }
    return description;
}




#pragma mark - Class Methods


// TODO: build this list dynamically using class_copyPropertyList
// and walking up the inheritence tree.
// TODO: expand to include additional types of properties (below
// is just NSString and NSNumber).
+ (void)initialize
{
    propertyNames = @[@"applicationIdentifier", @"applicationDSID",
                      @"applicationType", @"bundleVersion", @"itemName", @"minimumSystemVersion",
                      @"roleIdentifier", @"sdkVersion", @"shortVersionString", @"storeCohortMetadata",
                      @"teamID", @"vendorName", @"dynamicDiskUsage", @"itemID", @"staticDiskUsage", @"storeFront",
                      @"appStoreReceiptURL", @"bundleContainerURL", @"bundleExecutable", @"bundleIdentifier",
                      @"bundleType", @"bundleURL", @"bundleVersion", @"containerURL", @"dataContainerURL",
                      @"localizedShortName", @"signerIdentity",
                      @"localizedName"
                      ];

}


@end
