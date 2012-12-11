//
//  LLFoursquareClient.h
//  LunchLady
//
//  Created by Diana Zmuda on 12/10/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

typedef void(^FoursquareClientBlock)(NSDictionary *response);

@interface LLFoursquareClient : AFHTTPClient

+ (LLFoursquareClient *)sharedClient;

- (void)fetchPlaceForID:(NSString *)ID withBlock:(FoursquareClientBlock)block;
- (void)fetchPlacesAroundCurrentLocationWithBlock:(FoursquareClientBlock)block;

- (void)grabPlaceForID:(NSString *)ID withBlock:(FoursquareClientBlock)block;
- (void)grabPlacesAroundCurrentLocationWithBlock:(FoursquareClientBlock)block;

@end
