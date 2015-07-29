//
//  LoginViewController.m
//  SRI Chaitanya Eductional
//
//  Created by susovan on 6/30/15.
//  Copyright (c) 2015 adeptpros. All rights reserved.
//

#import "LoginViewController.h"
#import "ServiceEngine.h"
#import "SearchViewcontroller.h"
#import "Utility.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [username setDelegate:self];
    [password setDelegate:self];
    
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myKeyboardWillHideHandler:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)login:(id)sender
//{
//    if ([Utility isInternetAvailable])
//    {
//        if (username.text.length!=0&&password.text.length!=0)
//        {
//            
//     NSString *jsonReQuest=[NSString stringWithFormat:@"payrollId=%@;password=%@;",username.text,password.text];
//     NSString *urlstr=[NSString stringWithFormat:@"http://202.153.37.44:9580/jsonServices/student/getCampusEmployeeLogin;"];
//    urlstr=[urlstr stringByAppendingString:jsonReQuest];
//       
//    [[ServiceEngine CallService]setWebServiceDelegate:self];
//    [[ServiceEngine CallService]PostService:urlstr body:nil context:nil authorization:nil httpMethod:HTTPMethod_POST];
//    [Utility startActivityIndicatorOnView:self.view withText:@"SRI Chaitanya"];
//        }
//        else
//        {
//            [Utility showToast:@"Details Are Not Empty" inView:self.view];
//            
//        }
//    }
//    else
//        
//    {
//        [Utility showToast:@"NO NETWORK AVILABLE" inView:self.view];
//        
//    }
//}


{
    if ([Utility isInternetAvailable])
    {
        if ([[username text]isEqualToString:@""]||[[password text]isEqualToString:@""])
        {
            
            if (username.text.length<=0&&password.text.length<=0)
            {
                [Utility showToast:@"Details Are Not Empty" inView:self.view];
                
            }else
            {
                if (username.text.length<=0)
                    
                {
                    [Utility showToast:@"USER NAME SHOULD NOT BE EMPTY" inView:self.view];
                }else
                {
                    [Utility showToast:@"PASSWORD SHOULD NOT BE EMPTY" inView:self.view];
                }
                
            }
            
            
        }
        else
        {
            NSString *jsonReQuest=[NSString stringWithFormat:@"payrollId=%@;password=%@;",username.text,password.text];
            NSString *urlstr=[NSString stringWithFormat:@"http://202.153.37.44:9580/jsonServices/student/getCampusEmployeeLogin;"];
            urlstr=[urlstr stringByAppendingString:jsonReQuest];
            
            [[ServiceEngine CallService]setWebServiceDelegate:self];
            [[ServiceEngine CallService]PostService:urlstr body:nil context:nil authorization:nil httpMethod:HTTPMethod_POST];
            [Utility startActivityIndicatorOnView:self.view withText:@"SRI Chaitanya"];
            
            
        }
    }
    else
    {
        [Utility showToast:@"NO NETWORK AVILABLE" inView:self.view];
        
    }
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==username)
    {
        [UIView animateWithDuration:0.4 animations:^{
            [scroll1 setContentOffset:CGPointMake(0,140)];
        }];
    }if (textField==password)
    {
        [UIView animateWithDuration:0.4 animations:^{
            [scroll1 setContentOffset:CGPointMake(0,150)];
        }];
        
    }
}

- (void)myKeyboardWillHideHandler:(NSNotification *)notification;
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.4 animations:^{
        [scroll1 setContentOffset:CGPointMake(0, 0)];
    }];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==password) {
          [textField resignFirstResponder];
        
    }
 else if (textField == username)
 {

     [password becomeFirstResponder];

}



    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==username)
    {

        NSInteger insertDelta = string.length - range.length;
        
        if (username.text.length + insertDelta > 9  && range.length == 0)
        {
            return NO; // the new string would be longer than MAX_LENGTH
        }
        
    }
    return YES;

}

-(void)WebServiceRequestCompleted:(NSDictionary *)result context:(NSString *)context
{
    NSLog(@"%@",result);
     [Utility stopActivityIndicatorFromView:self.view];
    NSDictionary *dict=[result objectForKey:@"ns2.Employee"];
    NSString *str1=[dict objectForKey:@"status"];
    NSString *str2=[dict objectForKey:@"employee"];
    
    [[NSUserDefaults standardUserDefaults]setObject:str2 forKey:@"empoleeID"];
    
    if ([str1 isEqualToString:@"VALID"])
    {
        SearchViewcontroller *obj=[[SearchViewcontroller alloc]initWithNibName:@"SearchViewcontroller" bundle:nil];
        UINavigationController *navigation=[[UINavigationController alloc] initWithRootViewController:obj];
        
      //  [self.navigationController pushViewController:obj animated:YES];

        [self presentViewController:navigation animated:NO completion:nil];
        
    }

    else
    {
        [Utility showToast:@"wrong password" inView:self.view];
        
    }
    
   
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
