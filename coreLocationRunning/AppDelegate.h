//
//  AppDelegate.h
//  coreLocationRunning
//
//  Created by Martha Wolnicki on 11/29/17.
//  Copyright © 2017 Martha Wolnicki. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <Google/SignIn.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate, GIDSignInDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

