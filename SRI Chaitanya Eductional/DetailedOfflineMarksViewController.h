//
//  DetailedOfflineMarksViewController.h
//  SRI Chaitanya Eductional
//
//  Created by Adeptpros on 7/7/15.
//  Copyright (c) 2015 adeptpros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceEngine.h"
@interface DetailedOfflineMarksViewController : UIViewController<WebServiceDelegte,UITableViewDataSource,UITableViewDelegate>
{
     NSMutableArray *arr_Sub,*arr,*arr_Maxmarks,*arr_Marks,*arr_Testmode,*arr_Rank;
    
    IBOutlet UILabel *lbl_Heading;
    
    IBOutlet UITableView *tableview;

}
-(IBAction)backBtn:(id)sender;

@end
