//
//  LoginViewController.h
//  Cheer&Dance
//
//  Created by KUNDAN on 1/24/14.
//  Copyright (c) 2014 Adeptpros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeychainItemWrapper.h"
#import "WebService.h"

@interface LoginViewController : UIViewController<UIAlertViewDelegate,UITextFieldDelegate,WebServiceCompleteDelegate>
{
    IBOutlet UITextField *txt_Login_UserName;
    IBOutlet UITextField *txt_Login_Password;
    UIAlertView *alert;
    UIAlertView *alert1;
    IBOutlet UIButton *btn_Tick_Rember_Login;
    IBOutlet UIButton *btn_Forget_Password,*btn_Login;
    WebService *m_pWebService;
    
    IBOutlet   UIView *view_Forgot_Password;
    IBOutlet  UITextField *txt_Submit_Value;
    IBOutlet UILabel *Lbl_enterLoginDetails,*Lbl_username,*Lbl_password,*Lbl_Rememberme;
    IBOutlet UILabel *Lbl_forgotPassTitle;
    IBOutlet UIButton *btn_forgotpassSubmit;
    
    // 157 157 157 tf
    // 255 255 255 white
    // 56 56 56 block
    // 18 57 105 link forgotpassword
    
    
    // 42 87 138 for difficulty blue
    
}
@property(nonatomic,retain)KeychainItemWrapper *KeyWrapper;

- (IBAction)Loginbtn_clicked:(id)sender;
-(IBAction)btn_Tick_Rember_Login_Clicked:(id)sender;
-(IBAction)btn_Forget_Password_Clicked:(id)sender;
-(void)startIndecator;
-(void)stopIndecator;
-(IBAction)btn_Submit_Forgot_Pswd:(id)sender;
-(IBAction)btn_Cancel_Forgot_Pswd:(id)sender;


@end
