//
//  AppDelegate.m
//  CFAsyncDemo
//
//  Created by Constantine Fry on 1/25/13.
//  Copyright (c) 2013 Constantine Fry. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "CFAsyncImageView.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    [CFAsyncImageView applicationDidReceiveMemoryWarning];
}

@end
