//
//  ViewController.h
//  Cheer&Dance
//
//  Created by KUNDAN on 12/30/13.
//  Copyright (c) 2013 Adeptpros. All rights reserved.
//

#define kBorderInset            20.0
#define kBorderWidth            1.0
#define kMarginInset            10.0

//Line drawing
#define kLineWidth              1.0

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "WebService.h"
#import "ServiceEngine.h"


@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate ,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate,UIPopoverControllerDelegate,UIScrollViewDelegate,WebServiceCompleteDelegate,UIGestureRecognizerDelegate,UITextViewDelegate,WebServiceDelegte>
{
   
    NSMutableDictionary *Dict_givenRating;
    
    NSString *new_checkWebservices;
    
    IBOutlet UIImageView *img_dropdown;
    
    int EmptyCountval;
    
    UIAlertView *checkEmptyAlert;
    
    int totalDivisionVal;
    IBOutlet UILabel *lbl_divisionTitle;
    IBOutlet UILabel *lbl_levelTitle;
    
    //for next loading automatic next team
    
    NSDictionary *Dict_session;
    NSMutableArray *array_List;
    NSMutableArray *ar_secTeam;
    NSMutableArray *ar_secTeam_level;
    NSMutableArray *ar_secTeam_div;
    NSMutableArray *ar_secTeam_location;
    int nextTeam_index;
//
    
    
    
    //below checkbox and label reespecitve dicts
    NSDictionary *deddict;
    NSMutableDictionary *DictCheckBtn_stunt;
    NSMutableDictionary *DictCheckLbl_stunt;
    NSMutableDictionary *DictCheckBtn_Dance;
    NSMutableDictionary *DictCheckLbl_Dance;
    NSMutableDictionary *DictCheckBtn_choreo;
    NSMutableDictionary *DictCheckLbl_choreo;
    NSMutableDictionary *DictCheckBtn_tumble;
    NSMutableDictionary *DictCheckLbl_tumble;
    //above checkbox and label respecitve
    
    BOOL b1,b2,b3,b4,b5,mybool,b6,b7,b8;
    BOOL bst;
    
    
    NSMutableDictionary *heightForCell;
    int count;
    
    
    NSDictionary *perfType_Dict_result;
    
    NSMutableArray *containsArray;
    NSMutableArray *containsArrayTumble;
    NSMutableArray *containsArrayChoreo;
    NSMutableArray *containsArrayDance;
    
    
 
    
        UIAlertView *logoutAlert;
    
    NSMutableDictionary *diction;
    NSMutableDictionary *dictionTumble;
    NSMutableDictionary *dictionChoreo;
    NSMutableDictionary *dictionDance;
    
    
    int j;
    // NSMutableArray *lbl;
    
    
    
    
    NSMutableDictionary *indexDict;
    NSMutableDictionary *array123Dict;
    
    
    //belw sets of array having divide by hard code values dont touch
    NSMutableDictionary *txtFiledDict;
    NSMutableDictionary *divLableDict;
    NSMutableArray *ardivLbl1;
    NSMutableArray *ardivLbl2;
    NSMutableArray *ardivLbl3;
    
    NSMutableDictionary *divLableDict_tumble;
    NSMutableArray *ardivLbl1_tum;
    NSMutableArray *ardivLbl2_tum;
    NSMutableArray *ardivLbl3_tum;
    
    NSMutableDictionary *divLableDict_choreo;
    NSMutableArray *ardivLbl1_choreo;
    NSMutableArray *ardivLbl2_choreo;
    NSMutableArray *ardivLbl3_choreo;
    
    NSMutableDictionary *divLableDict_dance;
    NSMutableArray *ardivLbl1_dance;
    NSMutableArray *ardivLbl2_dance;
    NSMutableArray *ardivLbl3_dance;
    NSMutableArray *ardivLbl4_dance;
    
    //above sets of array having divide by hard code values dont touch
    
    NSMutableArray *ar_Total_lab;
    NSMutableArray *ar_Total_txt;
    NSMutableArray *ar_total_lab_data;
    NSMutableArray *ar_total_div_data;
    
    
    
    // Kunda
    NSMutableArray *ar_ded_heading;
    //deduction things
    NSMutableDictionary *total_Sum;
    NSMutableDictionary *dedDict;
    NSMutableDictionary *dedDict_indexPath;
    NSMutableDictionary *dedDict_Button;
    NSMutableDictionary *dedDict_indexPath_Button;
    NSMutableDictionary *dedDict_Button_Minus;
    NSMutableDictionary *dedDict_indexPath_Button_Minus;
    NSMutableDictionary *ded_lblValues;
    NSMutableDictionary *checkDed;
    NSMutableDictionary *dedDict_Total_Lbl;
    
    //for timer
    
    UIButton *btn_Start;
    
    NSTimer *timer;
    int secondsLeft;
    
    int hours;
    int minutes;
    int seconds;
    
    
    NSMutableDictionary *dedDict_timeStamp_Lbl;
    
    NSMutableDictionary *dedDict_IndexPath_Total_Lbl;
    
    NSMutableDictionary   *dedDict_IndexPath_Total_Lbl_Save;
    
    //for timer
    NSMutableDictionary *dedDict_IndexPath_Total_Lbl_timeStamp;
    
    NSMutableDictionary *dedDict_IndexPath_Total_Lbl_timeStamp_Save;
    
    NSMutableDictionary  *main_Dict_Save;
    
    //for timer
    
    NSMutableDictionary *main_Dict_TimeStamp_Save;
    
   
    
    
    NSString *add;
    float values;
    NSMutableArray *ars;
    
    NSMutableDictionary *main_Dict;
    NSMutableDictionary *main_Dict_final;
    
    float ftotal;
    float falt;
    NSArray *sort;
    
    int kundan_Check_ded;
    

    
    //after copied from .m file to public instance variable before it was hidden(private)
    IBOutlet UIButton *btn_team_Summery;
    
    int DivScore_stunt,DivScore_tumble,DivScore_choreo,DivScore_dance;
    BOOL isMoreButtonTouched;
    int indexOfMoreButton;
    
    NSMutableDictionary *scoreDictmain;
    NSMutableDictionary *scoreDict;

    
    IBOutlet UILabel *lbl_overAll_divFive_tum;
    
    IBOutlet UILabel *lbl_totalScoreTitle_inDedution;
   
    IBOutlet UILabel *lbl_header_inOverAllComment;
    IBOutlet UILabel *lbl_header_Comment;
    
    IBOutlet UILabel *lbl_header_CommentNew;

    
    
    IBOutlet UIButton *btn_submitFrom_commentNew;

   
  
    NSMutableArray *unsortedScores;
    NSArray *sortedArray;
    
    
    
    IBOutlet UIImageView *judgepicipad,*judgepicipad_Bg;
    
    IBOutlet UITextField *tf_gym;
    IBOutlet UITextField *tf_level;
    IBOutlet UITextField *tf_dropdown;
    IBOutlet UITextView *comment_vf;
    IBOutlet UITextView *comment_vf_Overall;
    IBOutlet UIButton *btn_submitFrom_comment;
    IBOutlet UIView *deductionView,*headjudge_Sumary_View;

    int index;
    
    UIPickerView *pickview;
    float sum;
     float StuntsumFloat,ThumbsumFloat,ChoreosumFloat,DancesumFloat;
    NSString *str;
 
  
    NSMutableArray *gymArray;
    NSMutableArray *teamArray,*teamIDArray;
 
    
    
    NSMutableArray *dropdownArray,*dropdownArray_ID,*dropdownArray1,*dropdownArray_ID1;
    
    
    IBOutlet UIButton *btn_Selected_cat;

    UIPickerView *categPicker;
    NSArray *array_cat_type_stunts;
    NSArray *ar_cat_type_tumbling;
    NSString *value;
    NSArray *arr_postion_points;
    
    // for ductioncell
    
    NSMutableArray *ar_Ded_Label;
    
    
    
    NSMutableArray *array_cellLbl_tumbling;
    NSMutableArray *array_cellLbl_stuntToss;
    NSMutableArray *array_cellLbl_pyramind;
    NSMutableArray *array_cellLbl_perfection;
    NSMutableArray *array_cellLbl_sportsman;
    
    
    IBOutlet UILabel *lbl_total_heading;
    IBOutlet UILabel *lbl_total_deduction;
    IBOutlet UIImageView *img_total_headingImage;


    

    IBOutlet UILabel *lbl_scor_header;
    IBOutlet UILabel *lbl_scor_title;
    IBOutlet UILabel *lbl_scor_div_five;
    IBOutlet UITextField *txt_scor_value;
    
    //this is for tumb/choreo new view connetion of overallimpression
    IBOutlet UILabel *lbl_overAll_impr_title_tc;
    IBOutlet UILabel *lbl_overAll_impr_score_title_tc;
        IBOutlet UILabel *lbl_overAll_impr_judgeComm_tc;
    IBOutlet UIButton *btn_judgeComm_tc;
     IBOutlet UITextField *txt_overAll_impr_scor_value_tc;

    
    //here new view connection of tumb/choreo of totalscore
    IBOutlet UILabel *lbl_totalScore_title_tc;
    IBOutlet UILabel *lbl_totalScore_value_tc;
    
    
    
    IBOutlet UILabel *lbl_overAll_impr_title;
    IBOutlet UILabel *lbl_overAll_impr_score_title;
    IBOutlet UILabel *lbl_overAll_impr_divFive;
    IBOutlet UILabel *lbl_overAll_impr_judgeComm;
    IBOutlet UIButton *btn_judgeComm;
    
    
    IBOutlet UILabel *lbl_totalScore_title;
    

    IBOutlet UILabel *catLable;
    
    

    IBOutlet UIButton *btn_rankEvent;

    
    
    UIButton *btn_Done;
    BOOL ischecked1;
       BOOL ischecked2;
       BOOL ischecked3;
       BOOL ischecked4;
    
    IBOutlet UIView *overAll_imp_comt_View,*overAll_imp_comt_View_New1;
    
    
    NSString *lbl_Heading_str_value;

    IBOutlet  UIView *picker_uiview;
    
    
    
    IBOutlet UILabel *lbl_Head_Date_title;
    IBOutlet UILabel *lbl_Main_header;
    IBOutlet UILabel *lbl_main_cheer_name;
    IBOutlet UILabel *lbl_main_cheer_address;

  

    NSDictionary *TotalDict;
    NSArray *FinalAry;
    UIAlertView *commentAlert,*saveComment_Alert,*saveComment_Alert1,*savePerformance_Alert,*NextTeamAlert,*NoMoreTeam_alert;
    
      double lbl_1stline_leftval_atIndex0;
    
    
    
    IBOutlet UIView *stuntsView;
    IBOutlet UIView *view_Tumb_Choreo;
    
 
   
  
    WebService *m_pWebService;
    NSString *CheckWebService;
    NSMutableArray *per_resultAry,*titles_resultAry,*ratingTitle_IDAry,*ratingTF_ValueAry;
    NSString *dropdownArray_IDSTR;
    NSArray *sortedAry;
    float Dedutionsumfloat;
    float Finalsumfloat;
   IBOutlet UILabel *lbl_totalScore_value_inDeduction;
    NSString *Overall_commentValue,*teamID;
    NSMutableString *subTypeSTR;
    
    NSString *stunt_OverallCommentSTR1,*thumb_OverallCommentSTR1,*choreo_OverallCommentSTR1,*Dance_OverallCommentSTR1;
    NSString *tumble_overallScore,*choreo_overallScore,*Dance_overallScore;
  
  

    NSArray *sortedArray1;
   
    
    //deduction things
    NSMutableArray *commentStore_indedction;
        
    
    
       // kundan
    NSArray *Ary_getcomments;
    NSMutableDictionary *res_dict_comments;
    
    
    //for timer
     UILabel *showTime;
    UIImageView *img_timer_box;
    
    NSTimer *stopTimer;
    NSDate *startDate;
    BOOL running;
    
   UIImageView *img_Timer_Backgrnd;
    
    IBOutlet UILabel *lbl_First5Sec;
    IBOutlet UILabel *lbl_Second5Sec;
    IBOutlet UILabel *lbl_Third5Sec;

    IBOutlet UILabel *totalscrore_lbl;
    
}
//for timer
-(void)starts;




