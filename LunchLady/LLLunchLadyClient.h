//
//  LLLunchLadyClient.h
//  LunchLady
//
//  Created by Diana Zmuda on 12/7/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

typedef void (^LunchLadyClientBlock)(NSArray *response);

@interface LLLunchLadyClient : AFHTTPClient

+ (LLLunchLadyClient *)sharedClient;
- (void)fetchVisitedPlacesWithBlock:(LunchLadyClientBlock)block;
- (void)submitVisitedPlace:(NSString *)ID withBlock:(LunchLadyClientBlock)block;
- (void)pushVisitedPlace:(NSString *)ID withBlock:(LunchLadyClientBlock)block;

@end
