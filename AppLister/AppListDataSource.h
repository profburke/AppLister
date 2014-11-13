//
//  AppListDataSource.h
//  AppLister
//
//  Created by Matthew Burke on 11/12/14.
//  Copyright (c) 2014 BlueDino Software. Availble under the MIT License. See the file, LICENSE, for details.
//

#import <UIKit/UIKit.h>

@interface AppListDataSource : NSObject <UITableViewDataSource>

- (id)objectAtIndexedSubscript:(NSInteger)idx;

@end