-(IBAction)overAll_imp_comnt_clicked1:(id)sender;

@property(strong,nonatomic)UIPopoverController *popOverControllerObj;
@property(strong,nonatomic)UIViewController *viewControllerPop;
@property(strong,nonatomic) IBOutlet UILabel *totalscrore_lbl;
@property(strong,nonatomic) IBOutlet UITextField *overallimpression_tf;
@property(strong,nonatomic)IBOutlet UITableView *tableview1;
@property(strong,nonatomic)IBOutlet UIButton *btn_submit;

@property(nonatomic,retain) UIPopoverController *aPopover;
@property(nonatomic,retain) UIViewController *popView;

// Kundan
@property(strong,nonatomic) NSMutableDictionary *mainScoreDict;
@property(strong,nonatomic) NSMutableDictionary *mainScoreDict_tumbling;
@property(strong,nonatomic) NSMutableDictionary *mainScoreDict_choreoghaphy;
@property(strong,nonatomic) NSMutableDictionary *mainScoreDict_Dance;

// Rating TF
@property(strong,nonatomic)UIDocumentInteractionController *docController;

//@property(strong,nonatomic) UITextField *ratingTf_Values;
- (IBAction)cancelfromcomtview_clicked:(id)sender;
- (IBAction)cancelfromcomtview_clickedFrom_Overall:(id)sender;

- (IBAction)commentSubmitbtn_clicked:(id)sender;
- (IBAction)commentSubmitbtn_clickedFrom_Overall:(id)sender;

- (IBAction)pickbtn_clicked:(id)sender;
-(IBAction)done_FromPickerView:(id)sender;
-(IBAction)logoutBtn_Clicked:(id)sender;
-(IBAction)submitBtn_Values:(id)sender;
-(IBAction)backBtn_selected:(id)sender;

//left/right button

-(IBAction)leftPan_Clicked:(id)sender;


-(IBAction)rankingEventBtn_Clicked:(id)sender;



@end
