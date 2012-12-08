//
//  LLLunchLadyClient.m
//  LunchLady
//
//  Created by Diana Zmuda on 12/7/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "LLLunchLadyClient.h"

@implementation LLLunchLadyClient

+ (LLLunchLadyClient *)sharedClient
{
    static LLLunchLadyClient *sharedClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[LLLunchLadyClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://lunchladyapp.herokuapp.com/"]];
    });
    
    return sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self)
        return nil;
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

- (void)fetchVisitedPlacesWithBlock:(LunchLadyClientBlock)block
{
    [self getPath:nil parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"LunchLadyClient failed get request with error: %@", error);
        block(nil);
    }];
}

@end
