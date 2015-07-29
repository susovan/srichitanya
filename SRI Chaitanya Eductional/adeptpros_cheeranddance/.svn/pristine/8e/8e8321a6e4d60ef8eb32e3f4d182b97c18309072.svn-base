//
//  SearchViewController.h
//  Cheer&Dance
//
//  Created by Madhava Reddy on 2/19/14.
//  Copyright (c) 2014 Adeptpros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebService.h"
#import "SearchCell.h"

@interface SearchViewController : UIViewController<WebServiceCompleteDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIPopoverControllerDelegate,UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    NSMutableArray *accessScreenArray,*accessScreenArray1;
    
    
    //search tableview
    IBOutlet  UITableView *myTableView;
    IBOutlet UIView *view_SearchView;
    IBOutlet UILabel *lbl_Event_Title;
    
    
    
    UIAlertView *logoutAlert;
    IBOutlet UILabel *lbl_search_heading;

     NSString *CheckWebService;
     WebService *m_pWebService;
    
    NSArray *ar_Events_Names;
    
    NSMutableArray *ar_Team_id;
    NSArray *ar_Team_sortedId;



    
    IBOutlet UIButton *btn_Event;
    IBOutlet UIButton *btn_City;
    IBOutlet UIButton *btn_Date;
    IBOutlet UIButton *btn_Location;
    IBOutlet UIButton *btn_Team;
    IBOutlet UIButton *btn_Gym;
    IBOutlet UIButton *btn_Level;

    IBOutlet UIButton *btn_Search,*btn_Clear;
    
    IBOutlet UITextField *txt_Event;
    IBOutlet UITextField *txt_City;
    IBOutlet UITextField *txt_Date;
    IBOutlet UITextField *txt_Team;
    IBOutlet UITextField *txt_Location;
    IBOutlet UITextField *txt_Gym;
    IBOutlet UITextField *txt_Level;



    
    UIPickerView *pickview;
    IBOutlet  UIView *picker_uiview;
    IBOutlet UIScrollView *Scroll_search;
    int Tag_dropdown;
    
   
    NSMutableArray *sortedArray,*sortedArrayIDS;
    
    NSMutableArray *ar_teams,*ar_teams_Names,*ar_teams_IDs;
    NSString *IDS_Event,*IDS_City,*IDS_Date,*IDS_Gym,*IDS_Level,*IDS_Team;
     NSArray *AftersortedAryIDS;
    IBOutlet UILabel *TeamnameTitle,*GymnameTitle,*CitynameTitle,*DatenameTitle,*LevelnameTitle;
    
    
}
@property(nonatomic,retain) UIPopoverController *aPopover;
@property(nonatomic,retain) UIViewController *popView;
@property(nonatomic,strong)UIView *view_SearchView;
-(IBAction)btn_Search:(id)sender;

-(IBAction)btn_Done_From_pickerView:(id)sender;
- (IBAction)btn_clicked_For_Search:(id)sender;
-(IBAction)logoutBtn_Clicked_frmSearch:(id)sender;


-(IBAction)btn_BackFromBigSearch:(id)sender;
-(IBAction)clearBtn_Clicked:(id)sender;

@end
