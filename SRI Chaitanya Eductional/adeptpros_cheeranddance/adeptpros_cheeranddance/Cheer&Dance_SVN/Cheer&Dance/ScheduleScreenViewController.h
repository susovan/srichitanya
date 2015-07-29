//
//  ScheduleScreenViewController.h
//  Cheer&Dance
//
//  Created by Madhava Reddy on 4/5/14.
//  Copyright (c) 2014 Adeptpros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebService.h"
#import "SearchCell.h"


@interface ScheduleScreenViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,WebServiceCompleteDelegate>
{
    //search tableview
    IBOutlet  UITableView *myTableView;
   
    IBOutlet UILabel *lbl_Event_Title,*lbl_dateHeading;
    
    NSString *CheckWebService;
    WebService *m_pWebService;
    
    NSArray *ar_Events_Names;
    
    NSMutableArray *ar_Team_id;
    NSArray *ar_Team_sortedId;
    
    
    IBOutlet UILabel *lbl_team,*lbl_city,*lbl_level,*lbl_warmup,*lbl_perform,*lbl_floor;
    
    int Tag_dropdown;
    
    
    NSMutableArray *sortedArray,*sortedArrayIDS;
    
    NSMutableArray *ar_teams,*ar_teams_Names,*ar_teams_IDs;
    NSString *IDS_Event,*IDS_City,*IDS_Date,*IDS_Gym,*IDS_Level,*IDS_Team;
    NSArray *AftersortedAryIDS;
    
    
}

-(IBAction)btn_BackFromBigSearch:(id)sender;



@end
