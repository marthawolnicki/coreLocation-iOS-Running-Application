// Martha Wolnicki
// wolnicki@usc.edu
// ITP 342
// Bennett Lee
// Final Project: coreLocationRunning

#import "Run.h"
#import <UIKit/UIKit.h>

#import <Google/SignIn.h>
#import <GTLRGmail.h>



@interface AddViewController : UIViewController <GIDSignInDelegate, GIDSignInUIDelegate>


@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;

@property (nonatomic, strong) IBOutlet GIDSignInButton *signInButton;
@property (nonatomic, strong) UITextView *output;
@property (nonatomic, strong) GTLRGmailService *service;

@property (strong, nonatomic) Run* selectedRun;

@end
