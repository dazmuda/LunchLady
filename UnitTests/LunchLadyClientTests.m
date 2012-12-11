#import "LLLunchLadyClient.h"

SPEC_BEGIN(LunchLadyClientTests)

describe(@"Lunch Lady Client", ^{
    
    __block LLLunchLadyClient *client;
    __block NSArray *visitedPlacesArray;
    __block NSArray *someResponse;
    __block NSArray *someOtherResponse;
    
    beforeAll(^{
        client = [LLLunchLadyClient sharedClient];
    });
    
    it(@"can create shared client", ^{
        [client shouldNotBeNil];
    });
    
    it(@"spits back response for a visited places request", ^{

        [client fetchVisitedPlacesWithBlock:^(NSArray *response) {
            visitedPlacesArray = response;
        }];
        
        [[expectFutureValue(visitedPlacesArray) shouldEventuallyBeforeTimingOutAfter(5.0)] beNonNil];
    });
    
    it(@"lets you post a place to the rails app (postPath: style)", ^{
        
        [client submitVisitedPlace:@"49ca7a59f964a520ae581fe3" withBlock:^(NSArray *response) {
            someResponse = response;
        }];
        
        [[expectFutureValue(someResponse) shouldEventuallyBeforeTimingOutAfter(5.0)] beNonNil];
        
    });
    
    it(@"lets you post a place to the rails app (manual request style)", ^{
        
        [client pushVisitedPlace:@"49ca7a59f964a520ae581fe3" withBlock:^(NSArray *response) {
            someOtherResponse = response;
        }];
        
        [[expectFutureValue(someOtherResponse) shouldEventuallyBeforeTimingOutAfter(5.0)] beNonNil];
        
    });
    
});

SPEC_END