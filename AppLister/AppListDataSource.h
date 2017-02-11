//
//  AppListDataSource.h
//  AppLister
//
//  Created by Matthew Burke on 11/12/14.
//  Copyright (c) 2014-2017 BlueDino Software. Availble under the MIT License. See the file, LICENSE, for details.
//

#import <UIKit/UIKit.h>

NS_ENUM(NSInteger, SearchScope) {
    SearchScopeAll = 0,
    SearchScopeSystem,
    SearchScopeUser
};

@interface AppListDataSource : NSObject <UITableViewDataSource, UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate>

@property (nonatomic, weak) UITableView *tableView;
- (id)objectAtIndexedSubscript:(NSInteger)idx;
- (void)openApp:(NSString *)bundleID;

@end
