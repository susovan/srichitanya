//
//  DetailedOnlineMarksViewController.h
//  SRI Chaitanya Eductional
//
//  Created by Adeptpros on 7/6/15.
//  Copyright (c) 2015 adeptpros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceEngine.h"
@interface DetailedOnlineMarksViewController : UIViewController<WebServiceDelegte,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *arr_Sub,*arr,*arr_Attempted,*arr_Correct,*arr_Neg,*arr_Pos,*arr_Ttlmarks,*arr_Ttlqst,*arr_Wrong;
  IBOutlet  UILabel *lbl_Heading;
  IBOutlet UITableView *tableview;
    
}
-(IBAction)backBtn:(id)sender;

@end
