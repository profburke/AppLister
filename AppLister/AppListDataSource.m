//
//  AppListDataSource.m
//  AppLister
//
//  Created by Matthew Burke on 11/12/14.
//  Copyright (c) 2014 BlueDino Software. Availble under the MIT License. See the file, LICENSE, for details.
//

#import "AppListDataSource.h"
#import "AppInfo.h"


//TODO: accessibility


@interface AppListDataSource ()
@property (nonatomic, strong) NSDictionary *appsByCategory;
@property (nonatomic, strong) NSArray *inScopeApps;
@property (nonatomic, strong) NSArray *filteredApps;
@property (nonatomic, strong) NSString *searchText;
@property (nonatomic) enum SearchScope selectedScope;
@property (nonatomic) BOOL searchActive;
@end




static NSString *const ALLAPPS_KEY = @"allapps";
static NSString *const SYSTEMAPPS_KEY = @"System";
static NSString *const USERAPPS_KEY = @"User";




NSInteger nameSort(AppInfo *app1, AppInfo *app2, void *context)
{
    return [app1.name caseInsensitiveCompare:app2.name];
}




NSString *searchScopeEnumToKey(enum SearchScope selectedScope)
{
    switch (selectedScope) {
        case SearchScopeSystem:
            return SYSTEMAPPS_KEY;
            break;
            
        case SearchScopeUser:
            return USERAPPS_KEY;
            break;
            
        default:
            return ALLAPPS_KEY;
            break;
    }
}




@implementation AppListDataSource


- (NSArray *)fetchApps
{
    NSMutableArray *apps;
    Class LSApplicationWorkspace_class = NSClassFromString(@"LSApplicationWorkspace");
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    NSObject* workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
    apps = [workspace performSelector:@selector(allApplications)];
    
#pragma clang diagnostic pop
    
    return apps;
}




- (void)buildAppDictionary:(NSArray *)apps
{
    NSMutableDictionary *tempDictionary = [NSMutableDictionary dictionary];
    tempDictionary[ALLAPPS_KEY] = [NSMutableArray array];
    tempDictionary[SYSTEMAPPS_KEY] = [NSMutableArray array];
    tempDictionary[USERAPPS_KEY] = [NSMutableArray array];
    
    for (id app in apps) {
        AppInfo *appProxy = [[AppInfo alloc] initWithProxy:app];
        // TODO: what if category is not "User" or "System"?
        NSMutableArray *categoryList = tempDictionary[appProxy.type];
        [tempDictionary[ALLAPPS_KEY] addObject:appProxy];
        [categoryList addObject:appProxy];
    }
    
    self.appsByCategory = @{
                            ALLAPPS_KEY : [tempDictionary[ALLAPPS_KEY] sortedArrayUsingFunction:nameSort context:NULL],
                            SYSTEMAPPS_KEY : [tempDictionary[SYSTEMAPPS_KEY] sortedArrayUsingFunction:nameSort context:NULL],
                            USERAPPS_KEY : [tempDictionary[USERAPPS_KEY] sortedArrayUsingFunction:nameSort context:NULL]
                            };
    
}




- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *apps = [self fetchApps];
        
        [self buildAppDictionary: apps];
        
        self.inScopeApps = self.appsByCategory[ALLAPPS_KEY];
        self.searchActive = NO;
    }
    return self;
}




#pragma mark - Search Helpers


- (NSArray *)currentList
{
    NSArray *_currentList = self.inScopeApps;
    if (self.searchActive) {
        _currentList = self.filteredApps;
    }
    return _currentList;
}




- (void)updateFilteredApps
{
    self.searchActive = YES;
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"filterdata CONTAINS[cd] %@", self.searchText];
    self.filteredApps = [self.inScopeApps filteredArrayUsingPredicate:pred];
    [self.tableView reloadData];
}




#pragma mark - UISearchControllerDelegate


- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    NSLog(@"%ld", (long)selectedScope);
    self.selectedScope = selectedScope;
    self.inScopeApps = [self.appsByCategory objectForKey:searchScopeEnumToKey(self.selectedScope)];
    [self updateFilteredApps];
}




- (void)didDismissSearchController:(UISearchController *)searchController
{
    self.searchActive = NO;
    self.inScopeApps = [self.appsByCategory objectForKey:ALLAPPS_KEY];
    [self.tableView reloadData];
}




#pragma mark - UISearchResultsUpdating


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    self.searchText = searchController.searchBar.text;
    [self updateFilteredApps];
}




#pragma mark - Custom Subscripting


- (id)objectAtIndexedSubscript:(NSInteger)idx
{
    return [self currentList][idx];
}




#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self currentList].count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const CELL_IDENTIFIER = @"AppCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    
    AppInfo *app = [self currentList][indexPath.row];

    if (app.isUserApp) {
        cell.textLabel.textColor = [UIColor colorWithRed:0.6 green:0 blue:0 alpha:1.0];
    } else {
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    cell.textLabel.text = app.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (v%@)", app.type, app.version];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}



@end
