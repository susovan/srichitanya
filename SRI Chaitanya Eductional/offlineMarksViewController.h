//
//  offlineMarksViewController.h
//  SRI Chaitanya Eductional
//
//  Created by Adeptpros on 7/7/15.
//  Copyright (c) 2015 adeptpros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceEngine.h"
@interface offlineMarksViewController : UIViewController<WebServiceDelegte,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *tableview;
    
    NSMutableArray *arr_Testmode,*arr_Testdt,*arr_Marks,*arr_Maxmks,*arr_Rank,*arr_Sub,*arr_Testcode;
    NSArray *arr;

}
-(IBAction)backBtn:(id)sender;

@end
