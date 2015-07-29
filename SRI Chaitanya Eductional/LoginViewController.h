//
//  LoginViewController.h
//  SRI Chaitanya Eductional
//
//  Created by susovan on 6/30/15.
//  Copyright (c) 2015 adeptpros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceEngine.h"
@interface LoginViewController : UIViewController<WebServiceDelegte,UITextFieldDelegate>
{
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
    IBOutlet UIScrollView *scroll1;
    IBOutlet UIButton *loginbtn;
    
    
    
}
-(IBAction)login:(id)sender;


@end
