//
//  StudentDetailsViewController.h
//  SRI Chaitanya Eductional
//
//  Created by susovan on 7/2/15.
//  Copyright (c) 2015 adeptpros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchViewcontroller.h"
@interface StudentDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    IBOutlet UITableView *tableview_StudentDetails;
    NSMutableArray *arr_AdmNo,*arr_Campus,*arr_City,*arr_PrnNm,*arr_StdNm;

}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andMyData:(NSDictionary *)tempData;


-(IBAction)studentdetails:(id)sender;
-(IBAction)backButton:(id)sender;

@end
