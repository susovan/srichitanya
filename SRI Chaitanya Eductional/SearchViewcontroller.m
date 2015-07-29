
//
//  SearchViewcontroller.m
//  SRI Chaitanya Eductional
//
//  Created by susovan on 7/1/15.
//  Copyright (c) 2015 adeptpros. All rights reserved.
//

#import "SearchViewcontroller.h"
#import "ServiceEngine.h"
#import "StudentDetailsViewController.h"
#import "Utility.h"
#import "LoginViewController.h"
@interface SearchViewcontroller ()

@end

@implementation SearchViewcontroller

- (void)viewDidLoad
{
    
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backBtn@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    self.navigationItem.leftBarButtonItem=bar;
   
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myKeyboardWillHideHandler:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)backButtonAction:(UIBarButtonItem*)sende
{
    
//    [UIView animateWithDuration:0.75
//                     animations:^{
//                         [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//                         [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
//                     }];
//    
//    [self.navigationController popViewControllerAnimated:NO];
    
   [self dismissViewControllerAnimated:YES completion:nil];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)searchbutton:(id)sender
{
  if ([Utility isInternetAvailable])
  {
        
    if ([[admissionno text]isEqualToString:@""]&&[[mobileno text]isEqualToString:@""]&&([[studentname text]isEqualToString:@""]||[[parentname text]isEqualToString:@""]))
      
    {
        if ([studentname text].length>0||[parentname text].length>0)
        {
            [Utility showToast:@"STUDENT NAME AND PARENT NAME SHOULD BE MINIMUM 3 CHARECTER " inView:self.view];
            
        }
        else
        {
            [Utility showToast:@"Please enter admission Number or mobile Number or student Name and Parent Name" inView:self.view];
            
        }
       
    }
      
    else if (([studentname text].length<3||[parentname text].length<3)&&([[admissionno text]isEqualToString:@""]&&[[mobileno text]isEqualToString:@""]))
        {
                 [Utility showToast:@"STUDENT NAME AND PARENT NAME SHOULD BE MINIMUM 3 CHARECTER " inView:self.view];
                 
        }
      
      
    else
    {
        NSString *employeeID=[[NSUserDefaults standardUserDefaults]objectForKey:@"empoleeID"];
        NSString *jsonReQuest=[NSString stringWithFormat:@"admNo=%@;mobileNo=%@;studName=%@;parentName=%@;employeeId=%@;",admissionno.text,mobileno.text,studentname.text,parentname.text,employeeID];
        NSString *urlstr=[NSString stringWithFormat:@"http://202.153.37.44:9580/jsonServices/student/getCampusStudentSearchDetails;"];
        urlstr=[urlstr stringByAppendingString:jsonReQuest];
        
        
        NSString *encodedString = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [[ServiceEngine CallService]setWebServiceDelegate:self];
        [[ServiceEngine CallService]PostService:encodedString body:nil context:nil authorization:nil httpMethod:HTTPMethod_POST];
        
        [Utility startActivityIndicatorOnView:self.view withText:@"SRI Chaitanya"];


    }
      
  }
  
    else
    {
        [Utility showToast:@"NO NETWORK AVILABLE" inView:self.view];
    }
}
-(IBAction)backButton:(id)sender;
{
    LoginViewController *obj=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil ];
    [self presentViewController:obj animated:YES completion:nil];

}
-(void)WebServiceRequestCompleted:(NSDictionary *)result context:(NSString *)context
{
    NSLog(@"%@",result);
    [Utility stopActivityIndicatorFromView:self.view];
    
    NSArray*arr1=[result objectForKey:@"ns1.JSONEmployeeServiceExceptionDetails"];
    NSDictionary *dict1=[arr1 objectAtIndex:[[result objectForKey:@"faultMessage"]integerValue]];
    
    NSString *str1=[dict1 objectForKey:@"faultMessage"]
    ;
   
    if ([str1 isEqualToString:@"Student name and parent name are not found"])
    {
        [Utility showToast:@"Student name and parent name are not found" inView:self.view];
        
    }
                    
    
   else if ([str1 isEqualToString:@"Admission number is not valid"])
    {
        [Utility showToast:@"Admission number is not valid" inView:self.view];
        
    }
   else if ([str1 isEqualToString:@"Please enter any on of the above details"])
   {
       [Utility showToast:@"Please enter any on of the above details" inView:self.view];
       
   }
   else if ([str1 isEqualToString:@"Mobile number is not valid"])
   {
       [Utility showToast:@"Mobile number is not valid" inView:self.view];
       
   }
    


   else
    {
        
        StudentDetailsViewController *obj=[[StudentDetailsViewController alloc]initWithNibName:@"StudentDetailsViewController" bundle:nil andMyData:result];
        
        [self.navigationController pushViewController:obj animated:YES];
        
        
        
        
    }
    
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField;             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
{
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==parentname) {
        [textField resignFirstResponder];
        
    }
    else if (textField == admissionno)
    {
        
        [mobileno becomeFirstResponder];
        
    }else if (textField == mobileno)
    {
        
        [studentname becomeFirstResponder];
        
    }else if (textField == studentname)
    {
        
        [parentname becomeFirstResponder];
        
    }

    

    
    
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==admissionno)
    {
        [UIView animateWithDuration:0.4 animations:^{
            [detailscroll setContentOffset:CGPointMake(0,0)];
        }];
       
        
    }
    if (textField==mobileno)
    {
        [UIView animateWithDuration:0.4 animations:^{
            [detailscroll setContentOffset:CGPointMake(0,0)];
        }];
      
//        [parentname setText:nil];
//        [studentname setText:nil];
//        [mobileno setText:nil];
//        [admissionno setText:nil];

    }

    
    if (textField==studentname)
    {
        [UIView animateWithDuration:0.4 animations:^{
            [detailscroll setContentOffset:CGPointMake(0,50)];
        }];
        
    }
    if (textField==parentname)
    {
        [UIView animateWithDuration:0.4 animations:^{
            [detailscroll setContentOffset:CGPointMake(0,70)];
        }];
        
            }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==admissionno)
    {
        if (![self isvalidString:string])
            return NO;
        
        NSInteger insertDelta = string.length - range.length;
        
        if (admissionno.text.length + insertDelta > 9  && range.length == 0)
        {
            return NO; // the new string would be longer than MAX_LENGTH
        }
        
        
        mobileno.text=nil;
        parentname.text=nil;
        studentname.text=nil;
      
        return YES;
        
          }
    if (textField==mobileno)
    {
        if (![self isvalidString:string])
            return NO;
        
              NSInteger insertDelta = string.length - range.length;
        
                if (mobileno.text.length + insertDelta > 10  && range.length == 0)
                {
                    return NO; // the new string would be longer than MAX_LENGTH
                }
        
        
        

        parentname.text=nil;
        studentname.text=nil;
        admissionno.text=nil;
        
        return YES;

        
    }
    
    if (textField==studentname)
    {
        
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZasdfghjklzxcvbnmqwertyuio  "] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];

        
     
        admissionno.text=nil;
        mobileno.text=nil;
         return [string isEqualToString:filtered];
         }
    if (textField==parentname)
    {
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZasdfghjklzxcvbnmqwertyuio!@#$%^&*()_  "] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];

        
        admissionno.text=nil;
        mobileno.text=nil;
        return [string isEqualToString:filtered];
        }
    


    

    return YES;
    
}
-(BOOL)isvalidString :(NSString *)str
{
    NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"0987654321"] invertedSet];
    NSString *filtered = [[str componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
    return [str isEqualToString:filtered];
    
}

    
    
- (void)myKeyboardWillHideHandler:(NSNotification *)notification;
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.4 animations:^{
        [detailscroll setContentOffset:CGPointMake(0, 0)];
    }];
    
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
