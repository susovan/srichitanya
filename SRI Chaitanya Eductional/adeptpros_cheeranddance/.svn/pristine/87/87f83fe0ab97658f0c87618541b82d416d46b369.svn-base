//
//  TeamSummaryViewController.h
//  Cheer&Dance
//
//  Created by Amit on 4/4/14.
//  Copyright (c) 2014 Adeptpros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebService.h"
#import "JSON.h"
#import "ServiceEngine.h"
@interface TeamSummaryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,WebServiceCompleteDelegate,UIAlertViewDelegate,UITextFieldDelegate,UITextViewDelegate,WebServiceDelegte>

{
    int checkEmptyCount;
    
    NSDictionary *screenTypeDict_build;
    NSDictionary *screenTypeDict_tum;
    NSDictionary *screenTypeDict_cho;
    NSDictionary *screenTypeDict_ded;
    
    // save using ratingtitle id
    NSArray *RatingTile_IDArray_build;
    NSArray *RatingTile_IDArray_tumb;
    NSArray *RatingTile_IDArray_cho;
    NSArray *RatingTile_IDArray_ded;


    NSArray *keyOrder_build;
    NSArray *keyOrder_tumb;
    NSArray *keyOrder_cho;
     NSArray *keyOrder_deduct;
    
    // building skill
    NSMutableDictionary *txtDict;
    NSMutableDictionary *AddBtnDict;
    NSMutableDictionary *SubBtnDict;
    NSMutableDictionary *txtValDict;
    NSMutableDictionary *finalValDict;
    NSMutableDictionary *ComntDict;
    // tum edit
    NSMutableDictionary *txtDict_tum;
    NSMutableDictionary *AddBtnDict_tum;
    NSMutableDictionary *SubBtnDict_tum;
    NSMutableDictionary *txtValDict_tum;
    NSMutableDictionary *finalValDict_tum;
    NSMutableDictionary *ComntDict_tum;

    // choreo
    NSMutableDictionary *txtDict_cho;
    NSMutableDictionary *AddBtnDict_cho;
    NSMutableDictionary *SubBtnDict_cho;
    NSMutableDictionary *txtValDict_cho;
    NSMutableDictionary *finalValDict_cho;
    NSMutableDictionary *ComntDict_cho;
    
    
    //deduction
    
    NSMutableDictionary *AddBtnDict_ded;
    NSMutableDictionary *SubBtnDict_ded;
    NSMutableDictionary *txtValDict_ded;
    NSMutableDictionary *finalValDict_ded;
    NSMutableDictionary *scoreTempDict;
    
    
    //edit fun
    BOOL Editflag;
    IBOutlet UIButton *btn_Edit;
    
    
     UITableView *team_Tableview;
    
     WebService *m_pWebService;
    NSString *CheckWebService;
    NSDictionary *dict_Summary;
    IBOutlet UILabel *lbl_Sumry_Team_Name,*lbl_Sumry_Stunts_Score,*lbl_Sumry_Tumbling_Score,*lbl_Sumry_Choreo_Score,*lbl_Sumry_Deduction_Score,*lbl_Sumry_Total_Score,*lbl_Sumry_Dance_Score;
    IBOutlet UILabel *lbl_Sumry_Date_Head,*lbl_Sumry_Event_Title_Head;
    //for font and alignment
    IBOutlet UILabel *lbl_Sumry_Team_Name_head,*lbl_Sumry_Stunts_Score_head,*lbl_Sumry_Tumbling_Score_head,*lbl_Sumry_Choreo_Score_head,*lbl_Sumry_Deduction_Score_head,*lbl_Sumry_Total_Score_head,*lbl_Sumry_Dance_Score_head;
    
    IBOutlet UIButton *btn_NotApprove,*btn_Approve,*btn_NotApprove_Later;
    
    IBOutlet UIView *view_TimeStamp;
    
    UILabel *lbs_finalscore;
    
   
}
-(void)subtbtnclicked:(UIButton *)sender;
-(void)addbtnclicked:(UIButton *)sender;

-(void)subtbtnclicked_tum:(UIButton *)sender;
-(void)addbtnclicked_tum:(UIButton *)sender;

-(void)subtbtnclicked_cho:(UIButton *)sender;
-(void)addbtnclicked_cho:(UIButton *)sender;

-(void)subtbtnclicked_ded:(UIButton *)sender;
-(void)addbtnclicked_ded:(UIButton *)sender;

//-(IBAction)back_Button:(id)sender;
-(IBAction)btn_Click_NotApprove:(id)sender;
-(IBAction)btn_Click_Approve:(id)sender;
//-(IBAction)btn_Click_Approve_Later:(id)sender;



//edit
-(IBAction)Editbtn_clicked:(id)sender;

-(void)saveEditScore_tumb;
-(void)saveEditScore_choreo;
-(void)saveEditScore_ded;


@end
