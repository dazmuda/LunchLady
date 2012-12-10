//
//  LLAppDelegate.m
//  LunchLady
//
//  Created by Diana Zmuda on 12/7/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "LLAppDelegate.h"
#import "LLCoreDataManager.h"

@interface LLAppDelegate ()

@property (strong, nonatomic) LLCoreDataManager *coreDataManager;

@end

@implementation LLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.coreDataManager = [[LLCoreDataManager alloc] init];
    
    return YES;
}

@end
