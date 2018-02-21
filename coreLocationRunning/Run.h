// Martha Wolnicki
// wolnicki@usc.edu
// ITP 342
// Bennett Lee
// Final Project: coreLocationRunning

#import <Foundation/Foundation.h>

// constants declared outside inteface
// keys to access elements of run dictionary - run object stored as dictionary in plist
static NSString* kDistanceKey=@"distanceStringKey";
static NSString* const kTimeStringKey = @"timeStringKey";


@interface Run : NSObject

//distanceString
@property (strong, nonatomic) NSString *distanceString;

// timeString
@property (strong, nonatomic) NSString *timeString;


// public method - initialization run object
- (instancetype) initRun: (NSString*) distance
                    time: (NSString *) timeString;


// convert for p list file
- (NSDictionary *) convertForPList;



@end
