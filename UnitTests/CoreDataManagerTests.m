#import "LLCoreDataManager.h"

SPEC_BEGIN(CoreDataManagerTests)

describe(@"Core Data Manager", ^{

    context(@"when newly created", ^{

        __block LLCoreDataManager *coreDataManager = nil;
        
        beforeAll(^{
            coreDataManager = [[LLCoreDataManager alloc] init];
        });

        it(@"should not be nil", ^{
            [coreDataManager shouldNotBeNil];
        });

        it(@"should have a managed object context", ^{
            [coreDataManager.managedObjectContext shouldNotBeNil];
        });

        it(@"should have a persistent store coordinator", ^{
            [coreDataManager.persistentStoreCoordinator shouldNotBeNil];
        });

        it(@"should have a managed object model", ^{
            [coreDataManager.managedObjectModel shouldNotBeNil];
        });

        it(@"should have at least one persistent store", ^{
            NSArray *persistentStores = coreDataManager.persistentStoreCoordinator.persistentStores;
            [[theValue(persistentStores.count) should] beGreaterThan:theValue(0)];
        });

        it(@"should have a maanged object context that uses the persistent store coordinator", ^{
            [[coreDataManager.managedObjectContext.persistentStoreCoordinator should] equal:coreDataManager.persistentStoreCoordinator];
        });

        it(@"should have a persistent store coordinator that uses the managed object model", ^{
            [[coreDataManager.persistentStoreCoordinator.managedObjectModel should] equal:coreDataManager.managedObjectModel];
        });

    });

});

SPEC_END
