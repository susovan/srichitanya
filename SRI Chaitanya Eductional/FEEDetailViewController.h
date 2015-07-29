//
//  FEEDetailViewController.h
//  SRI Chaitanya Eductional
//
//  Created by susovan on 7/2/15.
//  Copyright (c) 2015 adeptpros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceEngine.h"
@interface FEEDetailViewController : UIViewController<WebServiceDelegte>
{
   
    IBOutlet UILabel *campus;
    IBOutlet UILabel *studebtname;
    IBOutlet UILabel *admnNo;
    IBOutlet UILabel *studyclass;
    IBOutlet UILabel *coursetrack;
    IBOutlet UILabel *group;
    IBOutlet UILabel *section;
    IBOutlet UILabel *concessionfirstyear;
    IBOutlet UILabel *concessionseacondyear;
    IBOutlet UILabel *givenfirstyear;
    IBOutlet UILabel *givenseacondyear;
    IBOutlet UILabel *reasonfirstyear;
    IBOutlet UILabel *reasonseacondyear;
    IBOutlet UILabel *coursefeefirstyear;
    IBOutlet UILabel *coursefeeseacondyear;
    IBOutlet UILabel *concfeefirstyear;
    IBOutlet UILabel *concfeeseacondyear;
    IBOutlet UILabel *additfeefirstyear;
    IBOutlet UILabel *additfeeseacondyear;
    IBOutlet UILabel *lblfyNetFeeAmt;
    IBOutlet UILabel *lblsyNetFeeAmt;
    IBOutlet UILabel *lblfyfeepaid;
    IBOutlet UILabel *lblsyfeepaid;
    IBOutlet UILabel *lblfyFeeDue;
    IBOutlet UILabel *lblsyFeeDue;
    IBOutlet UILabel *lblfyFeeRefundAmt;
    IBOutlet UILabel *lblsyFeeRefundAmt;
    IBOutlet UILabel *lblfydeduction;
    IBOutlet UILabel *lblsydeduction;
    IBOutlet UILabel *lblfyexcess;
    IBOutlet UILabel *lblsyexcess;
    IBOutlet UIScrollView *scroll1;
    
   }
-(IBAction)backbutton:(id)sender;

@end
