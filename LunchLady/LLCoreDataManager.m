//
//  LLCoreDataManager.m
//  LunchLady
//
//  Created by Mark Adams on 12/8/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "LLCoreDataManager.h"

@implementation LLCoreDataManager

#pragma mark - Getters

- (NSManagedObjectContext *)managedObjectContext
{
    if (!_managedObjectContext)
    {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    }

    return _managedObjectContext;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (!_persistentStoreCoordinator) {
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        NSURL *storeURL = [[[NSFileManager defaultManager] applicationDocumentsDirectory] URLByAppendingPathComponent:@"LunchLady.sqlite"];
        NSDictionary *options = (@{
                                 NSInferMappingModelAutomaticallyOption : @(YES),
                                 NSMigratePersistentStoresAutomaticallyOption : @(YES)
                                 });
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:nil]) return nil;
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (!_managedObjectModel)
        _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return _managedObjectModel;
}

@end
