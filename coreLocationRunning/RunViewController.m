// Martha Wolnicki
// wolnicki@usc.edu
// ITP 342
// Bennett Lee
// Final Project: coreLocationRunning

#import "RunViewController.h"
#import "AddViewController.h"
#import "Run.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
#import "RunModel.h"


// interface
@interface RunViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

//model - singleton model
@property (strong, nonatomic) RunModel* model;

// location
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *startPoint;
@property (assign, nonatomic) CLLocationDistance distanceFromStart;
@property (strong, nonatomic) CLLocation *location;
@property(strong, nonatomic) NSMutableArray <CLLocation *>* locations;

// map view
@property (strong, nonatomic) IBOutlet MKMapView *mapView;


// time label
//@property (strong, nonatomic) IBOutlet UILabel *timeLabel;


// time
@property NSDate *startTime;
@property NSDate *stopTime;


//@property (strong, nonatomic) IBOutlet UIButton *startButton;

// bool flag
@property BOOL didUpdateStartLocation;

@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;


@property (strong, nonatomic) IBOutlet UIButton *stopButton;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@end


// implementation
@implementation RunViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _didUpdateStartLocation = false;
    
    // model
    self.model = [RunModel sharedModel];
    
    [_saveButton setEnabled:false];
    [_stopButton setEnabled:true];
    
    /*
     // buttons - enable startButton
     [_startButton setEnabled: true];
     
     // buttons - disable stopButton, saveButton
     [_stopButton setEnabled:false];
     [_saveButton setEnabled:false];
     
     // mapview delegate
     self.mapView.delegate = self;
     */
    
    // initialization of locations array
    self.locations = [[NSMutableArray alloc] init];
    
    // location manager
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 5.0; // meters
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    
    // Request permission to track user
    [self.locationManager requestWhenInUseAuthorization];
    
    // request authorization for location tracking
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager requestLocation];
    }
    
    //tracking user location
    [self.locationManager startUpdatingLocation];
    
    // tracking user location
    [_mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    
    // show user location - moving dot on the map
    self.mapView.showsUserLocation = YES;
    
    // time label updated - convert the time to a string and add it to the model
    self.startTime = [NSDate date];
}


// change location
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
}

// locations array updated
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    NSLog(@"UPDATE LOCATION ");
    
    // last user location - last object added to locations array (most recent user location)
    CLLocation *location = [locations lastObject];
    
    
    // boolean update flag - get the initial location
    if (_didUpdateStartLocation == false) {
        _startPoint = location;
        _didUpdateStartLocation = true;
    }
    
    NSLog(@"User location lat: %f lng: %f", location.coordinate.latitude, location.coordinate.longitude);
    
    //self.distanceTraveledLabel.text = distanceString;
    
    if (location.horizontalAccuracy < 0){
        return;
    }
    
    // add object to the array of user locations
    [_locations addObject:location];
    NSLog(@"ADDED TO ARRAY!");
    
    // total number of locations added
    NSUInteger count = [self.locations count];
    
    if (count > 1) {
        CLLocationCoordinate2D coordinates[count];
        for (NSInteger i = 0; i < count; i++) {
            coordinates[i] = [(CLLocation *)self.locations[i] coordinate];
        }
        
        /*
         MKPolyline* polyline = [MKPolyline polylineWithCoordinates:coordinates count:count];
         // [self mapView:self.mapView rendererForOverlay:polyline];
         [self.mapView addOverlay:polyline];
         */
        
        self.distanceFromStart = [location distanceFromLocation:self.startPoint];
        
        NSString *distanceString = [NSString stringWithFormat:@"%g", self.distanceFromStart];
        _distanceLabel.text = [NSString stringWithFormat:@"DISTANCE : %@ m", distanceString];
    }
} // end didUpdateLocations

// update location - single location is a parameter
- (void)mapView:(MKMapView *)MapView didUpdateUserLocation:(MKUserLocation *)aUserLocation {
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        span.latitudeDelta = 0.005;
        span.longitudeDelta = 0.005;
        CLLocationCoordinate2D location;
        location.latitude = aUserLocation.coordinate.latitude;
        location.longitude = aUserLocation.coordinate.longitude;
        region.span = span;
        region.center = location;
        [MapView setRegion:region animated:YES];
}


//overlay polyline
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]]){
        MKOverlayView* overlayView= nil;
        MKPolyline* polyline = (MKPolyline *)overlay;
        MKPolylineView *routeOverlayView = [[MKPolylineView alloc] initWithPolyline:polyline];
        routeOverlayView.strokeColor     = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        routeOverlayView.lineWidth       = 3;
        overlayView = routeOverlayView;
        return overlayView;
    }
    return nil;
}



// PREVIOUSLY IMPLEMENTED START BUTTON FUNCTIONALITY
// startButtonDidPressed - start updating user location
/*
 - (IBAction)startButtonDidPressed:(id)sender {
 
 NSLog(@"START BUTTON PRESSED");
 [_startButton setEnabled:false];
 [_stopButton setEnabled:true];
 NSLog(@"buttons changed ");
 
 //tracking user location
 [self.locationManager startUpdatingLocation];
 NSLog(@" location starting to be updated");
 
 
 // tracking user location
 [_mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
 
 // show user location - moving dot on the map
 self.mapView.showsUserLocation = YES;
 
 // time label updated - convert the time to a string and add it to the model
 self.startTime = [NSDate date];
 
 // update user location
 [self.locationManager startUpdatingLocation];
 
 // Request permission to track user
 [self.locationManager requestWhenInUseAuthorization];
 
 // Start the location manager! We're starting to track the user =)
 [self.locationManager startUpdatingLocation];
 
 
 // tracking user location
 [_mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
 
 // show user location - moving dot on the map
 self.mapView.showsUserLocation = YES;
 // time label updated - convert the time to a string and add it to the model
 */



// STOP BUTTON
- (IBAction)stopButtonDidPressed:(id)sender {
    
    NSLog(@"stop button pressed");
    
    [_stopButton setEnabled: NO];
    [_saveButton setEnabled:true];
    
    // stop updating location
    [self.locationManager stopUpdatingLocation];
    
    _stopTime = [[NSDate alloc] init];
}



- (IBAction)saveButtonDidPressed:(id)sender {
    NSLog(@"Save button pressed");
    
    // double timeInterval - time in seconds
    double timeInterval = [_stopTime timeIntervalSinceDate:_startTime];
    int timeIntervalSeconds =  (int) timeInterval;
    
    
    NSString *timeString = [NSString stringWithFormat:@"%i", timeIntervalSeconds];
    NSLog(@"time string %@", timeString);
    
    // distance
    if (self.startPoint == nil) {
        self.startPoint =_location;
        self.distanceFromStart = 0;
    }
    
    // self.distanceFromStart = [_location distanceFromLocation:self.startPoint];
    //NSLog(@"distance from start %f", _distanceFromStart);
    
    int distanceInt = (int) _distanceFromStart;
    NSString *distanceString = [NSString stringWithFormat:@"%i", distanceInt];
    
    [_model insertRun:distanceString time:timeString];
    
    [_model save];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSLog(@"Failed");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 - (void)dealloc
 {
 #if DEBUG
 // Xcode8/iOS10 MKMapView bug workaround
 static NSMutableArray* unusedObjects;
 if (!unusedObjects)
 unusedObjects = [NSMutableArray new];
 [unusedObjects addObject:_mapView];
 #endif
 }
 */

@end
