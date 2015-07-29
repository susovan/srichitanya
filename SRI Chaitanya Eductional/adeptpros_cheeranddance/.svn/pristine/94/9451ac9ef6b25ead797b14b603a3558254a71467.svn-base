//
//  LoginViewController.m
//  Cheer&Dance
//
//  Created by KUNDAN on 1/24/14.
//  Copyright (c) 2014 Adeptpros. All rights reserved.
//

#import "LoginViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import "KeychainItemWrapper.h"
#import "Singleton.h"
#import "JSON.h"
#import "Defines.h"
#import "SearchViewController.h"

@interface LoginViewController ()

{
    NSString *ResponseString;
    NSString *trimmedStringforUname;
    NSString *trimmedStringforPass;
    NSString *msgStr;
    NSString *CheckWebService;
    UIAlertView *myAlert;
    UIAlertView *myInvalidAlert;
    NSString *myName;
}
@end


@implementation LoginViewController
@synthesize KeyWrapper;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)showBusyView
{
    AppDelegate *l_pAppDelegate	= (AppDelegate *)[[UIApplication sharedApplication] delegate];
	[l_pAppDelegate startActivity];
}
-(void)hideBusyView
{
    AppDelegate *l_pAppDelegate	= (AppDelegate *)[[UIApplication sharedApplication] delegate];
	[l_pAppDelegate stopActivity];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
//  UIApplication *app=  [UIApplication sharedApplication];
    
 //   AppDelegate *apd=[app delegate];
    
//    AppDelegate *a=[[AppDelegate alloc]init];
    
    
    [textField resignFirstResponder];
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"savePassword"])
    {
        //btn_Tick_Rember_Login.imageView.image=[UIImage imageNamed:@"uncheck.png"];
        [btn_Tick_Rember_Login setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    }
    else
    {
         [btn_Tick_Rember_Login setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        // btn_Tick_Rember_Login.imageView.image=[UIImage imageNamed:@"check.png"];
        txt_Login_UserName.text=[KeyWrapper objectForKey:(__bridge id)(kSecValueData)];
        txt_Login_Password.text=[KeyWrapper objectForKey:(__bridge id)(kSecAttrAccount)];
      }
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    /*
    [self setValue:@"amith" forKey:@"myName"];
    NSLog(@"%@",[self valueForKey:@"myName"]);
    
    NSString *str1=@"Hello";
    NSString *str2=@"hello";
    
    
    if([str1 isEqual:str2])
    {
        NSLog(@"isEqual");
        
    }
    if (str1==str2)
    {
    NSLog(@"==");
    
    }
    if([str1 isEqualToString:str2])
    {
     NSLog(@"isEqualToString");
    
    }
    if ([str1 compare:str2 options:NSCaseInsensitiveSearch]==NSOrderedSame)
    {
        NSLog(@"s1 is equivalent to s2");
    }
    
    if([str1 caseInsensitiveCompare:str2]==NSOrderedSame)
    {
        NSLog(@"Case Insensitive Comparision");
    }*/
    
    
    /*
    NSString *str = @"com.sortitapps.themes.pink.book";
    
    
    NSUInteger dots=[str rangeOfString:@"."].location;
    
    NSLog(@"%d",dots);
    
    NSUInteger dot = [str rangeOfString:@"." options:NSBackwardsSearch].location;
     NSLog(@"%d",dot);
    
    NSString *newStr =
    [str stringByReplacingCharactersInRange:NSMakeRange(dot+1, [str length]-dot-1)
                                 withString:@"something_else"];
    */
    
    NSLog(@"device ver:%@",[[UIDevice currentDevice]systemVersion]);
    
   // NSString *str=@"2014-03-12";
    //NSString *newStr=[str stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //NSLog(@"%@",newStr);
    
        
    /*
    UIDatePicker *datePicker=[[UIDatePicker alloc]init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:5];
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
   
    [datePicker setMaximumDate:maxDate];
    [datePicker setMinimumDate:currentDate];*/
    
    
    // Fonts
    Lbl_enterLoginDetails.font=[UIFont fontWithName:@"Enigmatic" size:26];
    Lbl_username.font=[UIFont fontWithName:@"Enigmatic" size:18];
    Lbl_password.font=[UIFont fontWithName:@"Enigmatic" size:18];
    txt_Login_UserName.font=[UIFont fontWithName:@"Enigmatic" size:18];
    txt_Login_Password.font=[UIFont fontWithName:@"Enigmatic" size:18];
    Lbl_Rememberme.font=[UIFont fontWithName:@"Enigmatic" size:18];
    
    [btn_Forget_Password.titleLabel setFont:[UIFont fontWithName:@"Enigmatic" size:18]];
    [btn_Login.titleLabel setFont:[UIFont fontWithName:@"Enigmatic" size:20]];
    
     Lbl_forgotPassTitle.font=[UIFont fontWithName:@"Enigmatic" size:26];
     txt_Submit_Value.font=[UIFont fontWithName:@"Enigmatic" size:18];
     [btn_forgotpassSubmit.titleLabel setFont:[UIFont fontWithName:@"Enigmatic" size:20]];
    
    
    // Colors
    Lbl_enterLoginDetails.textColor=[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    Lbl_username.textColor=[UIColor colorWithRed:56.0/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];
    Lbl_password.textColor=[UIColor colorWithRed:56.0/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];
    txt_Login_UserName.textColor=[UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:1.0];
    txt_Login_Password.textColor=[UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:1.0];
    Lbl_Rememberme.textColor=[UIColor colorWithRed:56.0/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];
    btn_Forget_Password.titleLabel.textColor=[UIColor colorWithRed:56.0/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];
    btn_Login.titleLabel.textColor=[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    Lbl_forgotPassTitle.textColor=[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    txt_Submit_Value.textColor=[UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:1.0];
    btn_forgotpassSubmit.titleLabel.textColor=[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
       KeyWrapper = [[KeychainItemWrapper alloc]initWithIdentifier:@"password" accessGroup:nil];
    
    [txt_Login_UserName setDelegate:self];
    [txt_Login_Password setDelegate:self];
 
 }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Loginbtn_clicked:(id)sender
{
    
   // http://joomerang.geniusport.com/cheerinfinity/webservices/getwbs_login.php?json=[{"username":"xtremespirit","password":"cheers"}]
    
  
    trimmedStringforUname = [[txt_Login_UserName text] stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    trimmedStringforPass = [[txt_Login_Password text] stringByTrimmingCharactersInSet:
                            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status == NotReachable)
    {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"" message:@"Please check your Wi-Fi or 3G connection and try again" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [al show];
        
    }
    else if([[txt_Login_UserName text]isEqualToString:@""] || [[txt_Login_Password text]isEqualToString:@""] ||[txt_Login_UserName text]==nil || [txt_Login_Password text]==nil )
    {
        
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"" message:@"UserName/Password can't be Empty" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [al show];
        [txt_Login_Password setText:nil];
        [txt_Login_UserName  setText:nil];
        
    }
    else
    {
        [self startIndecator];
        
        [self performSelectorInBackground:@selector(goBackGroundLogin1) withObject:nil];
        
    }
    
}

-(void)startIndecator
{
    AppDelegate *app=[[UIApplication sharedApplication]delegate];
    
    [app startActivity];
    
}

-(void)stopIndecator
{
    AppDelegate *app=[[UIApplication sharedApplication]delegate];
    
    [app stopActivity];
    
}

-(void)goBackGroundLogin1
{
   // http://joomerang.geniusport.com/cheerinfinity/webservices/getwbs_login.php?json=[{"username":"xtremespirit","password":"cheers"}]
    // http://joomerang.geniusport.com/landrover/getwbs_login.php?json=[{"emailid":"","password":""}]
    
    //http://joomerang.geniusport.com/geniusport/api.php?json=[{
    //    "method_identifier":"createEmployee","params":{"empid":"EMP980","fullname":"Ganesh Tawa","desig":"UI developer","salary":"30000","phno":"8123499194"}}]
    
    NSString *jsonReQuest=[NSString stringWithFormat:@"{\"username\":\"%@\",\"password\":\"%@\"}",trimmedStringforUname,trimmedStringforPass];
    
    // NSLog(@"%@",jsonReQuest);
    
    NSString * stringUrl =[NSString stringWithFormat:@"%@getwbs_login.php?json=[",BASEURL];
    stringUrl = [stringUrl stringByAppendingString:jsonReQuest];
    stringUrl = [stringUrl stringByAppendingString:@"]"];
    stringUrl =[stringUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //   NSLog(@"checking url %@",stringUrl);
    NSURL *url = [NSURL URLWithString:stringUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    //  NSLog(@"%@",request);
    NSHTTPURLResponse * response = nil;
    
    NSData *requestData = [NSData dataWithBytes:[jsonReQuest UTF8String] length:[jsonReQuest length]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue: @"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    
    
    NSData * POSTReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    ResponseString = [[NSString alloc] initWithBytes:[POSTReply bytes] length:[POSTReply length] encoding: NSUTF8StringEncoding];
    //NSLog(@"HTTP status code:%d", response.statusCode);
    // NSLog(@"responcein 0: %@", ResponseString);
    
    NSData *data=[ResponseString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSLog(@"respoce dict %@",jsonResponse);
    
    
    [self performSelectorOnMainThread:@selector(stopIndecator) withObject:nil waitUntilDone:YES];
    
    NSDictionary *dicts=[jsonResponse objectForKey:@"Loggedin_Stat"];
    
    NSString *str=[dicts objectForKey:@"msg"];
    
    Singleton *singleton_Obj=[Singleton getObject];
    [singleton_Obj setLoginUserID:[dicts objectForKey:@"userid"]];
    
    
    msgStr=str;
    
    if([str isEqualToString:@"Successful"])
    {
        
        [self performSelectorOnMainThread:@selector(mainMethod) withObject:nil waitUntilDone:YES];
    }
    else if(![str isEqualToString:@"Successful"])
    {
        
        [self performSelectorOnMainThread:@selector(mainMethod) withObject:nil waitUntilDone:YES];
        
    }
    
    
}
-(void)mainMethod
{
    if([msgStr isEqualToString:@"Successful"])
    {
        if(btn_Tick_Rember_Login.imageView.image==[UIImage imageNamed:@"uncheck.png"])
        {
          
            [KeyWrapper resetKeychainItem];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"savePassword"];
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"savePassword"];

            [KeyWrapper setObject:txt_Login_UserName.text forKey:(__bridge id)(kSecValueData)];
            [KeyWrapper setObject:txt_Login_Password.text forKey:(__bridge id)(kSecAttrAccount)];
            
        }
        
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
            SearchViewController *obj=[[SearchViewController alloc]initWithNibName:@"SearchViewController" bundle:nil];
            [obj setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [self presentViewController:obj animated:YES completion:nil];
        }
        else
        {
            SearchViewController *obj=[[SearchViewController alloc]initWithNibName:@"SearchViewController_ios6" bundle:nil];
             [obj setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [self presentViewController:obj animated:YES completion:nil];
        }
       

    }
    else
    {
        alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"UserName/Password Incorrect" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert1 show];
        [txt_Login_UserName setText:nil];
        [txt_Login_Password setText:nil];
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
if(alertView ==myAlert)
{
  
    txt_Login_Password.text=nil;
    [view_Forgot_Password removeFromSuperview];
}

    if(alertView ==myInvalidAlert)
    {
        
        txt_Submit_Value.text=nil;
    }
}
-(IBAction)btn_Tick_Rember_Login_Clicked:(UIButton*)sender
{
    //if(sender.imageView.image==[UIImage imageNamed:@"uncheck.png"])
    if([btn_Tick_Rember_Login.imageView.image isEqual:[UIImage imageNamed:@"uncheck.png"]])
    {
      
        [btn_Tick_Rember_Login setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
    }
    else
    {
        [btn_Tick_Rember_Login setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];

    }
}


-(IBAction)btn_Forget_Password_Clicked:(id)sender
{
    [txt_Submit_Value setText:nil];
    btn_Login.enabled=NO;
    
    view_Forgot_Password.transform = CGAffineTransformMakeScale(0.05, 0.05);
    [UIView animateWithDuration:0.50 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        // animate it to the identity transform (100% scale)
        view_Forgot_Password.transform = CGAffineTransformIdentity;
    } completion:nil];
    [self.view addSubview:view_Forgot_Password];
    

}
-(void)webServiceRequestCompleted
{
    if (!m_pWebService.m_pSuccessData)
    {
        // [self hideBusyView];
        //NSLog(@"%d",m_pWebService.m_pSuccessData);
        return;
    }

    else
    {
        ////NSLog(@"%d",m_pWebService.m_pSuccessData);
        [self hideBusyView];
        
        NSString *json_string = [[NSString alloc] initWithData:m_pWebService.m_pHTTPRsp encoding:NSUTF8StringEncoding];
        NSDictionary *results = [json_string JSONValue];
        NSLog(@"Result= %@",results);
        // NSArray *aaa= [json_string JSONValue];
        
    if([CheckWebService isEqualToString:@"Forgot_Password"])
    {
     NSDictionary *dict=[results objectForKey:@"Forgotpwd_Stat"];
        NSLog(@"%@",dict);
        
        NSString *str=[dict objectForKey:@"msg"];
        if([str isEqualToString:@"Successful"])
        {
            
            myAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"Password has been sent to your       E-mail Successfully" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [myAlert show];
            btn_Login.enabled=YES;
            
        }
        else
        {
            myInvalidAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter Valid Email" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [myInvalidAlert show];
            
        }
        
    }
  }
}

-(void)webServiceRequestFail :(NSError *)error
{
    [self hideBusyView];
    // NoInternetConnection=YES;
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status == NotReachable)
    {
    
    UIAlertView *alert2=[[UIAlertView alloc] initWithTitle:@"" message:@"Please check your Wi-Fi or 3G connection and try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert2 show];
    }
}

//plz dont delete this
/*
 
 
 else
 {
 BOOL bs=[Singleton getnetConnection];
 if(bs)
 {
 
 }
 else
 {
 NSString *jsonReQuest=[NSString stringWithFormat:@"{\"username\":\"%@\",\"password\":\"%@\"}",trimmedStringforUname,trimmedStringforPass];
 NSString * stringUrl = @"http://joomerang.geniusport.com/cheerinfinity/webservices/getwbs_login.php?json=[";
 NSMutableURLRequest *request=[Singleton getRequestObject:stringUrl urlAndstring:jsonReQuest];
 
 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0), ^{
 NSHTTPURLResponse * response = nil;
 NSData * POSTReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
 ResponseString = [[NSString alloc] initWithBytes:[POSTReply bytes] length:[POSTReply length] encoding: NSUTF8StringEncoding];
 
 NSData *data=[ResponseString dataUsingEncoding:NSUTF8StringEncoding];
 NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
 NSLog(@"respoce dict %@",jsonResponse);
 NSDictionary *dicts=[jsonResponse objectForKey:@"Loggedin_Stat"];
 
 NSString *str=[dicts objectForKey:@"msg"];
 NSLog(@"%@",str);
 msgStr=str;
 [self startIndecator];
 dispatch_async(dispatch_get_main_queue(), ^{
 
 [self stopIndecator];
 if([str isEqualToString:@""])
 {
 ViewController *obj=[[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
 [self presentViewController:obj animated:YES completion:nil];
 }
 else
 {
 alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"UserName/Password Incorrect" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
 [alert1 show];
 }
 });
 
 });
 
 }

 */
-(BOOL)isEmailIDValid:(NSString *)_emailId
{
    NSString *emailReg = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailReg];
    if (([emailTest evaluateWithObject:_emailId] != YES))
    {
        return NO;
    }else
        return YES;
}
-(IBAction)btn_Submit_Forgot_Pswd:(id)sender
{
    [txt_Submit_Value resignFirstResponder];
    
    if (![self isEmailIDValid:txt_Submit_Value.text])
    {
        UIAlertView *loginalert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Enter Valid Email" delegate:self
                                                   cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [loginalert show];
        [self hideBusyView];
        
        return;
    }
    else
    {
     [self showBusyView];
    CheckWebService=@"Forgot_Password";
    NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
    [dct setObject:[txt_Submit_Value text] forKey:@"email_id"];
    
    NSString *jsonstring1=[dct JSONRepresentation];
    ////NSLog(@"jsonstring=%@",jsonstring1);
    NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring1];
    ////NSLog(@"Post %@", post1);
    
    NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_forgotpassword.php",BASEURL];
    m_pWebService			= [[WebService alloc] initWebService:l_pURL];
    m_pWebService.mDelegate		= self;
    [m_pWebService  sendHTTPPost:post1];
    }
    
}

-(IBAction)btn_Cancel_Forgot_Pswd:(id)sender
{
    btn_Login.enabled=YES;
    
    [view_Forgot_Password removeFromSuperview];
}
@end
