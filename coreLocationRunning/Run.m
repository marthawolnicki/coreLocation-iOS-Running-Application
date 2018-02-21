// Martha Wolnicki
// wolnicki@usc.edu
// ITP 342
// Bennett Lee
// Final Project: coreLocationRunning

#import "Run.h"

@implementation Run


// initialization run object
- (instancetype) initRun: (NSString *) distanceString
                    time: (NSString *) timeString
{
    self = [super init];
    
    if (self){
        _distanceString = distanceString;
        _timeString = timeString;
    }
    
    return self;
}

// convert for plist - run object
- (NSDictionary *) convertForPList {
    NSDictionary *runDictionary =
    [NSDictionary dictionaryWithObjectsAndKeys:
     _timeString, kTimeStringKey,
     _distanceString, kDistanceKey, nil];
    return runDictionary;
}
@end
