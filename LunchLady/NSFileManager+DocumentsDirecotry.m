//
//  NSFileManager+DocumentsDirecotry.m
//  LunchLady
//
//  Created by Mark Adams on 12/8/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "NSFileManager+DocumentsDirecotry.h"

@implementation NSFileManager (DocumentsDirecotry)

- (NSURL *)applicationDocumentsDirectory
{
    return [[self URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
