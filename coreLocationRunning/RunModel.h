// Martha Wolnicki
// wolnicki@usc.edu
// ITP 342
// Bennett Lee
// Final Project: coreLocationRunning

#import <Foundation/Foundation.h>
#import "Run.h"

@interface RunModel : NSObject


// Creating the model
+ (instancetype) sharedModel;

// Accessing number of runs in model
- (NSUInteger) numberOfRuns;


- (Run *) runAtIndex: (NSUInteger) index;

// Inserting a Run
- (void) insertRun: (NSString *) distanceString
              time: (NSString *) timeString;


- (void) insertRun:(NSString *)distanceString
              time:(NSString *)timeString
           atIndex: (NSUInteger) index;


// Removing a Run
- (void) removeRun;

- (void) removeRunAtIndex: (NSUInteger) index;

- (void) save;


@end
