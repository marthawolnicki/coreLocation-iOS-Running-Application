// Martha Wolnicki
// wolnicki@usc.edu
// ITP 342
// Bennett Lee
// Final Project: coreLocationRunning


#import "RunDetailsViewController.h"
#import "Run.h"

@interface RunDetailsViewController ()

@property (strong, nonatomic) IBOutlet UILabel *distanceDetailsLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeDetailsLabel;



@end

@implementation RunDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //time
    _timeDetailsLabel.text = [NSString stringWithFormat:@"TIME: %@ seconds",  _selectedRun.timeString];
    
    //distance label
    _distanceDetailsLabel.text = [NSString stringWithFormat:@"DISTANCE: %@ meters", _selectedRun.distanceString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)goGoogleDidPressed:(id)sender {
    
}





/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
