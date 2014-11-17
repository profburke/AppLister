//
//  AppListDataSource.m
//  AppLister
//
//  Created by Matthew Burke on 11/12/14.
//  Copyright (c) 2014 BlueDino Software. Availble under the MIT License. See the file, LICENSE, for details.
//

#import "AppListDataSource.h"
#import "AppInfo.h"


@interface AppListDataSource ()
@property (nonatomic, strong) NSArray *apps;
@property (nonatomic, strong) NSArray *filteredApps;
@property (nonatomic) BOOL searchActive;
@property (nonatomic, strong) NSString *searchText;
@property (nonatomic) enum SearchScope selectedScope;
@end



NSInteger nameSort(AppInfo *app1, AppInfo *app2, void *context)
{
    return [app1[@"localizedName"] caseInsensitiveCompare:app2[@"localizedName"]];
}





NSString *searchScopeEnumToText(enum SearchScope selectedScope)
{
    switch (selectedScope) {
        case SearchScopeSystem:
            return @"TYPE=System";
            break;
        case SearchScopeUser:
            return @"TYPE=User";
            break;
        default:
            return @" ";
            break;
    }

}




@implementation AppListDataSource


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
        
        self.searchActive = NO;
    }
    return self;
}




#pragma mark - Search Helpers


- (NSArray *)currentList
{
    NSArray *_currentList = self.apps;
    if (self.searchActive) {
        _currentList = self.filteredApps;
    }
    return _currentList;
}




- (void)updateFilteredApps
{
    self.searchActive = YES;
    
    NSString *scopeText = searchScopeEnumToText(self.selectedScope);

    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(filterdata CONTAINS[cd] %@) AND (filterdata CONTAINS %@)",
                         self.searchText,
                         scopeText];
    self.filteredApps = [self.apps filteredArrayUsingPredicate:pred];
    [self.tableView reloadData];
}




#pragma mark - UISearchControllerDelegate


- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    NSLog(@"%ld", (long)selectedScope);
    self.selectedScope = selectedScope;
    [self updateFilteredApps];
}




- (void)didDismissSearchController:(UISearchController *)searchController
{
    self.searchActive = NO;
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
    return [[self currentList] objectAtIndex:idx];
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
    static NSString *const CellIdentifier = @"AppCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    AppInfo *app = [[self currentList] objectAtIndex:[indexPath row]];
    cell.textLabel.text = app[@"localizedName"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (v%@)", app[@"applicationIdentifier"], app[@"shortVersionString"]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}



@end
