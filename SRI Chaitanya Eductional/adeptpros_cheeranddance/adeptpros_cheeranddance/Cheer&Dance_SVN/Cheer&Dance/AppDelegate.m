//
//  AppDelegate.m
//  Cheer&Dance
//
//  Created by KUNDAN on 12/30/13.
//  Copyright (c) 2013 Adeptpros. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "JASidePanelController.h"
#import "LeftPaneViewController1.h"
#import "TeamSummaryViewController.h"

static BOOL busy=NO;
@implementation AppDelegate
@synthesize backUp,action;
@synthesize viewController_leftPane;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    sleep(2);
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]);
    
    
    //self.viewController_leftPane =[[JASidePanelController alloc]init];
    //self.viewController_leftPane.shouldDelegateAutorotateToVisiblePanel = NO;
//    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
//    self.window.rootViewController = self.viewController;
    
    
   // self.viewController_leftPane.leftPanel = [[LeftPaneViewController alloc] initWithNibName:@"LeftPaneViewController" bundle:nil];
   // self.viewController_leftPane.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil]];
     // self.viewController_leftPane.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil]];

    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
    {
    self.viewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    }
    else
    {
    self.viewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController_ios6" bundle:nil];
    }
    
     // self.window.rootViewController = self.viewController_leftPane;
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)CallSlide
{
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
    {
        
        self.viewController_leftPane =[[JASidePanelController alloc]init];
        
        self.viewController_leftPane.shouldDelegateAutorotateToVisiblePanel = NO;
        
        self.viewController_leftPane.leftPanel = [[LeftPaneViewController1 alloc] initWithNibName:@"LeftPaneViewController1" bundle:nil];
        
        self.viewController_leftPane.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil]];
        
    }
    else
    {
        self.viewController_leftPane =[[JASidePanelController alloc]init];
        self.viewController_leftPane.shouldDelegateAutorotateToVisiblePanel = NO;
        
        self.viewController_leftPane.leftPanel = [[LeftPaneViewController1 alloc] initWithNibName:@"LeftPaneViewController1_ios6" bundle:nil];
        self.viewController_leftPane.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] initWithNibName:@"ViewController_ios6" bundle:nil]];
        

    }
    
   // [self.viewController_leftPane ];
  //   self.window.rootViewController = self.viewController_leftPane;
//    [self.window makeKeyAndVisible];
}
-(void)CallSlide1
{
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        
        self.viewController_leftPane =[[JASidePanelController alloc]init];
        self.viewController_leftPane.shouldDelegateAutorotateToVisiblePanel = NO;
        
        self.viewController_leftPane.leftPanel = [[LeftPaneViewController1 alloc] initWithNibName:@"LeftPaneViewController1" bundle:nil];
        self.viewController_leftPane.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[TeamSummaryViewController alloc] initWithNibName:@"TeamSummaryViewController" bundle:nil]];
        
    }
    else
    {
        self.viewController_leftPane =[[JASidePanelController alloc]init];
        self.viewController_leftPane.shouldDelegateAutorotateToVisiblePanel = NO;
        
        self.viewController_leftPane.leftPanel = [[LeftPaneViewController1 alloc] initWithNibName:@"LeftPaneViewController1_ios6" bundle:nil];
        
        self.viewController_leftPane.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[TeamSummaryViewController alloc] initWithNibName:@"TeamSummaryViewController_ios6" bundle:nil]];
  
    }
   
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)startActivity
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        
        if(!busy)
        {
            busy = YES;
            backUp = [[UIView alloc] initWithFrame:self.window.frame];//CGRectMake(0, 0, 768, 1024)];
            backUp.backgroundColor = [UIColor colorWithRed:6.0f/255 green:25.0f/255 blue:43.0f/255 alpha:0.6];
            // backup.backgroundColor = [UIColor clearColor];
            
            [self.window  addSubview:backUp];
            
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
            {
                
                //action = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(640/2  , 1024/2, 40, 40)];
                action=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(self.window.frame.size.width/2, self.window.frame.size.height/2, 40, 40)];
                
            }
            action.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
            [action startAnimating];
            [backUp addSubview:action];
            
        }
    }
    else
    {
        if(!busy)
        {
            busy = YES;
            backUp = [[UIView alloc] initWithFrame:self.window.frame];//CGRectMake(0, 0, 320, 568)];
            backUp.backgroundColor = [UIColor colorWithRed:6.0f/255 green:25.0f/255 blue:43.0f/255 alpha:0.6];
            // backup.backgroundColor = [UIColor clearColor];
            
            [self.window  addSubview:backUp];
            
            action = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake( (320/2)-20 ,(568/2)-20, 40, 40)];
            
            action.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
            [action startAnimating];
            [backUp addSubview:action];
            
        }
    }
    
    
    
}
-(void)stopActivity
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        
        if(busy)
        {
            busy = NO;
            [action stopAnimating];
            [action removeFromSuperview];
            [backUp removeFromSuperview];
        }
    }
    else
    {
        if(busy)
        {
            busy = NO;
            [action stopAnimating];
            [action removeFromSuperview];
            [backUp removeFromSuperview];
        }
    }
}


@end
