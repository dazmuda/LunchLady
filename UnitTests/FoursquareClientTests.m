#import "LLFoursquareClient.h"

SPEC_BEGIN(FoursquareClientTests)

describe(@"Foursquare Client", ^{
    
    __block LLFoursquareClient *client;
    __block NSDictionary *singlePlaceResponse;
    __block NSDictionary *closePlacesResponse;
    
    beforeAll(^{
        client = [LLFoursquareClient sharedClient];
    });
    
    it(@"can return a shared client", ^{
        [client shouldNotBeNil];
    });
    
    it(@"can return FS info with a FS ID", ^{
        
        [client fetchPlaceForID:@"45603082f964a520973d1fe3" withBlock:^(NSDictionary *response) {
            singlePlaceResponse = response;
        }];
        [[expectFutureValue(singlePlaceResponse) shouldEventuallyBeforeTimingOutAfter(10)] beNonNil];
    });
    
    it(@"can return places that are close to a certain location", ^{
        [client fetchPlacesAroundCurrentLocationWithBlock:^(NSDictionary *response) {
            closePlacesResponse = response;
        }];
        [[expectFutureValue(closePlacesResponse) shouldEventuallyBeforeTimingOutAfter(10)] beNonNil];
    });
    
    it(@"can grab FS info with a FS ID", ^{
        
        [client grabPlaceForID:@"45603082f964a520973d1fe3" withBlock:^(NSDictionary *response) {
            singlePlaceResponse = response;
        }];
        [[expectFutureValue(singlePlaceResponse) shouldEventuallyBeforeTimingOutAfter(10)] beNonNil];
    });
    
    it(@"can return places that are close to a certain location", ^{
        [client grabPlacesAroundCurrentLocationWithBlock:^(NSDictionary *response) {
            closePlacesResponse = response;
        }];
        [[expectFutureValue(closePlacesResponse) shouldEventuallyBeforeTimingOutAfter(10)] beNonNil];
    });
    
});

SPEC_END