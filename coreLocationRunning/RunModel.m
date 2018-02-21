// Martha Wolnicki
// wolnicki@usc.edu
// ITP 342
// Bennett Lee
// Final Project: coreLocationRunning

#import "RunModel.h"


// interface
@interface RunModel()

@property (strong, nonatomic) NSMutableArray *runArray;
@property (strong, nonatomic) NSString* filepath;

@end



// implementation
@implementation RunModel

// public model
+ (instancetype) sharedModel {
    static RunModel *_sharedModel = nil;
    
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
              _sharedModel = [[self alloc] init];
              
    });
    
    
    
    
    
    /*
     if (_sharedModel == nil) {
     _sharedModel = [[self alloc] init];
     }
     */
    return _sharedModel;
}

// initialize values in the model - run objects
- (instancetype) init
{
    self = [super init];
    
    
    if (self) {
        
        // find the Documents directory
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = paths[0];
        
        NSLog(@"documentsDirectory");
        NSLog(@"docDir = %@", documentsDirectory);
        
        self.filepath = [documentsDirectory stringByAppendingPathComponent:@"runs.plist"];
        NSLog(@"filepath = %@", self.filepath);
        NSLog(@"file path");
        
        self.filepath = [paths objectAtIndex:0];
        
        NSArray *runDictionariesFromFile = [NSArray arrayWithContentsOfFile:self.filepath];
        
        
        if (runDictionariesFromFile.count == 0) { // file doesn't exist
            NSLog(@"Is this called?");
            
            // initial run objects - initialize the model
            Run *run1 = [[Run alloc] initRun:@"100"time:@"100s"];
            Run *run2 = [[Run alloc] initRun:@"200" time:@"200s"];
            Run *run3 = [[Run alloc] initRun:@"300"time:@"300s"];
            Run *run4 = [[Run alloc] initRun:@"400" time:@"400s"];
            Run *run5 = [[Run alloc] initRun:@"500" time:@"500s"];
            
            // put in the property
            _runArray = [[NSMutableArray alloc] initWithObjects:run1, run2, run3, run4, run5, nil];
            
            NSLog(@" stuff added ");
            
            for (int i = 0; i < _runArray.count; i++){
                Run *r = [_runArray objectAtIndex:i];
                //NSLog(@"PRINTING OUT ALL!!!!!!%@", r.distanceString);
            }
        }// end if
        
        
        // file exists
        
        else {
            _runArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary* runDictionary in runDictionariesFromFile) {
                Run *runObject = [[Run alloc] initRun: runDictionary[kDistanceKey] time: runDictionary[kTimeStringKey]];
                
                NSLog(@"At the beginning: %@", runObject.distanceString);
                
                [_runArray addObject: runObject];
            }
            
            for (int i = 0; i < _runArray.count; i++){
                Run *r = [_runArray objectAtIndex:i];
                NSLog(@"PRINTING OUT ALL!!!!!!%@", r.distanceString);
            }
        }// end else
        
    }// end if self
    return self;
}//end init method

// run at index
- (Run*) runAtIndex: (NSUInteger) index{
    if(_runArray.count ==0){
        return [[Run alloc] initRun:@"0" time: @"0"];
    }
    else{
        return [_runArray objectAtIndex:(int)index];
    }
}

// Inserting a run
- (void) insertRun: (NSString*) distanceString
              time: (NSString *) timeString{
    
    Run *newRun = [[Run alloc] initRun:distanceString
                                  time: timeString];
    [_runArray addObject:newRun ];
    
    [self save];
}

- (void) insertRun: (NSString*) distanceString
              time: (NSString *) timeString
           atIndex: (NSUInteger) index{
    // make sure index less than or equal to number of flashcards
    if (index <= [_runArray count]){
        Run *newRun = [[Run alloc] initRun:distanceString
                                      time: timeString];
        [_runArray insertObject:newRun atIndex: index];
    }
    
    [self save];
}



// remove
- (void) removeRun {
    [_runArray removeLastObject];
    [self save];
}

//remove run at index
- (void) removeRunAtIndex: (NSUInteger) index
{
    if (index < [_runArray count]){
        [_runArray removeObjectAtIndex: (int)index];
        [ self save];
    }
}


// save
- (void) save {
    NSMutableArray *arrayOfRunsToFile = [[NSMutableArray alloc] init];
    
    for (Run* singleRun in _runArray) {
        NSDictionary *runDictionary = [singleRun convertForPList];
        
        [arrayOfRunsToFile addObject: runDictionary];
    }
    [arrayOfRunsToFile writeToFile: self.filepath atomically:YES];
} //end save function


- (NSUInteger) numberOfRuns {
    return [_runArray count];
}

@end
