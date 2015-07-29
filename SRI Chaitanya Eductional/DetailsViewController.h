//
//  DetailsViewController.h
//  SRI Chaitanya Eductional
//
//  Created by susovan on 7/2/15.
//  Copyright (c) 2015 adeptpros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController

{
    IBOutlet UILabel *adminNO;
    IBOutlet UILabel *studentname;
    
    
}
-(IBAction)freedetails:(id)sender;
-(IBAction)offlinemark:(id)sender;
-(IBAction)onlinemark:(id)sender;
-(IBAction)attendance:(id)sender;
-(IBAction)backButton:(id)sender;


@end
