//
//  LLFoursquareClient.m
//  LunchLady
//
//  Created by Diana Zmuda on 12/10/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

static NSString *kFoursquareToken = @"GWD2OZQABYJQP2FRBHDSWGK5BUULEZ2OFBOJH1H4NJH53Z5H";
static NSString *kFoursquareURL = @"https://api.foursquare.com/v2/venues/";
static NSString *kFoursquareVersion = @"20121210";

#import "LLFoursquareClient.h"

@interface LLFoursquareClient () <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation LLFoursquareClient

+ (LLFoursquareClient *)sharedClient
{
    static LLFoursquareClient *client = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[LLFoursquareClient alloc] initWithBaseURL:[NSURL URLWithString:kFoursquareURL]];
    });

    return client;
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

- (void)fetchPlaceForID:(NSString *)ID withBlock:(FoursquareClientBlock)block
{
    NSDictionary *parameters = @{   @"oauth_token" : kFoursquareToken,
                                    @"v" : kFoursquareVersion  };
    
    [self getPath:ID parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"FoursquareClient failed to get place info with error: %@", error);
        block(nil);
    }];
}

- (void)fetchPlacesAroundCurrentLocationWithBlock:(FoursquareClientBlock)block
{
    [self startUpdatingLocation];
    
    NSString *path = @"explore";
    NSDictionary *parameters = @{   @"ll" : [self currentLocationString],
                                    @"oauth_token" : kFoursquareToken,
                                    @"v" : kFoursquareVersion };
    
    [self getPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"FoursquareClient failed to get close places with error: %@", error);
        block(nil);
    }];
}

- (void)grabPlaceForID:(NSString *)ID withBlock:(FoursquareClientBlock)block
{
    NSMutableString *URLString = [kFoursquareURL mutableCopy];
    [URLString appendString:ID];
    [URLString appendFormat:@"?oauth_token=%@", kFoursquareToken];
    [URLString appendFormat:@"&v=%@", kFoursquareVersion];
    
    [self submitRequestWithURL:URLString andBlock:block];
}


- (void)grabPlacesAroundCurrentLocationWithBlock:(FoursquareClientBlock)block
{
    [self startUpdatingLocation];
    
    NSMutableString *URLString = [kFoursquareURL mutableCopy];
    [URLString appendString:@"/explore"];
    [URLString appendFormat:@"?ll=%@", [self currentLocationString]];
    [URLString appendFormat:@"&oauth_token=%@", kFoursquareToken];
    [URLString appendFormat:@"&v=%@", kFoursquareVersion];
    
    [self submitRequestWithURL:URLString andBlock:block];
}

- (void)submitRequestWithURL:(NSMutableString *)URLString andBlock:(FoursquareClientBlock)block
{
    NSURL *URL = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        block(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"FoursquareClient failed request: %@ with error: %@", URLString, error);
        block(nil);
    }];
    
    [self enqueueHTTPRequestOperation:operation];
}

- (void)startUpdatingLocation
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 60;
    self.locationManager.desiredAccuracy = 40;
    [self.locationManager startUpdatingLocation];
}

- (NSString *)currentLocationString
{
    CLLocationCoordinate2D currentLocation = self.locationManager.location.coordinate;
    double latitudeDouble = currentLocation.latitude;
    double longitudeDouble = currentLocation.longitude;
    return [NSString stringWithFormat:@"%f,%f", latitudeDouble, longitudeDouble];
}

@end
