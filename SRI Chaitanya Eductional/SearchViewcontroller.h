//
//  SearchViewcontroller.h
//  SRI Chaitanya Eductional
//
//  Created by susovan on 7/1/15.
//  Copyright (c) 2015 adeptpros. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "ServiceEngine.h"


@interface SearchViewcontroller : UIViewController<WebServiceDelegte,UITextFieldDelegate>
{
    IBOutlet UITextField *admissionno;
    IBOutlet UITextField *mobileno;
    IBOutlet UITextField *studentname;
    IBOutlet UITextField *parentname;
    IBOutlet UIScrollView *detailscroll;

}

-(IBAction)searchbutton:(id)sender;
-(IBAction)backButton:(id)sender;

@end
