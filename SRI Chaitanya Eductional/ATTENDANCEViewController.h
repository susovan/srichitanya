//
//  ATTENDANCEViewController.h
//  SRI Chaitanya Eductional
//
//  Created by susovan pati on 7/5/15.
//  Copyright (c) 2015 adeptpros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceEngine.h"
@interface ATTENDANCEViewController : UIViewController<WebServiceDelegte>
{
    IBOutlet UITableView *tablattendance;
    IBOutlet UIToolbar *tol;
    
}
-(IBAction)backbutton:(id)sender;

@end
