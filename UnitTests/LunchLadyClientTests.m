#import "Kiwi.h"
#import "LLLunchLadyClient.h"

SPEC_BEGIN(LunchLadyClientTests)

describe(@"Lunch Lady Client", ^{
    
    __block LLLunchLadyClient *client;
    
    beforeAll(^{
        client = [LLLunchLadyClient sharedClient];
    });
    
    it(@"can create shared client", ^{
        [client shouldNotBeNil];
    });
    
    it(@"spits back response for a visited places request", ^{
        __block NSArray *visitedPlacesArray = nil;
        
        [client fetchVisitedPlacesWithBlock:^(NSArray *response) {
            visitedPlacesArray = response;
        }];
        
        [[expectFutureValue(visitedPlacesArray) shouldEventuallyBeforeTimingOutAfter(30.0)] beNonNil];
    });
    
});

SPEC_END