#import "NSFileManager+DocumentsDirecotry.h"

SPEC_BEGIN(FileManagerCategoryTests)

describe(@"NSFileManager documents directory category", ^{

    context(@"-applicationDocumentsDirectory", ^{

        it(@"should return a valid directory", ^{
            NSURL *directoryURL = [[NSFileManager defaultManager] applicationDocumentsDirectory];
            [directoryURL shouldNotBeNil];
        });
        
    });

});

SPEC_END
