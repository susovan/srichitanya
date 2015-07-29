//
//  OnlineMarksViewController.h
//  SRI Chaitanya Eductional
//
//  Created by Adeptpros on 7/6/15.
//  Copyright (c) 2015 adeptpros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceEngine.h"
@interface OnlineMarksViewController : UIViewController<WebServiceDelegte,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *tableview_online;
    
    NSMutableArray *arr,*arr_Examdate,*arr_Testname,*attempt_id;
    
}

-(IBAction)backBtn:(id)sender;

@end
