//
//  AppList.h
//  AppLister
//
//  Created by Matthew Burke on 11/12/14.
//  Copyright (c) 2014 BlueDino Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppList : NSObject <UITableViewDataSource>

- (id)objectAtIndexedSubscript:(NSInteger)idx;

+ (NSString *)cellIdentifier;

@end
