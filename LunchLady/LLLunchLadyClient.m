//
//  LLLunchLadyClient.m
//  LunchLady
//
//  Created by Diana Zmuda on 12/7/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

static NSString *const kLunchladyURL = @"http://lunchladyapp.herokuapp.com/";

#import "LLLunchLadyClient.h"

@implementation LLLunchLadyClient

+ (LLLunchLadyClient *)sharedClient
{
    static LLLunchLadyClient *sharedClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[LLLunchLadyClient alloc] initWithBaseURL:[NSURL URLWithString:kLunchladyURL]];
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

- (void)submitVisitedPlace:(NSString *)ID withBlock:(LunchLadyClientBlock)block
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    
    NSDictionary *parameters = @{   @"foursquare_id" : ID,
                                    @"eaten_at" : dateString };

    [self postPath:@"locations" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Aww yiss you got a response: %@", responseObject);
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"LunchLadyClient failed post request with error: %@", error);
        block(nil);
    }];

}

- (void)pushVisitedPlace:(NSString *)ID withBlock:(LunchLadyClientBlock)block
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    
    NSMutableString *URLString = [kLunchladyURL mutableCopy];
    [URLString appendString:@"locations"];
    [URLString appendFormat:@"?foursquare_id=%@", ID];
    [URLString appendFormat:@"&eaten_at=%@", dateString];
    
    NSURL *URL = [NSURL URLWithString:URLString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:@"POST"];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            block(JSON);
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"LunchLadyClient failed post request: %@ with error: %@", URLString, error);
            block(nil);
        }];

    [self enqueueHTTPRequestOperation:operation];
}

@end
