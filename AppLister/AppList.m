//
//  AppList.m
//  AppLister
//
//  Created by Matthew Burke on 11/12/14.
//  Copyright (c) 2014 BlueDino Software. All rights reserved.
//

#import "AppList.h"
#import "AppInfo.h"


@interface AppList ()
@property (nonatomic, strong) NSArray *apps;
@end


NSInteger nameSort(AppInfo *app1, AppInfo *app2, void *context)
{
    return [app1[@"localizedName"] caseInsensitiveCompare:app2[@"localizedName"]];
}




@implementation AppList


- (instancetype)init
{
    self = [super init];
    if (self) {
        Class LSApplicationWorkspace_class = NSClassFromString(@"LSApplicationWorkspace");

        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wundeclared-selector"

        NSObject* workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
        NSArray *appProxies = [workspace performSelector:@selector(allApplications)];
        
        #pragma clang diagnostic pop

        NSMutableArray *tempList = [NSMutableArray array];
        for (id app in appProxies) {
            [tempList addObject:[[AppInfo alloc] initWithProxy:app]];
        }
        
        self.apps = [tempList sortedArrayUsingFunction:nameSort context:NULL];
    }
    return self;
}




#pragma mark - Custom Subscripting


- (id)objectAtIndexedSubscript:(NSInteger)idx
{
    return [self.apps objectAtIndex:idx];
}




#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.apps.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const CellIdentifier = @"AppCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    AppInfo *app = [self.apps objectAtIndex:[indexPath row]];
    cell.textLabel.text = app[@"localizedName"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (v%@)", app[@"applicationIdentifier"], app[@"shortVersionString"]];
    
    return cell;
}



@end
