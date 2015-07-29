
//
//  ViewController.m
//  Cheer&Dance

//  Created by KUNDAN on 12/30/13.
//  Copyright (c) 2013 Adeptpros. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"
#import "CustomCell.h"
#import "DeductionCell.h"
#import "Singleton.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "JSON.h"
#import "Defines.h"
#import "SearchViewController.h"
#import "JASidePanelController.h"
#import "MFSideMenuContainerViewController.h"
#import "LeftPaneViewController1.h"
#import "LoginViewController.h"
#import "NSString+dsfcs.h"
#import "RankingEventViewController.h"
#import "TeamSummaryViewController.h"
#import "ScheduleScreenViewController.h"

#define ACCEPTABLE_CHARECTERS @"ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_- "
#define ACCEPTABLE_CHARECTERS1 @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_- "
#define ACCEPTABLE_CHARECTERSstudentID @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_- "
#define ACCEPTABLE_CHARECTERS1parentEmailID @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ~@!#$%^&*()_+-={}[]:;?/><,.1234567890 "
#define Email_CharSet @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"

NSArray *ars;
NSString *doneValue;
 BOOL bs1=YES;
BOOL bs2=YES;
BOOL bs3=YES;
@implementation ViewController
@synthesize tableview1,overallimpression_tf,totalscrore_lbl,btn_submit,viewControllerPop,popOverControllerObj;
@synthesize mainScoreDict = _mainScoreDict;
@synthesize mainScoreDict_tumbling = _mainScoreDict_tumbling;
@synthesize mainScoreDict_choreoghaphy = _mainScoreDict_choreoghaphy;
@synthesize mainScoreDict_Dance = _mainScoreDict_Dance;
@synthesize docController;

- (void)viewDidLoad
{
    Dict_givenRating =[[NSMutableDictionary alloc]init];
    dropdownArray1=[[NSMutableArray alloc]init];
    dropdownArray_ID1=[[NSMutableArray alloc]init];
    
    //for next loading automatic next team
    Singleton *s=[Singleton getObject];
    
    [btn_Selected_cat setUserInteractionEnabled:YES];
    
    // screen access
    
    
    if ([[s.AccessScreenArray1 objectAtIndex:0]isEqualToString:@"1"])
    {
        img_dropdown.image=[UIImage imageNamed:@"dropdown2@2x.png"];
        btn_rankEvent.hidden =NO;
        btn_team_Summery.hidden=NO;
        btn_team_Summery.frame=CGRectMake(723, 390, 280, 44);
        btn_team_Summery.titleLabel.font=[UIFont fontWithName:@"Enigmatic" size:24];
        [btn_team_Summery addTarget:self action:@selector(teamSummaryBtn_Clicked) forControlEvents:UIControlEventTouchUpInside];
    }
    
    else
    {
        btn_rankEvent.hidden =YES;
        btn_team_Summery.hidden=YES;
        img_dropdown.image=[UIImage imageNamed:@"dropdown2@2x.png"];

    }
    
//    if ([[s.AccessScreenArray objectAtIndex:0] intValue]==4)//(s.AccessScreenArray.count>1)
//    {
//        [btn_Selected_cat setUserInteractionEnabled:YES];
//        btn_rankEvent.hidden =NO;
//        img_dropdown.image=[UIImage imageNamed:@"dropdown2@2x.png"];
//        //tf_dropdown.hidden=NO;
//    }
//    else
//    {
//      [btn_Selected_cat setUserInteractionEnabled:YES];
//       btn_rankEvent.hidden=YES;
//        //img_dropdown.image=[UIImage imageNamed:@"submit-button@2x.png"];
//        img_dropdown.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"total-scores.png"]];//[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
//        //tf_dropdown.hidden=YES;
//    }
    
    
    nextTeam_index=[s.leftpan_selecteTeam intValue];
    nextTeam_index++;
    
    Dict_session=[[NSDictionary alloc]init];
    array_List=[[NSMutableArray alloc]init];
    ar_secTeam=[[NSMutableArray alloc]init];
    ar_secTeam_level=[[NSMutableArray alloc]init];
    ar_secTeam_div=[[NSMutableArray alloc]init];
    ar_secTeam_location=[[NSMutableArray alloc]init];
    
    
    Dict_session=s.Dict_schNextTeam;
    NSArray *ar_key=[s.Dict_schNextTeam  allKeys];
    
    NSArray *sortArray= [ar_key sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    
    int l=0;
    
    for (int i=0; i<[sortArray count]; i++)
    {
        
        NSArray *temp=[Dict_session objectForKey:[sortArray objectAtIndex:i]];
        
        for (int k=0; k<temp.count; k++)
        {
            
            
            [array_List insertObject:[[temp objectAtIndex:k] objectForKey:@"team_name"] atIndex:l];
            [ar_secTeam insertObject:[[temp objectAtIndex:k] objectForKey:@"team_id"] atIndex:l];
            [ar_secTeam_level insertObject:[[temp objectAtIndex:k] objectForKey:@"team_level"] atIndex:l];
            [ar_secTeam_div insertObject:[[temp objectAtIndex:k] objectForKey:@"division"] atIndex:l];
            [ar_secTeam_location insertObject:[[temp objectAtIndex:k] objectForKey:@"location"] atIndex:l];
            
            l++;
            
        }
        
        
    }
    
    
    
    //
      [super viewDidLoad];
    
    
    //setting font and color in method those were in viewDidLoad
    
    img_total_headingImage.hidden=YES;
    
    lbl_total_deduction.hidden=YES;
    lbl_total_heading.hidden=YES;

    
    kundan_Check_ded=0;
 //   btn_team_Summery.hidden=YES;
    btn_Start=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn_Start setFrame:CGRectMake(454-30, 141, 46, 30)];
    [btn_Start setBackgroundImage:[UIImage imageNamed:@"submit-overall-skill.png"] forState:UIControlStateNormal];
    [btn_Start addTarget:self action:@selector(starts) forControlEvents:UIControlEventTouchUpInside];
    [btn_Start setTitle:@"Start" forState:UIControlStateNormal];
    [[self view]addSubview:btn_Start];
    
    img_Timer_Backgrnd=[[UIImageView alloc]initWithFrame:CGRectMake(513-30, 141, 115, 30)];
    [img_Timer_Backgrnd setImage:[UIImage imageNamed:@"text-box.png"]];
    [[self view]addSubview:img_Timer_Backgrnd];
    showTime=[[UILabel alloc]initWithFrame:CGRectMake(535-30, 145, 84, 25)];
    [[self view]addSubview:showTime];

     //for timer
    showTime.text = @"00.00.00";
    showTime.hidden=YES;
    btn_Start.hidden=YES;
    img_Timer_Backgrnd.hidden=YES;
    
    
    
    //running = NO;
   
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]init];
    [longPressGesture setMinimumPressDuration:0.2];
    longPressGesture.delegate = self;
    [self.view addGestureRecognizer:longPressGesture];
    
   
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(leftPan_Clicked:) name:@"CallSlideOut" object:nil];
    
    isMoreButtonTouched=NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myKeyboardWillHideHandler:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    lbl_totalScore_value_inDeduction.text=@"0.0";
    [[self view]setUserInteractionEnabled:YES];
    
    Dedutionsumfloat = 0.0f;
    falt=0.0f;
    
    
    total_Sum=[[NSMutableDictionary alloc]init];
    
    ftotal=0.0f;
    
    main_Dict_final=[[NSMutableDictionary alloc]init];
    
    
    
    
 
    ars=[[NSMutableArray alloc]init];
    for(int i=0;i<3;i++)
        
    {
        
        [ars addObject:@"0.0"];
        
    }
    checkDed=[[NSMutableDictionary alloc]init];
    ded_lblValues=[[NSMutableDictionary alloc]init];
    
    values=0;
    dedDict_indexPath=[[NSMutableDictionary alloc]init];
    dedDict_indexPath_Button=[[NSMutableDictionary alloc]init];
    dedDict_indexPath_Button_Minus=[[NSMutableDictionary alloc]init];
    
    mybool=YES;
    
    
    
    //in deduct txt
    
    
    b1=NO;
    b2=NO;
    b3=NO;
    b4=YES;
    b5=YES;
    b6=YES;
    
    b7=NO;
    b8=YES;
    
    
    // Get loginUser ID
    
    Singleton *s_Obj=[Singleton getObject];
    NSLog(@"LoginUserID=%@",[s_Obj loginUserID]);
    
    dropdownArray_IDSTR=[[NSMutableString alloc]init];
    
    //  geting screen ID from singletone
    
    
  
    
    Singleton *s2=[Singleton getObject];
    
    dropdownArray_IDSTR=[[[s2 screenID]componentsSeparatedByString:@","]objectAtIndex:0];
    
  
    
    //if ([[s2 checkleftpanelID] isEqualToString:@"100"]) {
        
    
       // stunts
    ardivLbl1=[[NSMutableArray alloc]initWithObjects:@"/5",@"/5",@"/5", nil];
    ardivLbl2=[[NSMutableArray alloc]initWithObjects:@"/5",@"/5",@"/5", nil];
    ardivLbl3=[[NSMutableArray alloc]initWithObjects:@"/10",@"/10",@"/", nil];

    divLableDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:ardivLbl1,[NSNumber numberWithInt:0],ardivLbl2,[NSNumber numberWithInt: 1],ardivLbl3,[NSNumber numberWithInt:2], nil];
    
    // tumbling
    ardivLbl1_tum=[[NSMutableArray alloc]initWithObjects:@"/5",@"/10",@"/5", nil];
    ardivLbl2_tum=[[NSMutableArray alloc]initWithObjects:@"/5",@"/10",@"/", nil];
    ardivLbl3_tum=[[NSMutableArray alloc]initWithObjects:@"/5",@"/10",@"/", nil];
    
    divLableDict_tumble=[[NSMutableDictionary alloc]initWithObjectsAndKeys:ardivLbl1_tum,[NSNumber numberWithInt:0],ardivLbl2_tum,[NSNumber numberWithInt: 1],ardivLbl3_tum,[NSNumber numberWithInt:2], nil];
    
    // choreography
    ardivLbl1_choreo=[[NSMutableArray alloc]initWithObjects:@"/10",@"/10",@"/", nil];
    ardivLbl2_choreo=[[NSMutableArray alloc]initWithObjects:@"/10",@"/10",@"/", nil];
    ardivLbl3_choreo=[[NSMutableArray alloc]initWithObjects:@"/",@"/",@"/", nil];
    
    divLableDict_choreo=[[NSMutableDictionary alloc]initWithObjectsAndKeys:ardivLbl1_choreo,[NSNumber numberWithInt:0],ardivLbl2_choreo,[NSNumber numberWithInt: 1],ardivLbl3_choreo,[NSNumber numberWithInt:2], nil];
    // dancse
    ardivLbl1_dance=[[NSMutableArray alloc]initWithObjects:@"/10",@"/10",@"/10", nil];
    ardivLbl2_dance=[[NSMutableArray alloc]initWithObjects:@"/10",@"/10",@"/", nil];
    ardivLbl3_dance=[[NSMutableArray alloc]initWithObjects:@"/10",@"/10",@"/", nil];
    ardivLbl4_dance=[[NSMutableArray alloc]initWithObjects:@"/10",@"/10",@"/10", nil];

    
    divLableDict_dance=[[NSMutableDictionary alloc]initWithObjectsAndKeys:ardivLbl1_dance,[NSNumber numberWithInt:0],ardivLbl2_dance,[NSNumber numberWithInt: 1],ardivLbl3_dance,[NSNumber numberWithInt:2],ardivLbl4_dance,[NSNumber numberWithInt:3], nil];

   // sum of dividers
    /*for (int i=0; i<3; i++)
    {
        
        DivScore_stunt+=[[[ardivLbl1 objectAtIndex:i] stringByReplacingOccurrencesOfString:@"/" withString:@""] intValue]+[[[ardivLbl2 objectAtIndex:i] stringByReplacingOccurrencesOfString:@"/" withString:@""] intValue]+[[[ardivLbl3 objectAtIndex:i] stringByReplacingOccurrencesOfString:@"/" withString:@""] intValue];
        
        NSLog(@"stunt divider:%d",DivScore_stunt);
        
        DivScore_tumble+=[[[ardivLbl1_tum objectAtIndex:i] stringByReplacingOccurrencesOfString:@"/" withString:@""] intValue]+[[[ardivLbl2_tum objectAtIndex:i] stringByReplacingOccurrencesOfString:@"/" withString:@""] intValue]+[[[ardivLbl3_tum objectAtIndex:i] stringByReplacingOccurrencesOfString:@"/" withString:@""] intValue];
        
        NSLog(@"tumbling divider:%d",DivScore_tumble);
        
        DivScore_choreo+=[[[ardivLbl1_choreo objectAtIndex:i] stringByReplacingOccurrencesOfString:@"/" withString:@""] intValue]+[[[ardivLbl2_choreo objectAtIndex:i] stringByReplacingOccurrencesOfString:@"/" withString:@""] intValue]+[[[ardivLbl3_choreo objectAtIndex:i] stringByReplacingOccurrencesOfString:@"/" withString:@""] intValue];
        
        NSLog(@" choreo divider:%d",DivScore_choreo);
        
        
        DivScore_dance+=[[[ardivLbl1_dance objectAtIndex:i] stringByReplacingOccurrencesOfString:@"/" withString:@""] intValue]+[[[ardivLbl2_dance objectAtIndex:i] stringByReplacingOccurrencesOfString:@"/" withString:@""] intValue]+[[[ardivLbl3_dance objectAtIndex:i] stringByReplacingOccurrencesOfString:@"/" withString:@""] intValue]+[[[ardivLbl4_dance objectAtIndex:i] stringByReplacingOccurrencesOfString:@"/" withString:@""] intValue];
        
        NSLog(@"Dance divider:%d",DivScore_dance);
        
        
    }*/
    
    
    //by default storing untick images
    containsArray=[[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"", nil];
    containsArrayTumble =[[NSMutableArray alloc]initWithObjects:@"",@"",@"", nil];
    containsArrayChoreo=[[NSMutableArray alloc]initWithObjects:@"",@"",@"", nil];
    containsArrayDance=[[NSMutableArray alloc]initWithObjects:@"",@"",@"", nil];

   
    
    
    diction=[[NSMutableDictionary alloc]init];
    dictionTumble=[[NSMutableDictionary alloc]init];
    dictionChoreo=[[NSMutableDictionary alloc]init];
    dictionDance=[[NSMutableDictionary alloc]init];

        
        Singleton *st=[Singleton getObject];
    lbl_Head_Date_title.text=[NSString stringWithFormat:@"%@",[st date_Name]];
    
    
    //totalscrore_lbl.text=[NSString stringWithFormat:@"%.1f/%d",StuntsumFloat,DivScore_stunt];

    
    //judgepicipad.layer.borderWidth=1.0;
    judgepicipad.layer.masksToBounds=YES;
    judgepicipad.layer.cornerRadius=3.0f;
    

    [lbl_Main_header setText:@"Score Sheet"];
    judgepicipad_Bg.hidden=YES;
  
    
    //]WithObjects:@"STUNTS/PYRAMIDS/TOSSES",@"TUMBLING/JUMPS",@"CHOREOGRAPHY",@"DEDUCTION/CUMULATIVE", nil];
   


    judgepicipad.layer.cornerRadius=25.0;
    judgepicipad.layer.masksToBounds=YES;
    
      /// Kundan
    //storing the values when updown cell and change screen from dropdown persist value
    _mainScoreDict=[[NSMutableDictionary alloc]init];
    _mainScoreDict_tumbling = [[NSMutableDictionary alloc]init];
    _mainScoreDict_choreoghaphy = [[NSMutableDictionary alloc]init];
    _mainScoreDict_Dance = [[NSMutableDictionary alloc]init];

    
    // Webservice for screen performance
    
    // http://joomerang.geniusport.com/cheerinfinity/webservices/getwbs_performances.php
    //http://54.191.2.63/spiritcentral_uat/webservices_dev/
    
    [self showBusyView];
    CheckWebService=@"Performance_Display";
    NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
    // [dct setObject:@"Used" forKey:@"type"];
    
    NSString *jsonstring1=[dct JSONRepresentation];
    ////NSLog(@"jsonstring=%@",jsonstring1);
    NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring1];
    ////NSLog(@"Post %@", post1);
    
    NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_performances.php",BASEURL];
    m_pWebService			= [[WebService alloc] initWebService:l_pURL];
    m_pWebService.mDelegate		= self;
    [m_pWebService  sendHTTPPost:post1];
    
    [self viewDidlLoadFontAndColorMethod];
    
}

-(void)viewWillAppear:(BOOL)animated
{

    
    [super viewWillAppear:YES];
    
   // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(leftPan_Clicked:) name:@"CallSlideOut" object:nil];
    
   
    
    tableview1.dataSource=self;
    tableview1.delegate=self;
  
    if (dropdownArray.count==0)
    {
        [view_Tumb_Choreo setHidden:YES];
        [deductionView setHidden:YES];
        [stuntsView setHidden:NO];
        [stuntsView setFrame:CGRectMake(724, 180, 280, 135)];
        [[self view]addSubview:stuntsView];
    }
    else if ([value isEqualToString:[dropdownArray objectAtIndex:0]])
    {
        
        [view_Tumb_Choreo setHidden:YES];
        [deductionView setHidden:YES];
        [stuntsView setHidden:NO];
        [stuntsView setFrame:CGRectMake(724, 180, 280, 135)];
        [[self view]addSubview:stuntsView];
    }
    else if ([value isEqualToString:[dropdownArray objectAtIndex:1]])
    {
        
        [view_Tumb_Choreo setHidden:NO];
        [deductionView setHidden:YES];
        [stuntsView setHidden:YES];
        //[[self view]addSubview:view_Tumb_Choreo];
    }
    else if ([value isEqualToString:[dropdownArray objectAtIndex:2]])
    {
        
        [view_Tumb_Choreo setHidden:NO];
        [deductionView setHidden:YES];
        [stuntsView setHidden:YES];
       // [[self view]addSubview:stuntsView];
    }
    else if ([value isEqualToString:[dropdownArray objectAtIndex:3]])
    {
        
        [view_Tumb_Choreo setHidden:YES];
        [deductionView setHidden:NO];
        [stuntsView setHidden:YES];
        //[[self view]addSubview:stuntsView];
    }
    
}
//delete tableveiw delegate and paste in category
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([dropdownArray count]==0)
    {
        return 0;
    }
    
    else if([value isEqualToString:[dropdownArray objectAtIndex:2]])
        
    {
        
        return [sortedAry count];//[ar count];
    }
    else if([value isEqualToString:[dropdownArray objectAtIndex:3]])
    {
        return 5;
    }
    else if([value isEqualToString:[dropdownArray objectAtIndex:1]])
    {
        
        return [sortedAry count];//5;
    }
    
    else
    {
        NSLog(@"stuntsScrren%lu",(unsigned long)[per_resultAry count]);
        return  [sortedAry count];//catAry.count;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    showTime.hidden=NO;
    btn_Start.hidden=NO;
    img_Timer_Backgrnd.hidden=NO;
    
    btn_submit.frame=CGRectMake(723, 335, 280, 44);
    
    
    if([value isEqualToString:[dropdownArray objectAtIndex:3]])
    {
        
        kundan_Check_ded=1;

        
        
        
        [ded_lblValues setObject:[[NSMutableArray alloc]init] forKey:[NSNumber numberWithInt:(int)indexPath.row]];
        
        
        
        
        [checkDed setObject:[[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:(int)indexPath.row], nil] forKey:[NSNumber numberWithInt:(int)indexPath.row]];
        
        NSLog(@"check==%@",[checkDed objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]);
        
        
        dedDict=[[NSMutableDictionary alloc]init];
        dedDict_Total_Lbl=[[NSMutableDictionary alloc]init];
        
        dedDict_timeStamp_Lbl=[[NSMutableDictionary alloc]init];
        
        dedDict_Button=[[NSMutableDictionary alloc]init];
        dedDict_Button_Minus=[[NSMutableDictionary alloc]init];
        
        
        
        
        //totalscrore_lbl.text=@"0.0";
        totalscrore_lbl.text=[NSString stringWithFormat:@"%.1f/%d",StuntsumFloat,DivScore_stunt];
        
        
        
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
        {
            tableview1.frame=CGRectMake(21, 187, 685, 519);
        }
        else
        {
            tableview1.frame=CGRectMake(21, 187, 685, 519);
        }
        
        img_total_headingImage.hidden=NO;
        
        lbl_total_deduction.hidden=NO;
        lbl_total_heading.hidden=NO;
        //btn_submit.frame=CGRectMake(723, 335, 280, 44);
      
        
        static NSString *Identifier=@"DeductionCell";
        DeductionCell *dcell =(DeductionCell *) [tableView dequeueReusableCellWithIdentifier:Identifier];
        
        if(dcell == nil)
        {
            NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"DeductionCell" owner:self options:nil];
            dcell=[topLevelObjects objectAtIndex:0];
        }
        dcell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
        [dcell.Deductcell_cmt_btn setTag:indexPath.row];
        [dcell.Deductcell_cmt_btn addTarget:self action:@selector(comntFromDeductcell:) forControlEvents:UIControlEventTouchUpInside];
        
        //font
        dcell.Lbl_cellHeading_fromDeduct1.font=[UIFont fontWithName:@"Enigmatic" size:16];
        dcell.Lbl_leftTitle_inDeduct.font=[UIFont fontWithName:@"Enigmatic" size:16];
        dcell.Lbl_centerTitle_inDeduct.font=[UIFont fontWithName:@"Enigmatic" size:16];
        dcell.Lbl_rightTitle_inDeduct.font=[UIFont fontWithName:@"Enigmatic" size:16];
        dcell.Lbl_deductionTitle_inDeduct.font=[UIFont fontWithName:@"Enigmatic" size:16];
        dcell.Lbl_commentsTitle_inDeduct.font=[UIFont fontWithName:@"Enigmatic" size:16];
        
        //textcolor
        
        dcell.Lbl_commentsTitle_inDeduct.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
        
             
        [dcell.Lbl_cellHeading_fromDeduct1 setText:[ar_ded_heading objectAtIndex:indexPath.row]];
        NSDictionary *dict1=  [array_cellLbl_tumbling objectAtIndex:indexPath.row];
        for(int i=0;i<[[dict1 allKeys]count];i++)
        {
            
            
            [dedDict setObject:[[NSMutableArray alloc]init] forKey:[NSNumber numberWithInt:i]];
            [dedDict_Button setObject:[[NSMutableArray alloc]init] forKey:[NSNumber numberWithInt:i]];
            [dedDict_Button_Minus setObject:[[NSMutableArray alloc]init] forKey:[NSNumber numberWithInt:i]];
            
            
        }
        
        
        NSDictionary *dict=  [array_cellLbl_tumbling objectAtIndex:indexPath.row];
        [dcell.Lbl_cellHeading_fromDeduct1 setText:[ar_ded_heading objectAtIndex:indexPath.row]];
        
        if([[dict allKeys]count]==0)
        {
            
        }
        else
        {
            
            for(int i=0;i<[[dict allKeys]count];i++)
            {
                
                //
                
                UILabel *lbl_SubCat=[[UILabel alloc]initWithFrame:CGRectMake(9, 55+i*30, 200, 30)];
                
                UILabel *lbl_Total=[[UILabel alloc]initWithFrame:CGRectMake(480, 55+i*30, 42, 21)];
                
                
                UILabel *lbl_timeStamp=[[UILabel alloc]initWithFrame:CGRectMake(520, 55+i*30, 150, 21)];
                
                // [lbl_timeStamp setText:@"hi"];
                
                
                for(int k=0;k<3;k++)
                {
                    
                    //   [main_Dict setObject:[[NSMutableArray alloc]init] forKey:[NSNumber numberWithInt:i]];
                    
                    // [ded_lblValues setObject:[[NSMutableArray alloc]init] forKey:[NSNumber numberWithInt:indexPath.row]];
                    
                    
                    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
                    [btn setFrame:CGRectMake(208+k*80, 55+i*30, 20, 20)];
                    [btn setBackgroundImage:[UIImage imageNamed:@"plus@2x.png"] forState:UIControlStateNormal];
                    
                    [btn setTag:indexPath.row];
                    [btn addTarget:self action:@selector(addbtn_clicked_fromDeduction:) forControlEvents:UIControlEventTouchUpInside];
                    [[dcell contentView]addSubview:btn];
                    
                    
                    UILabel *lbls=[[UILabel alloc]initWithFrame:CGRectMake(230+k*80, 55+i*30, 30, 30)];
                    lbls.font=[UIFont fontWithName:@"Enigmatic" size:15];
                    lbls.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
                    
                    
                    //[ded_notGoData setObject:[[NSMutableDictionary alloc]init] forKey:[NSNumber numberWithInt:0]];
                    
                    //[[ded_notGoData objectForKey:[NSNumber numberWithInt:0]]setObject:ars forKey:[NSNumber numberWithInt:0]];
                    // NSLog(@"yes+%@",[[ded_notGoData objectForKey:[NSNumber numberWithInt:indexPath.row]]objectForKey:[NSNumber numberWithInt:i]]);
                    //NSArray *tempArray=    [[ded_notGoData objectForKey:[NSNumber numberWithInt:0]]objectForKey:[NSNumber numberWithInt:0]];
                    
                    
                    
                    // [[[main_Dict_final objectForKey:[NSNumber numberWithInt:[sender tag]]]objectForKey:[NSNumber numberWithInt:i]]insertObject:[lb text] atIndex:k];
                    
                    
                    if([[[main_Dict_final objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]objectForKey:[NSNumber numberWithInt:i]]count]==0)
                    {
                        
                        //[lbls setText:@"0"];
                        
                        
                        lbls.text= [[[main_Dict_final objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]objectForKey:[NSNumber numberWithInt:i]]objectAtIndex:k];
                    }
                    else
                    {
                        
                        
                        
                        //UILabel *lbls=[[dedDict_IndexPath_Total_Lbl objectForKey:[NSNumber numberWithInt:[sender tag]]]objectForKey:[NSNumber numberWithInt:i]];
                        //[lbls setText:[NSString stringWithFormat:@"%.1f",x]];
                        
                        
                        
                        lbls.text=[[[main_Dict_final objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]objectForKey:[NSNumber numberWithInt:i]]objectAtIndex:k];
                        
                        
                        
                        lbl_Total.text=[[[dedDict_IndexPath_Total_Lbl_Save objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]objectForKey:[NSNumber numberWithInt:i]]objectAtIndex:0];
                        
                        
                        lbl_timeStamp.text=[NSString stringWithFormat:@"deducted at %@",[[[dedDict_IndexPath_Total_Lbl_timeStamp_Save objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]objectForKey:[NSNumber numberWithInt:i]]objectAtIndex:0]];
                        
                        
                        
                        
                        
                    }
                    
                    [[dcell contentView]addSubview:lbls];
                    
                    
                    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
                    [btn1 setFrame:CGRectMake(260+k*80, 55+i*30, 20, 20)];
                    [btn1 setBackgroundImage:[UIImage imageNamed:@"minus@2x.png"] forState:UIControlStateNormal];
                    
                    [btn1 setTag:indexPath.row];
                    [btn1 addTarget:self action:@selector(subtractbtn_clicked_fromDeduction:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [[dcell contentView]addSubview:btn1];
                    
                    
                    
                    
                    [[dedDict objectForKey:[NSNumber numberWithInt:i]]insertObject:lbls atIndex:k];
                    
                    [[dedDict_Button objectForKey:[NSNumber numberWithInt:i]]insertObject:btn atIndex:k];
                    
                    [[dedDict_Button_Minus objectForKey:[NSNumber numberWithInt:i]]insertObject:btn1 atIndex:k];
                    
                    
                }
                
                                
                
                
                NSArray *sortedArray1=[[dict allKeys]sortedArrayUsingComparator:^NSComparisonResult(id obj1,id obj2) {
                    if([obj1 integerValue]>[obj2 integerValue])
                    {
                        return NSOrderedDescending;
                        
                    }
                    else
                    {
                        return NSOrderedAscending;
                    }
                }];
                
                
                lbl_Total.font=[UIFont fontWithName:@"Enigmatic" size:15];
                lbl_Total.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
                
                
                lbl_timeStamp.font=[UIFont fontWithName:@"Enigmatic" size:15];
                lbl_timeStamp.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
                
                
                
                [[dcell contentView]addSubview:lbl_Total];
                
                //for timer
                [[dcell contentView]addSubview:lbl_timeStamp];
                
                lbl_SubCat.font=[UIFont fontWithName:@"Enigmatic" size:15];
                lbl_SubCat.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
                lbl_SubCat.text= [dict objectForKey:[sortedArray1 objectAtIndex:i]];
                
                [[dcell contentView]addSubview:lbl_SubCat];
                
                [dedDict_Total_Lbl setObject:lbl_Total forKey:[NSNumber numberWithInt:i]];
                
                [dedDict_timeStamp_Lbl setObject:lbl_timeStamp forKey:[NSNumber numberWithInt:i]];
                
                
                
                
            }
            [dedDict_IndexPath_Total_Lbl setObject:dedDict_Total_Lbl forKey:[NSNumber numberWithInt:(int)indexPath.row]];
            
            [dedDict_IndexPath_Total_Lbl_timeStamp setObject:dedDict_timeStamp_Lbl forKey:[NSNumber numberWithInt:(int)indexPath.row]];
            
            
            [dedDict_indexPath setObject:dedDict forKey:[NSNumber numberWithInt:(int)indexPath.row]];
            [dedDict_indexPath_Button setObject:dedDict_Button forKey:[NSNumber numberWithInt:(int)indexPath.row]];
            [dedDict_indexPath_Button_Minus setObject:dedDict_Button_Minus forKey:[NSNumber numberWithInt:(int)indexPath.row]];
            
            //  [main_Dict_final setObject:main_Dict forKey:[NSNumber numberWithInt:indexPath.row]];
            
            
        }
        
        dcell.Deductcell_cmt_btn.titleLabel.font=[UIFont fontWithName:@"Enigmatic" size:15];
        
        NSDictionary *dictd= [array_cellLbl_tumbling objectAtIndex:indexPath.row];
        
        if (dictd.allKeys.count<=3)
        {
            dcell.Deductcell_cmt_btn.frame=CGRectMake(601, 147,75, 26);
            
            
        }
        else
        {
            // dict.allKeys.count*45+44
            dcell.Deductcell_cmt_btn.frame=CGRectMake(601, dict.allKeys.count*32+44, 75, 26);
            
        }
        
        return dcell;
        
        
    }
    
    else
    {
        
   //     btn_team_Summery.hidden=YES;
        static NSString *Identifier=@"CustomCell";
        
        CustomCell *cell =(CustomCell *) [tableView dequeueReusableCellWithIdentifier:Identifier];
        
        if(cell == nil)
        {
            NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
            cell=[topLevelObjects objectAtIndex:0];
        }
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
        tableview1.backgroundColor=[UIColor clearColor];
        
        
        
        //ratingTf_Values.tag=indexPath.row;
        
        
        ////////////
        
        
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
        {
            
            tableview1.frame=CGRectMake(21, 187, 685, 561);
            
        }
        else
        {
            tableview1.frame=CGRectMake(21, 187, 685, 555);
        }
        
        
        
        //        cell.Lbl_headings.text=[array_cat_type_stunts objectAtIndex:indexPath.row];
        //        [[cell lbl_possible_points]setText:[arr_postion_points objectAtIndex:indexPath.row]];
        
        img_total_headingImage.hidden=YES;
        lbl_total_deduction.hidden=YES;
        lbl_total_heading.hidden=YES;
        
        //coment lbl font
        
        cell.more_btn.titleLabel.font=[UIFont fontWithName:@"Enigmatic" size:15];
        
        //comt lbl txtcolor
        
        
        
        cell.more_btn.tag=indexPath.row;
        
        
        if([[heightForCell objectForKey:[NSNumber numberWithInt:indexPath.row]]integerValue]<=3)
        {
            
            cell.img_div1.frame=CGRectMake(0, 44, 1, 145);
            cell.img_div2.frame=CGRectMake(190, 44, 1, 145);
            cell.img_div3.frame=CGRectMake(300, 44, 1, 145);
            cell.img_div4.frame=CGRectMake(684, 44, 1, 145);
        }
        else
        {
            
            cell.img_div1.frame=CGRectMake(0, 44, 1, [[heightForCell objectForKey:[NSNumber numberWithInt:indexPath.row]]integerValue]*49+44);
            cell.img_div2.frame=CGRectMake(190, 44, 1, [[heightForCell objectForKey:[NSNumber numberWithInt:indexPath.row]]integerValue]*49+44);
            cell.img_div3.frame=CGRectMake(300, 44, 1, [[heightForCell objectForKey:[NSNumber numberWithInt:indexPath.row]]integerValue]*49+44);
            cell.img_div4.frame=CGRectMake(684, 44, 1, [[heightForCell objectForKey:[NSNumber numberWithInt:indexPath.row]]integerValue]*49+44);
        }
        
        ///////////////////
        
        
        NSString *Fullstr=[res_dict_comments objectForKey:[sortedAry objectAtIndex:indexPath.row]];
        Ary_getcomments=[Fullstr componentsSeparatedByString:@"|"];
        
        NSLog(@"heightForCell=%ld",(long)[[heightForCell objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]integerValue]);
        NSLog(@"heightForCell=%u",[Ary_getcomments count]/2);
        
        if ([[heightForCell objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]integerValue] >= [Ary_getcomments count]/2)
        {
            if (indexPath.row==[sortedAry count]-1)
            {
                // UIImageView *horiz_dividerImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 182, 665, 1)];
                UIImageView *horiz_dividerImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50+60*[[heightForCell objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]integerValue], 685, 1)];
                horiz_dividerImg.backgroundColor = [UIColor clearColor];
                horiz_dividerImg.image = [UIImage imageNamed:@"horizontal-seperator.png"];
                
                [[cell contentView] addSubview:horiz_dividerImg];
                
                //return [[heightForCell objectForKey:[NSNumber numberWithInt:indexPath.row]]integerValue]*63+44;
            }
        }
        else
        {
            if (indexPath.row==[sortedAry count]-1)
            {
                UIImageView *horiz_dividerImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, [Ary_getcomments count]/2*60+50, 685, 1)];
                horiz_dividerImg.backgroundColor = [UIColor clearColor];
                horiz_dividerImg.image = [UIImage imageNamed:@"horizontal-seperator.png"];
                
                [[cell contentView] addSubview:horiz_dividerImg];
                
                
                // return [Ary_getcomments count]/2*63+44;
            }
        }
        if([value isEqualToString:[dropdownArray objectAtIndex:0]])
        {
            //for timer
            btn_Start.hidden=YES;
            
            showTime.hidden=YES;
            img_Timer_Backgrnd.hidden=YES;
            
            
            
            //            for(int i=0;i<[ar count];i++)
            //            {
            
            //NSLog(@"%@",[res_dict objectForKey:[NSString stringWithFormat:@"%d",i]]);
           
            NSString *Fullstr=[res_dict_comments objectForKey:[sortedAry objectAtIndex:indexPath.row]];
            Ary_getcomments=[Fullstr componentsSeparatedByString:@"|"];
            
            //}
            
            
            cell.more_btn.frame=CGRectMake(601, 50+48*[Ary_getcomments count]/2, 75, 26);
            cell.img_div1.frame=CGRectMake(0, 44, 1, 50+46*[Ary_getcomments count]/2);
            cell.img_div2.frame=CGRectMake(190, 44, 1, 50+46*[Ary_getcomments count]/2);
            cell.img_div3.frame=CGRectMake(300, 44, 1, 50+46*[Ary_getcomments count]/2);
            cell.img_div4.frame=CGRectMake(684, 44, 1, 50+46*[Ary_getcomments count]/2);
            
            
            
            
            int l=0;
            int k=0;
            for (int i=0; i<[Ary_getcomments count]; i++)
            {
                
                
                if (i%2==0)
                {
                    UILabel *lb_cmt=[[UILabel alloc]initWithFrame:CGRectMake(332, 58+l*48,140, 20)];
                    //lb_cmt.backgroundColor=[UIColor redColor];
                    lb_cmt.text=[Ary_getcomments objectAtIndex:i];
                    lb_cmt.font=[UIFont fontWithName:@"Enigmatic" size:14];
                    
                    //lb_cmt.text=@"check comments";
                    
                    [[DictCheckLbl_stunt objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] insertObject:lb_cmt atIndex:i];
                    
                    [[cell contentView]addSubview:lb_cmt];
                    
                    
                    UIButton *btn_checkMore=[UIButton buttonWithType:UIButtonTypeCustom];
                    btn_checkMore.frame=CGRectMake(309, 58+l*48, 20, 20);
                    [btn_checkMore setImage:[UIImage imageNamed:[[containsArray objectAtIndex:indexPath.row] objectAtIndex:i]] forState:normal];
                    
                    [btn_checkMore setTag:indexPath.row];
                    [btn_checkMore addTarget:self action:@selector(checked_button_clicked:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [[DictCheckBtn_stunt objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] insertObject:btn_checkMore atIndex:i];
                    
                    [[cell contentView]addSubview:btn_checkMore];
                    l++;
                    
                    
                    
                }else
                {
                    UILabel *lb_cmt=[[UILabel alloc]initWithFrame:CGRectMake(502, 58+k*48,180, 20)];
                    // lb_cmt.backgroundColor=[UIColor redColor];
                    lb_cmt.text=[Ary_getcomments objectAtIndex:i];
                    lb_cmt.font=[UIFont fontWithName:@"Enigmatic" size:14];
                    
                    //lb_cmt.text=@"check comments";
                    
                    [[DictCheckLbl_stunt objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] insertObject:lb_cmt atIndex:i];
                    
                    [[cell contentView]addSubview:lb_cmt];
                    
                    UIButton *btn_checkMore=[UIButton buttonWithType:UIButtonTypeCustom];
                    btn_checkMore.frame=CGRectMake(477, 58+k*48, 20, 20);
                    [btn_checkMore setImage:[UIImage imageNamed:[[containsArray objectAtIndex:[indexPath row]] objectAtIndex:i]] forState:normal];
                    [btn_checkMore setTag:indexPath.row];
                    
                    [btn_checkMore addTarget:self action:@selector(checked_button_clicked:) forControlEvents:UIControlEventTouchUpInside];
                    [[DictCheckBtn_stunt objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] insertObject:btn_checkMore atIndex:i];
                    
                    [[cell contentView]addSubview:btn_checkMore];
                    
                    k++;
                    
                }
                
                
                
            }
            
            
            
            cell.Lbl_headings.text=[sortedAry objectAtIndex:indexPath.row];
            cell.Lbl_headings.font=[UIFont fontWithName:@"Enigmatic" size:16];
            cell.lbl_cell_commentTitle.font=[UIFont fontWithName:@"Enigmatic" size:17];
            cell.lbl_cell_scoreTitle.font=[UIFont fontWithName:@"Enigmatic" size:16];
            
            
            // [[cell lbl_possible_points]setText:[arr_postion_points objectAtIndex:indexPath.row]];
            for(int i=0;i<[[array123Dict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]count];i++)
            {
                
                UILabel *div_Lab=[[UILabel alloc]initWithFrame:CGRectMake(243, 57+i*46, 50, 30)];
                //[div_Lab setText:@"/10"];
                div_Lab.font=[UIFont fontWithName:@"Enigmatic" size:16];
                div_Lab.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
                div_Lab.text=[NSString stringWithFormat:@"/%@",[[divLableDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]objectAtIndex:i]];
                [[cell contentView]addSubview:div_Lab];
                
                
                //totalDivisionVal+=[[[divLableDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]objectAtIndex:i]intValue];
                
                
                
                UIImageView *tf_bagImg = [[UIImageView alloc] initWithFrame:CGRectMake(200, 57+i*46, 40, 30)];
                tf_bagImg.backgroundColor = [UIColor clearColor];
                tf_bagImg.image = [UIImage imageNamed:@"score-box2.png"];
                [[cell contentView] addSubview:tf_bagImg];
                
                
                [[indexDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] insertObject:[[UILabel alloc]initWithFrame:CGRectMake(10, 44+i*48, 170, 44)] atIndex:i];
                
                [[[indexDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] objectAtIndex:i] setFont:[UIFont fontWithName:@"Enigmatic" size:16]];
                
                [[[indexDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] objectAtIndex:i] setTextColor:[UIColor colorWithRed:10.0/255.0 green:40.0/255.0 blue:100.0/255.0 alpha:1.0]];
                
                [[cell contentView] addSubview:[[indexDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] objectAtIndex:i]];
                
                [[[indexDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] objectAtIndex:i]setText:[[array123Dict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] objectAtIndex:i]];
                
                if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
                {
                    
                    [[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] insertObject:[[UITextField alloc]initWithFrame:CGRectMake(204, 57+i*46, 36, 30)] atIndex:i];
                }
                else
                {
                    [[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] insertObject:[[UITextField alloc]initWithFrame:CGRectMake(204, 65+i*46, 36, 30)] atIndex:i];
                }
                
                
                
                [[[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] objectAtIndex:i] setFont:[UIFont fontWithName:@"Enigmatic" size:16]];
                
                [[[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] objectAtIndex:i] setTextColor:[UIColor colorWithRed:10.0/255.0 green:40.0/255.0 blue:100.0/255.0 alpha:1.0]];
                
                
                [[cell contentView] addSubview:[[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] objectAtIndex:i]];
                
                // [[[txtFiledDict objectForKey:[NSNumber numberWithInt:indexPath.row]]objectAtIndex:i]setBackgroundColor:[UIColor redColor]];
                
                [[[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]objectAtIndex:i]setTag:indexPath.row];
                [[[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]objectAtIndex:i]setDelegate:self];
                
                
                
                UIImageView *horiz_dividerImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43+i*49, 190, 1)];
                horiz_dividerImg.backgroundColor = [UIColor clearColor];
                horiz_dividerImg.image = [UIImage imageNamed:@"horizontal-seperator.png"];
                
                [[cell contentView] addSubview:horiz_dividerImg];
                
                
            }
            
            NSLog(@"sortedAry.count=%d",(int)sortedAry.count);
            
            
            //btn_submit.frame=CGRectMake(723, 640, 280, 44);
        
            
            
            [cell.more_btn addTarget:self action:@selector(morebtn_clicked_chreo_index0:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            NSLog(@"%@",[_mainScoreDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]);
            
            // Kundan
            /*NSArray *tempArray =[NSArray arrayWithArray:[_mainScoreDict objectForKey:[NSNumber numberWithInt: (int)indexPath.row]]];
            for (int i=0; i<[tempArray count]; i++)
            {
                if ([tempArray count]==0)
                {
                    
                    
                }
                else
                {
                    if ([[tempArray objectAtIndex:i]isEqualToString:@"0"])
                    {
                        
                        
                    }
                    else
                    {
                        
                        [[[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]objectAtIndex:i]setText:[tempArray objectAtIndex:i]];
                        
                    }
                }
                
            }*/
            
            // check rating given or not if given then else part will work,if not given if part will work
            
            if ([[Dict_givenRating allKeys]count]==0)
            {
                NSArray *tempArray =[NSArray arrayWithArray:[_mainScoreDict objectForKey:[NSNumber numberWithInt: (int)indexPath.row]]];
                for (int i=0; i<[tempArray count]; i++)
                {
                    if ([tempArray count]==0)
                    {
                        
                        
                    }
                    else
                    {
                        if ([[tempArray objectAtIndex:i]isEqualToString:@"0"])
                        {
                            
                            
                        }
                        else
                        {
                            
                            [[[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]objectAtIndex:i]setText:[tempArray objectAtIndex:i]];
                            
                        }
                    }
                    
                }

                
            }
            else
            {
                NSArray *tempary=[NSArray arrayWithArray:[Dict_givenRating objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]]];
                
                for (int i=0; i<[tempary count]; i++)
                {
                    if ([tempary count]==0)
                    {
                        
                    }
                    else
                    {
                        if ([[tempary objectAtIndex:i]isEqualToString:@"0.00"])
                        {
                            
                        }
                        else
                        {
                        [[[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]objectAtIndex:i]setText:[NSString stringWithFormat:@"%.1f",[[tempary objectAtIndex:i] floatValue]]];
                            
                        }
                    }
                }
                
                
            }
            
        }
        
        if([value isEqualToString:[dropdownArray objectAtIndex:1]])
        {
            
            
            //for timer
            btn_Start.hidden=YES;
            
            showTime.hidden=YES;
            img_Timer_Backgrnd.hidden=YES;
            
            
            // Kundan
            
            
            //            for(int i=0;i<[ar count];i++)
            //            {
            
            //NSLog(@"%@",[res_dict objectForKey:[NSString stringWithFormat:@"%d",i]]);
           
            NSString *Fullstr=[res_dict_comments objectForKey:[sortedAry objectAtIndex:indexPath.row]];
            Ary_getcomments=[Fullstr componentsSeparatedByString:@"|"];
            
            //}
            
            
            if([[[UIDevice currentDevice] systemVersion] floatValue] > 7.0)
            {
                
                cell.img_div1.frame=CGRectMake(0, 44, 1, 50+46*[Ary_getcomments count]/2);
                cell.img_div2.frame=CGRectMake(190, 44, 1, 50+46*[Ary_getcomments count]/2);
                cell.img_div3.frame=CGRectMake(300, 44, 1, 50+46*[Ary_getcomments count]/2);
                cell.img_div4.frame=CGRectMake(684, 44, 1, 50+46*[Ary_getcomments count]/2);
                
                
                cell.more_btn.frame=CGRectMake(601, 50+48*[Ary_getcomments count]/2, 75, 26);
                
                
            }
            if ([[[UIDevice currentDevice] systemVersion] floatValue] == 7.0)
            {
                cell.more_btn.frame=CGRectMake(601, 50+48*[Ary_getcomments count]/2, 75, 26);
                
                cell.img_div1.frame=CGRectMake(0, 44, 1, 50+60*[Ary_getcomments count]/2);
                cell.img_div2.frame=CGRectMake(190, 44, 1, 50+60*[Ary_getcomments count]/2);
                cell.img_div3.frame=CGRectMake(300, 44, 1, 50+60*[Ary_getcomments count]/2);
                cell.img_div4.frame=CGRectMake(684, 44, 1, 50+60*[Ary_getcomments count]/2);
                
                
                
            }
            if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
            {
                cell.more_btn.frame=CGRectMake(601, 50+48*[Ary_getcomments count]/2, 75, 26);
                
                cell.img_div1.frame=CGRectMake(0, 44, 1, 50+46*[Ary_getcomments count]/2);
                cell.img_div2.frame=CGRectMake(190, 44, 1, 50+46*[Ary_getcomments count]/2);
                cell.img_div3.frame=CGRectMake(300, 44, 1, 50+46*[Ary_getcomments count]/2);
                cell.img_div4.frame=CGRectMake(684, 44, 1, 50+46*[Ary_getcomments count]/2);
                
            }
            
            
            int l=0;
            int k=0;
            for (int i=0; i<[Ary_getcomments count]; i++)
            {
                
                
                if (i%2==0)
                {
                    UILabel *lb_cmt=[[UILabel alloc]initWithFrame:CGRectMake(332, 58+l*48,140, 20)];
                    //lb_cmt.backgroundColor=[UIColor redColor];
                    lb_cmt.text=[Ary_getcomments objectAtIndex:i];
                    lb_cmt.font=[UIFont fontWithName:@"Enigmatic" size:14];
                    
                    //lb_cmt.text=@"check comments";
                    
                    [[DictCheckLbl_tumble objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] insertObject:lb_cmt atIndex:i];
                    
                    [[cell contentView]addSubview:lb_cmt];
                    
                    
                    UIButton *btn_checkMore=[UIButton buttonWithType:UIButtonTypeCustom];
                    btn_checkMore.frame=CGRectMake(309, 58+l*48, 20, 20);
                    [btn_checkMore setImage:[UIImage imageNamed:[[containsArrayTumble objectAtIndex:indexPath.row] objectAtIndex:i]] forState:normal];
                    
                    [btn_checkMore setTag:indexPath.row];
                    [btn_checkMore addTarget:self action:@selector(checked_button_clicked1:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [[DictCheckBtn_tumble objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] insertObject:btn_checkMore atIndex:i];
                    
                    [[cell contentView]addSubview:btn_checkMore];
                    l++;
                    
                    
                }else
                {
                    UILabel *lb_cmt=[[UILabel alloc]initWithFrame:CGRectMake(502, 58+k*48,180, 20)];
                    // lb_cmt.backgroundColor=[UIColor redColor];
                    lb_cmt.text=[Ary_getcomments objectAtIndex:i];
                    lb_cmt.font=[UIFont fontWithName:@"Enigmatic" size:14];
                    
                    //lb_cmt.text=@"check comments";
                    
                    [[DictCheckLbl_tumble objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] insertObject:lb_cmt atIndex:i];
                    
                    [[cell contentView]addSubview:lb_cmt];
                    
                    UIButton *btn_checkMore=[UIButton buttonWithType:UIButtonTypeCustom];
                    btn_checkMore.frame=CGRectMake(477, 58+k*48, 20, 20);
                    [btn_checkMore setImage:[UIImage imageNamed:[[containsArrayTumble objectAtIndex:[indexPath row]] objectAtIndex:i]] forState:normal];
                    [btn_checkMore setTag:indexPath.row];
                    
                    [btn_checkMore addTarget:self action:@selector(checked_button_clicked1:) forControlEvents:UIControlEventTouchUpInside];
                    [[DictCheckBtn_tumble objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] insertObject:btn_checkMore atIndex:i];
                    
                    [[cell contentView]addSubview:btn_checkMore];
                    
                    k++;
                    
                }
                
                
                
            }
            //////////////
            
            cell.Lbl_headings.font=[UIFont fontWithName:@"Enigmatic" size:16];
            cell.lbl_cell_commentTitle.font=[UIFont fontWithName:@"Enigmatic" size:16];
            cell.lbl_cell_scoreTitle.font=[UIFont fontWithName:@"Enigmatic" size:16];
            cell.Lbl_headings.text=[sortedAry objectAtIndex:indexPath.row];
            
            
            //[[cell lbl_possible_points]setText:[arr_postion_points objectAtIndex:indexPath.row]];
            
            for(int i=0;i<[[array123Dict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]count];i++)
                
            {
                
                UILabel *div_Lab=[[UILabel alloc]initWithFrame:CGRectMake(243, 57+i*46, 50, 30)];
                //[div_Lab setText:@"/10"];
                div_Lab.font=[UIFont fontWithName:@"Enigmatic" size:16];
                div_Lab.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
                
                [[cell contentView]addSubview:div_Lab];
                
                div_Lab.text=[NSString stringWithFormat:@"/%@",[[divLableDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]objectAtIndex:i]];
                
                
                UIImageView *tf_bagImg = [[UIImageView alloc] initWithFrame:CGRectMake(200, 57+i*46, 40, 30)];
                tf_bagImg.backgroundColor = [UIColor clearColor];
                tf_bagImg.image = [UIImage imageNamed:@"score-box2.png"];
                [[cell contentView] addSubview:tf_bagImg];
                
                
                [[indexDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] insertObject:[[UILabel alloc]initWithFrame:CGRectMake(10, 44+i*48, 170, 44)] atIndex:i];
                [[cell contentView] addSubview:[[indexDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] objectAtIndex:i]];
                
                [[[indexDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] objectAtIndex:i]setText:[[array123Dict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] objectAtIndex:i]];
                
                [[[indexDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] objectAtIndex:i] setFont:[UIFont fontWithName:@"Enigmatic" size:16]];
                
                [[[indexDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] objectAtIndex:i] setTextColor:[UIColor colorWithRed:10.0/255.0 green:40.0/255.0 blue:100.0/255.0 alpha:1.0]];
                
                if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
                {
                    [[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] insertObject:[[UITextField alloc]initWithFrame:CGRectMake(204, 57+i*46, 36, 30)] atIndex:i];
                }
                else
                {
                    [[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] insertObject:[[UITextField alloc]initWithFrame:CGRectMake(204, 65+i*46, 36, 30)] atIndex:i];
                }
                
                [[[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] objectAtIndex:i] setFont:[UIFont fontWithName:@"Enigmatic" size:16]];
                
                [[[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] objectAtIndex:i] setTextColor:[UIColor colorWithRed:10.0/255.0 green:40.0/255.0 blue:100.0/255.0 alpha:1.0]];
                
                [[cell contentView] addSubview:[[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] objectAtIndex:i]];
                
                // [[[txtFiledDict objectForKey:[NSNumber numberWithInt:indexPath.row]]objectAtIndex:i]setBackgroundColor:[UIColor redColor]];
                
                [[[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]objectAtIndex:i]setTag:indexPath.row];
                [[[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]objectAtIndex:i]setDelegate:self];
                
                
                UIImageView *horiz_dividerImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43+i*49, 190, 1)];
                horiz_dividerImg.backgroundColor = [UIColor clearColor];
                horiz_dividerImg.image = [UIImage imageNamed:@"horizontal-seperator.png"];
                
                [[cell contentView] addSubview:horiz_dividerImg];
                
                
            }
            
            NSLog(@"sortedAry.count=%lu",(unsigned long)sortedAry.count);
            
            //[btn_submit setFrame:CGRectMake(723, 505, 280, 44)];
         
            
            
            [cell.more_btn addTarget:self action:@selector(morebtn_clicked_chreo_index0:) forControlEvents:UIControlEventTouchUpInside];
            
            // Kundan
            NSArray *tempArray =[NSArray arrayWithArray:[_mainScoreDict_tumbling objectForKey:[NSNumber numberWithInt: (int)indexPath.row]]];
            for (int i=0; i<[tempArray count]; i++)
            {
                if ([tempArray count]==0)
                {
                    
                    
                }
                else
                {
                    if ([[tempArray objectAtIndex:i]isEqualToString:@"0"])
                    {
                        
                        
                    }
                    else
                    {
                        
                        [[[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]objectAtIndex:i]setText:[tempArray objectAtIndex:i]];
                        
                    }
                }
                
            }
            
        }
        if([value isEqualToString:[dropdownArray objectAtIndex:2]])
        {
            
            
            //for timer
            
            btn_Start.hidden=YES;
            
            showTime.hidden=YES;
            img_Timer_Backgrnd.hidden=YES;
            // Kundan
            
            
            
           
            NSString *Fullstr=[res_dict_comments objectForKey:[sortedAry objectAtIndex:indexPath.row]];
            Ary_getcomments=[Fullstr componentsSeparatedByString:@"|"];
            
            
            
            if([[[UIDevice currentDevice] systemVersion] floatValue] > 7.0)
            {
                
                cell.more_btn.frame=CGRectMake(601, 50+48*[Ary_getcomments count]/2, 75, 26);
                cell.img_div1.frame=CGRectMake(0, 44, 1, 54+48*[Ary_getcomments count]/2);
                cell.img_div2.frame=CGRectMake(190, 44, 1, 54+48*[Ary_getcomments count]/2);
                cell.img_div3.frame=CGRectMake(300, 44, 1, 54+48*[Ary_getcomments count]/2);
                cell.img_div4.frame=CGRectMake(684, 44, 1,54+48*[Ary_getcomments count]/2);
                
                
                
                
            }
            if ([[[UIDevice currentDevice] systemVersion] floatValue] == 7.0)
            {
                cell.more_btn.frame=CGRectMake(601, 50+48*[Ary_getcomments count]/2, 75, 26);
                
                cell.img_div1.frame=CGRectMake(0, 44, 1, 50+60*[Ary_getcomments count]/2);
                cell.img_div2.frame=CGRectMake(190, 44, 1, 50+60*[Ary_getcomments count]/2);
                cell.img_div3.frame=CGRectMake(300, 44, 1, 50+60*[Ary_getcomments count]/2);
                cell.img_div4.frame=CGRectMake(684, 44, 1, 50+60*[Ary_getcomments count]/2);
                
                
            }
            if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
            {
                cell.more_btn.frame=CGRectMake(601, 50+48*[Ary_getcomments count]/2, 75, 26);
                cell.img_div1.frame=CGRectMake(0, 44, 1, 50+46*[Ary_getcomments count]/2);
                cell.img_div2.frame=CGRectMake(190, 44, 1, 50+46*[Ary_getcomments count]/2);
                cell.img_div3.frame=CGRectMake(300, 44, 1, 50+46*[Ary_getcomments count]/2);
                cell.img_div4.frame=CGRectMake(684, 44, 1, 50+46*[Ary_getcomments count]/2);
                
                
            }
            
            
            int l=0;
            int k=0;
            for (int i=0; i<[Ary_getcomments count]; i++)
            {
                
                if (i%2==0)
                {
                    UILabel *lb_cmt=[[UILabel alloc]initWithFrame:CGRectMake(332, 58+l*48,140, 20)];
                    //lb_cmt.backgroundColor=[UIColor redColor];
                    lb_cmt.text=[Ary_getcomments objectAtIndex:i];
                    lb_cmt.font=[UIFont fontWithName:@"Enigmatic" size:14];
                    
                    //lb_cmt.text=@"check comments";
                    
                    [[DictCheckLbl_choreo objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] insertObject:lb_cmt atIndex:i];
                    
                    [[cell contentView]addSubview:lb_cmt];
                    
                    
                    UIButton *btn_checkMore=[UIButton buttonWithType:UIButtonTypeCustom];
                    btn_checkMore.frame=CGRectMake(309, 58+l*48, 20, 20);
                    [btn_checkMore setImage:[UIImage imageNamed:[[containsArrayChoreo objectAtIndex:indexPath.row] objectAtIndex:i]] forState:normal];
                    
                    [btn_checkMore setTag:indexPath.row];
                    [btn_checkMore addTarget:self action:@selector(checked_button_clicked2:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [[DictCheckBtn_choreo objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] insertObject:btn_checkMore atIndex:i];
                    
                    [[cell contentView]addSubview:btn_checkMore];
                    l++;
                    
                    
                    
                }else
                {
                    UILabel *lb_cmt=[[UILabel alloc]initWithFrame:CGRectMake(502, 58+k*48,180, 20)];
                    // lb_cmt.backgroundColor=[UIColor redColor];
                    lb_cmt.text=[Ary_getcomments objectAtIndex:i];
                    lb_cmt.font=[UIFont fontWithName:@"Enigmatic" size:14];
                    
                    //lb_cmt.text=@"check comments";
                    
                    [[DictCheckLbl_choreo objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] insertObject:lb_cmt atIndex:i];
                    
                    [[cell contentView]addSubview:lb_cmt];
                    
                    UIButton *btn_checkMore=[UIButton buttonWithType:UIButtonTypeCustom];
                    btn_checkMore.frame=CGRectMake(477, 58+k*48, 20, 20);
                    [btn_checkMore setImage:[UIImage imageNamed:[[containsArrayChoreo objectAtIndex:[indexPath row]] objectAtIndex:i]] forState:normal];
                    [btn_checkMore setTag:indexPath.row];
                    
                    [btn_checkMore addTarget:self action:@selector(checked_button_clicked2:) forControlEvents:UIControlEventTouchUpInside];
                    [[DictCheckBtn_choreo objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] insertObject:btn_checkMore atIndex:i];
                    
                    [[cell contentView]addSubview:btn_checkMore];
                    
                    k++;
                    
                }
                
            }
            //////////////
            
            cell.Lbl_headings.font=[UIFont fontWithName:@"Enigmatic" size:16];
            cell.lbl_cell_commentTitle.font=[UIFont fontWithName:@"Enigmatic" size:16];
            cell.lbl_cell_scoreTitle.font=[UIFont fontWithName:@"Enigmatic" size:16];
            
            
            NSLog(@"num of cell in choreo%@",per_resultAry);
            
            cell.Lbl_headings.text=[sortedAry objectAtIndex:indexPath.row];
            // cell.Lbl_headings.text=[ar objectAtIndex:indexPath.row];
            // cell.Lbl_headings.text=@"DANCE/MOTIONS";
            // [[cell lbl_possible_points]setText:[arr_postion_points objectAtIndex:indexPath.row]];
            
            
            for(int i=0;i<[[array123Dict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]count];i++)
                
            {
                
                    UILabel *div_Lab=[[UILabel alloc]initWithFrame:CGRectMake(243, 57+i*46, 50, 30)];
                    //[div_Lab setText:@"/10"];
                    
                    div_Lab.font=[UIFont fontWithName:@"Enigmatic" size:16];
                    div_Lab.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
                    
                    [[cell contentView]addSubview:div_Lab];
                    
                    // div_Lab.text=[[divLableDict_choreo objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]objectAtIndex:i];
                    
                    
                    div_Lab.text=[NSString stringWithFormat:@"/%@",[[divLableDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]objectAtIndex:i]];
                    
                    UIImageView *tf_bagImg = [[UIImageView alloc] initWithFrame:CGRectMake(200, 57+i*46, 40, 30)];
                    tf_bagImg.backgroundColor = [UIColor clearColor];
                    tf_bagImg.image = [UIImage imageNamed:@"score-box2.png"];
                    [[cell contentView] addSubview:tf_bagImg];
                    
                    
                    [[indexDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] insertObject:[[UILabel alloc]initWithFrame:CGRectMake(10, 44+i*48, 170, 44)] atIndex:i];
                    
                    [[[indexDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] objectAtIndex:i] setFont:[UIFont fontWithName:@"Enigmatic" size:16]];
                    
                    [[[indexDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] objectAtIndex:i] setTextColor:[UIColor colorWithRed:10.0/255.0 green:40.0/255.0 blue:100.0/255.0 alpha:1.0]];
                    
                    [[cell contentView] addSubview:[[indexDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] objectAtIndex:i]];
                    
                    [[[indexDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] objectAtIndex:i]setText:[[array123Dict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] objectAtIndex:i]];
                    
                    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
                    {
                        [[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] insertObject:[[UITextField alloc]initWithFrame:CGRectMake(204, 57+i*46, 36, 30)] atIndex:i];
                    }
                    else
                    {
                        [[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] insertObject:[[UITextField alloc]initWithFrame:CGRectMake(204, 65+i*46, 36, 30)] atIndex:i];
                    }
                    [[[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] objectAtIndex:i] setFont:[UIFont fontWithName:@"Enigmatic" size:16]];
                    
                    [[[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] objectAtIndex:i] setTextColor:[UIColor colorWithRed:10.0/255.0 green:40.0/255.0 blue:100.0/255.0 alpha:1.0]];
                    
                    
                    [[cell contentView] addSubview:[[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]] objectAtIndex:i]];
                    
                    [[[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]objectAtIndex:i]setBackgroundColor:[UIColor clearColor]];
                    
                    [[[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]objectAtIndex:i]setTag:indexPath.row];
                    [[[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]objectAtIndex:i]setDelegate:self];
                    
                    
                    UIImageView *horiz_dividerImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44+i*49, 190, 1)];
                    horiz_dividerImg.backgroundColor = [UIColor clearColor];
                    horiz_dividerImg.image = [UIImage imageNamed:@"horizontal-seperator.png"];
                    
                    [[cell contentView] addSubview:horiz_dividerImg];
                
                
            }
            
            NSLog(@"sortedAry.count=%lu",(unsigned long)sortedAry.count);
            
            
            [cell.more_btn addTarget:self action:@selector(morebtn_clicked_chreo_index0:) forControlEvents:UIControlEventTouchUpInside];
            
            
            // Kundan
            NSArray *tempArray =[NSArray arrayWithArray:[_mainScoreDict_choreoghaphy objectForKey:[NSNumber numberWithInt:(int) indexPath.row]]];
            for (int i=0; i<[tempArray count]; i++)
            {
                if ([tempArray count]==0)
                {
                    
                    
                }
                else
                {
                    if ([[tempArray objectAtIndex:i]isEqualToString:@"0"])
                    {
                        
                        
                    }
                    else
                    {
                        
                        [[[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]objectAtIndex:i]setText:[tempArray objectAtIndex:i]];
                        
                    }
                }
                
            }
            
        }
        
        
        return cell;
        
    }
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}




//dont delete this mehtod
//this method is for comment button inside cell for all four screen
-(void)morebtn_clicked_chreo_index0:(UIButton *)sender
{
    overAll_imp_comt_View.transform = CGAffineTransformMakeScale(0.05, 0.05);
    [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        // animate it to the identity transform (100% scale)
        overAll_imp_comt_View.transform = CGAffineTransformIdentity;
    } completion:nil];
    btn_submitFrom_comment.hidden=NO;
    
    [self.view addSubview:overAll_imp_comt_View];
    [comment_vf becomeFirstResponder];
    
    subTypeSTR=[[NSMutableString alloc]init];
    subTypeSTR=[sortedAry objectAtIndex:sender.tag];
    


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if (![[touch view] isKindOfClass:[UITextField class]])
    {
        [self.view endEditing:YES];
    }
    
    [super touchesBegan:touches withEvent:event];
}
- (IBAction)pickbtn_clicked:(id)sender
{
    [self.view endEditing:YES];
    
    
    [pickview removeFromSuperview];
    pickview =[[UIPickerView alloc]initWithFrame:CGRectMake(0, 44, 400 , 216)];
    [picker_uiview addSubview:pickview];
    
    switch( [sender tag])
    {
            
        case 0:
        {
            
            
        }
            
        case 1:
        {
            
            
        }
            
        case 2:
        {
            
            // http://joomerang.geniusport.com/cheerinfinity/webservices/getwbs_teams.php
            //http://54.191.2.63/spiritcentral_uat/webservices_dev/
            
            [self showBusyView];
            CheckWebService=@"Team_Display";
            NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
            
            NSString *jsonstring1=[dct JSONRepresentation];
                       NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring1];
          
            
            NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_teams.php",BASEURL];
            m_pWebService			= [[WebService alloc] initWebService:l_pURL];
            m_pWebService.mDelegate		= self;
            [m_pWebService  sendHTTPPost:post1];
            
             pickview.tag=[sender tag];
           
            break;
        }
        case 3:
        {
            
        }
        case 4:
        {
            
        }
            
        case 5:
        {
            
         if (dropdownArray1.count==0)
            {
                UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"" message:@"Sorry,You have no data" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [al show];
                
                
            }
            
         else
            {
            pickview.tag=[sender tag];
            [pickview setShowsSelectionIndicator:YES];
            
            pickview.dataSource=self;
            pickview.delegate=self;
            
            self.popView = [[UIViewController alloc]init];
            [self.popView.view addSubview:picker_uiview];
            self.aPopover = [[UIPopoverController alloc]initWithContentViewController:self.popView];
            self.aPopover.delegate=self;
            self.aPopover.popoverContentSize=picker_uiview.frame.size;
            [self.aPopover presentPopoverFromRect:btn_Selected_cat.frame inView:self.view
                         permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
           
            
            break;
           }
        }
            
    }
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *retval = (id)view;
    if (!retval) {
        retval= [[UILabel alloc] init];
    }
     retval.textAlignment = NSTextAlignmentLeft;
      switch([pickerView tag])
    {
        case 0:
        {
            
            
        }
        case 1:
            
        {
             retval.font = [UIFont fontWithName:@"Enigmatic" size:20];
            retval.text= [gymArray objectAtIndex:row];
            break;
            
        }
        case 2:
        {
             retval.font = [UIFont fontWithName:@"Enigmatic" size:20];
            retval.text= [teamArray objectAtIndex:row];
            break;
            
        }
        case 3:
        {
            
        }
        case 4:
        {
            
        }
        case 5:
        {
             retval.font = [UIFont fontWithName:@"Enigmatic" size:20];
            retval.text= [dropdownArray1 objectAtIndex:row];
            
            break;
            
        }
        default:
        {
            
        }
            
            
    }
    
    return retval;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
       if ([pickerView tag]==1)
    {
        tf_gym.text=[gymArray objectAtIndex:row];
      

    }
    
    if ([pickerView tag]==4)
    {
        
    }
    if([pickerView tag]==5)
    {
        
        //value=[dropdownArray objectAtIndex:row];
            tf_dropdown.text=catLable.text;
    }

}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
   
  
    switch ([pickerView tag])
    {
        case 0:
         
            
        case 1:
          return [gymArray count];
            break;
        case 2:
        {
            return [teamArray count];
            NSLog(@"value==%ld",(unsigned long)[teamArray count]);
            break;
        }
        case 3:
        case 4:
                      case 5:
          return  [dropdownArray1 count];
            break;
        
        default:
            break;
    }
    
    
}
-(IBAction)done_FromPickerView:(id)sender
{
   
    int rowselect=(int)[pickview selectedRowInComponent:0];
    if (pickview.tag==0) {
        
        

    }
    else if (pickview.tag==1)
    {
        tf_gym.text=[gymArray objectAtIndex:rowselect];
      
    }
    else if (pickview.tag==2)
    {
        
        teamID=[teamIDArray objectAtIndex:rowselect];
        
    }
    else if (pickview.tag==3)
    {
        
    }
    else if (pickview.tag==4)
    {
        
        
        
    }
    else if (pickview.tag==5)
    {
        dropdownArray_IDSTR=[[NSMutableString alloc]init];

        
        catLable.text=[dropdownArray1 objectAtIndex:rowselect];
        tf_dropdown.text=[dropdownArray1 objectAtIndex:rowselect];
        dropdownArray_IDSTR=[dropdownArray_ID1 objectAtIndex:rowselect];
      
        
        value=[dropdownArray1 objectAtIndex:rowselect];
        doneValue=[dropdownArray1 objectAtIndex:rowselect];
        
        Singleton *st=[Singleton getObject];
        [st setScreenID:[dropdownArray_ID1 objectAtIndex:rowselect]];
        
        
        if ([value isEqualToString:[dropdownArray objectAtIndex:0]])
        {
            
            
            btn_Start.hidden=YES;
            
            showTime.hidden=YES;
            img_Timer_Backgrnd.hidden=YES;
            

            
             bst=NO;
            if(b6==YES)
            {
                
                b1=YES;
                b6=NO;
            }
            else
            {
                //dont do anything
            }
           
            
             [self display_performancetype];
            
            //////
            [view_Tumb_Choreo setHidden:YES];
             [deductionView setHidden:YES];
            [stuntsView setHidden:NO];
            [stuntsView setFrame:CGRectMake(724, 180, 280, 135)];
            [view_Tumb_Choreo removeFromSuperview];
            [[self view]addSubview:stuntsView];

            NSLog(@"%lu",(unsigned long)[[[self view]subviews]count]);
            
            //////////
            //totalscrore_lbl.text=[NSString stringWithFormat:@"%.1f/%d",StuntsumFloat,stuntTotal*10+10];
            totalscrore_lbl.text=[NSString stringWithFormat:@"%.1f/%d",StuntsumFloat,DivScore_stunt];

//
            
        }
        else if ([value isEqualToString:[dropdownArray objectAtIndex:1]])
        {
           

            
            btn_Start.hidden=YES;
         
            showTime.hidden=YES;
            img_Timer_Backgrnd.hidden=YES;
            

            
            bst=NO;
            
            
           if(b4==YES)
            {
            
                b2=YES;
                b4=NO;
            }
            else
            {
            //dont do anything
            }
           
          
             [self display_performancetype];
            
            
            /////////
            [stuntsView setHidden:YES];
             [deductionView setHidden:YES];
             [view_Tumb_Choreo setHidden:NO];
            [view_Tumb_Choreo setFrame:CGRectMake(724, 187, 280, 135)];
            [stuntsView removeFromSuperview];
            [[self view]addSubview:view_Tumb_Choreo];
            /////////
            
            //lbl_totalScore_value_tc.text=[NSString stringWithFormat:@"%.1f/%d",ThumbsumFloat,thumbTotal*10+5];
                        txt_overAll_impr_scor_value_tc.text=tumble_overallScore;
            
            lbl_totalScore_value_tc.text=[NSString stringWithFormat:@"%.1f/%d",ThumbsumFloat,DivScore_tumble];
            
                 }
        else if ([value isEqualToString:[dropdownArray objectAtIndex:2]])
        {
           

            
            btn_Start.hidden=YES;
          
            showTime.hidden=YES;
                        img_Timer_Backgrnd.hidden=YES;
            

            
             bst=NO;
           
           if(b5==YES)
            {
                b3=YES;
                b5=NO;
                
            }
            else
            {
                
            }
            
              //b3=YES;
             [self display_performancetype];
            
            ///////
            [stuntsView setHidden:YES];
             [deductionView setHidden:YES];
            [view_Tumb_Choreo setHidden:NO];
            [view_Tumb_Choreo setFrame:CGRectMake(724, 187, 280, 135)];
            [stuntsView removeFromSuperview];
            [[self view]addSubview:view_Tumb_Choreo];
            /////////
            //lbl_totalScore_value_tc.text=[NSString stringWithFormat:@"%.1f/%d",ChoreosumFloat,choroTotal*10+5];
            
            lbl_totalScore_value_tc.text=[NSString stringWithFormat:@"%.1f/%d",ChoreosumFloat,DivScore_choreo];

             txt_overAll_impr_scor_value_tc.text=choreo_overallScore;
        }
        else if([value isEqualToString:[dropdownArray objectAtIndex:3]])
        {
            
            //for timer
            btn_Start.hidden=NO;
        
            showTime.hidden=NO;
            img_Timer_Backgrnd.hidden=NO;
            
            
            [self display_performancetype];
            //lbl_totalScore_value_inDeduction.text=@"0.0";
           // lbl_total_deduction.text=@"0.0";
            [stuntsView setHidden:YES];
            [view_Tumb_Choreo setHidden:YES];
            [deductionView setHidden:NO];
            [deductionView setFrame:CGRectMake(723, 187, 280, 135)];
            [[self view]addSubview:deductionView];
            ////////
            Finalsumfloat=Dedutionsumfloat+StuntsumFloat+ChoreosumFloat+ThumbsumFloat;
                    //[tableview1 reloadData];
        }
        
       

    }
    
    
    
    [pickview removeFromSuperview];
    [self.aPopover dismissPopoverAnimated:YES];
    [self.popView dismissModalViewControllerAnimated:YES];
    
}
- (IBAction)cancelfromcomtview_clicked:(id)sender
{
       [overAll_imp_comt_View removeFromSuperview];
}
- (IBAction)commentSubmitbtn_clicked:(UIButton *)sender
{
    
//    if ([value isEqualToString:[dropdownArray objectAtIndex:3]]) {
//        
//        [commentStore_indedction insertObject:comment_vf.text atIndex:sender.tag];
//    }
   
   
    Overall_commentValue=comment_vf.text;
    if([Overall_commentValue isEqualToString:@""]|| Overall_commentValue==nil)
    {
        UIAlertView *ve=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Fill The Comments" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [ve show];
    
    }
    else
    {
        // http://joomerang.geniusport.com/cheerinfinity/webservices/getwbs_savecomment.php?json=[{"commented_by":"1","team_id":"1","perf_id":"1","title":"STUNTS","comment_desc":"Motions/Dance%20Variety"}]
        //http://54.191.2.63/spiritcentral_uat/webservices_dev/
        
        Singleton *s=[Singleton getObject];
        teamID=[s team_id];
        NSLog(@"%@",teamID);
        
        if ([teamID isEqualToString:@""]||teamID==nil) {
            
            UIAlertView *ve=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Select the Team" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [ve show];
        }
        else if ([value isEqualToString:[dropdownArray objectAtIndex:0]])
        {
            
            Singleton *s_Obj=[Singleton getObject];
            NSLog(@"LoginUserID=%@",[s_Obj loginUserID]);
            
        [self showBusyView];
        CheckWebService=@"SaveComments";
        Singleton *st=[Singleton getObject];
        NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
        [dct setObject:[st event_ID] forKey:@"event_id"];
            
            //for level and division
//            [dct setObject:[tf_gym text] forKey:@"division"];
//            [dct setObject:[tf_level text] forKey:@"level"];
            
            [dct setObject:[st division_id] forKey:@"division"];
            [dct setObject:[st level_id_new] forKey:@"level"];
            
            
        [dct setObject:[s_Obj loginUserID] forKey:@"commented_by"];
        if ([teamID isEqualToString:@""]||teamID==nil) {
            [dct setObject:@"" forKey:@"team_id"];
            
        }
        else
        {
            [dct setObject:teamID forKey:@"team_id"];
        }
            Singleton *s=[Singleton getObject];
            
            
        
        [dct setObject:@"1" forKey:@"perf_id"];
            
            
        [dct setObject:subTypeSTR forKey:@"title"];
            
        [dct setObject:comment_vf.text forKey:@"comment_desc"];
        NSLog(@"Comment_dct==%@",dct);
        
        NSString *jsonstring1=[dct JSONRepresentation];
            
        NSString *jsonstring_encoding = [NSString stringWithFormat:@"%@",
                             [jsonstring1 urlEncodeUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"jsonstring_encoding=%@",jsonstring_encoding);
            
            
        NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring_encoding];
            
        NSString *l_pURL= [NSString stringWithFormat:@"%@getwbs_savecomment.php",BASEURL];
        m_pWebService			= [[WebService alloc] initWebService:l_pURL];
        m_pWebService.mDelegate		= self;
        [m_pWebService  sendHTTPPost:post1];
        }
        else if ([value isEqualToString:[dropdownArray objectAtIndex:1]])
        {
            
            Singleton *s_Obj=[Singleton getObject];
            NSLog(@"LoginUserID=%@",[s_Obj loginUserID]);
            
            [self showBusyView];
            CheckWebService=@"SaveComments";
            Singleton *st=[Singleton getObject];
            NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
            [dct setObject:[st event_ID] forKey:@"event_id"];
            
            //for level and division
            //            [dct setObject:[tf_gym text] forKey:@"division"];
            //            [dct setObject:[tf_level text] forKey:@"level"];
            
            [dct setObject:[st division_id] forKey:@"division"];
            [dct setObject:[st level_id_new] forKey:@"level"];
            
            
            [dct setObject:[s_Obj loginUserID] forKey:@"commented_by"];
            if ([teamID isEqualToString:@""]||teamID==nil) {
                [dct setObject:@"" forKey:@"team_id"];
                
            }
            else
            {
                [dct setObject:teamID forKey:@"team_id"];
            }
            Singleton *s=[Singleton getObject];
            
            
            
            [dct setObject:@"2"forKey:@"perf_id"];
            
            
            [dct setObject:subTypeSTR forKey:@"title"];
            
            [dct setObject:comment_vf.text forKey:@"comment_desc"];
            NSLog(@"Comment_dct==%@",dct);
            
            NSString *jsonstring1=[dct JSONRepresentation];
            
            NSString *jsonstring_encoding = [NSString stringWithFormat:@"%@",
                                             [jsonstring1 urlEncodeUsingEncoding:NSUTF8StringEncoding]];
            NSLog(@"jsonstring_encoding=%@",jsonstring_encoding);
            
            
            NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring_encoding];
            
            NSString *l_pURL= [NSString stringWithFormat:@"%@getwbs_savecomment.php",BASEURL];
            m_pWebService			= [[WebService alloc] initWebService:l_pURL];
            m_pWebService.mDelegate		= self;
            [m_pWebService  sendHTTPPost:post1];
        }
        else if ([value isEqualToString:[dropdownArray objectAtIndex:2]])
        {
            
            Singleton *s_Obj=[Singleton getObject];
            NSLog(@"LoginUserID=%@",[s_Obj loginUserID]);
            
            [self showBusyView];
            CheckWebService=@"SaveComments";
            Singleton *st=[Singleton getObject];
            NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
            [dct setObject:[st event_ID] forKey:@"event_id"];
            
            //for level and division
            //            [dct setObject:[tf_gym text] forKey:@"division"];
            //            [dct setObject:[tf_level text] forKey:@"level"];
            
            [dct setObject:[st division_id] forKey:@"division"];
            [dct setObject:[st level_id_new] forKey:@"level"];
            
            
            [dct setObject:[s_Obj loginUserID] forKey:@"commented_by"];
            if ([teamID isEqualToString:@""]||teamID==nil) {
                [dct setObject:@"" forKey:@"team_id"];
                
            }
            else
            {
                [dct setObject:teamID forKey:@"team_id"];
            }
            Singleton *s=[Singleton getObject];
            
            
            
            [dct setObject:@"3"forKey:@"perf_id"];
            
            
            [dct setObject:subTypeSTR forKey:@"title"];
            
            [dct setObject:comment_vf.text forKey:@"comment_desc"];
            NSLog(@"Comment_dct==%@",dct);
            
            NSString *jsonstring1=[dct JSONRepresentation];
            
            NSString *jsonstring_encoding = [NSString stringWithFormat:@"%@",
                                             [jsonstring1 urlEncodeUsingEncoding:NSUTF8StringEncoding]];
            NSLog(@"jsonstring_encoding=%@",jsonstring_encoding);
            
            
            NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring_encoding];
            
            NSString *l_pURL= [NSString stringWithFormat:@"%@getwbs_savecomment.php",BASEURL];
            m_pWebService			= [[WebService alloc] initWebService:l_pURL];
            m_pWebService.mDelegate		= self;
            [m_pWebService  sendHTTPPost:post1];
        }
        else if ([value isEqualToString:[dropdownArray objectAtIndex:3]])
        {
            
            Singleton *s_Obj=[Singleton getObject];
            NSLog(@"LoginUserID=%@",[s_Obj loginUserID]);
            
            [self showBusyView];
            CheckWebService=@"SaveComments";
            Singleton *st=[Singleton getObject];
            NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
            [dct setObject:[st event_ID] forKey:@"event_id"];
            
            //for level and division
            //            [dct setObject:[tf_gym text] forKey:@"division"];
            //            [dct setObject:[tf_level text] forKey:@"level"];
            
            [dct setObject:[st division_id] forKey:@"division"];
            [dct setObject:[st level_id_new] forKey:@"level"];
            
            
            [dct setObject:[s_Obj loginUserID] forKey:@"commented_by"];
            if ([teamID isEqualToString:@""]||teamID==nil) {
                [dct setObject:@"" forKey:@"team_id"];
                
            }
            else
            {
                [dct setObject:teamID forKey:@"team_id"];
            }
            Singleton *s=[Singleton getObject];
            
            
            
            [dct setObject:@"4"forKey:@"perf_id"];
            
            
            [dct setObject:subTypeSTR forKey:@"title"];
            
            [dct setObject:comment_vf.text forKey:@"comment_desc"];
            NSLog(@"Comment_dct==%@",dct);
            
            NSString *jsonstring1=[dct JSONRepresentation];
            
            NSString *jsonstring_encoding = [NSString stringWithFormat:@"%@",
                                             [jsonstring1 urlEncodeUsingEncoding:NSUTF8StringEncoding]];
            NSLog(@"jsonstring_encoding=%@",jsonstring_encoding);
            
            
            NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring_encoding];
            
            NSString *l_pURL= [NSString stringWithFormat:@"%@getwbs_savecomment.php",BASEURL];
            m_pWebService			= [[WebService alloc] initWebService:l_pURL];
            m_pWebService.mDelegate		= self;
            [m_pWebService  sendHTTPPost:post1];
        }



    }

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
   if (alertView==checkEmptyAlert)
    {
        [self hideBusyView];
        EmptyCountval=0;
        
    }
    
    
    
    if(alertView==NextTeamAlert)
    {
        
        
        [headjudge_Sumary_View removeFromSuperview];
        
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
        [delegate.viewController_leftPane showLeftPanelAnimated:YES];
        
        
        
    }
    
    
    if (alertView==saveComment_Alert1)
    {
        
         [comment_vf_Overall setText:nil];
        
         [overAll_imp_comt_View_New1 removeFromSuperview];
    }
    
    
    if (alertView==commentAlert)
    {
        
         [comment_vf setText:nil];
         [overAll_imp_comt_View removeFromSuperview];
    }
   else if (alertView==logoutAlert)
   {
       if(buttonIndex==0)
       {
           
       }
       else if (buttonIndex==1)
       {
           if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
           {
           LoginViewController *LoginViewController_Obj=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
           [self presentViewController:LoginViewController_Obj animated:YES completion:nil];
           }
           else
           {
               LoginViewController *LoginViewController_Obj=[[LoginViewController alloc]initWithNibName:@"LoginViewController_ios6" bundle:nil];
               [self presentViewController:LoginViewController_Obj animated:YES completion:nil];
           }
       }
   }
    else if (alertView==saveComment_Alert)
    {
        [comment_vf setText:nil];
        [overAll_imp_comt_View removeFromSuperview];
       
    }
    else if (alertView==savePerformance_Alert)
    {
        if([value isEqualToString:[dropdownArray objectAtIndex:0]])
        {
            
            [_mainScoreDict removeAllObjects];
            _mainScoreDict=[[NSMutableDictionary alloc]init];
            
            for (int i=0; i<[sortedAry count]; i++)
            {
                [_mainScoreDict setObject:[NSArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil] forKey:[NSNumber numberWithInt:i]];
            }
            
            // Check box clear
            [containsArray removeAllObjects];
            containsArray=[[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"", nil];
            [diction removeAllObjects];
            diction=[[NSMutableDictionary alloc]init];
            
            //for stunts numberofcell
            for(int i=0;i<[sortedAry count];i++)
            {
                
                
                [containsArray insertObject:[[NSMutableArray alloc]initWithObjects:@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png", nil] atIndex:i];
                
                
                
                [diction setObject:[[NSMutableArray alloc]initWithObjects:@"", nil] forKey:[NSNumber numberWithInt:i]];
            }
            
            // Clear TF
            txt_scor_value.text=nil;
            overallimpression_tf.text=nil;
            totalscrore_lbl.text=nil;
            
            StuntsumFloat=0.0;
            
            // totalscrore_lbl.text=[NSString stringWithFormat:@"0.0/%d",stuntTotal];
            // totalscrore_lbl.text=[NSString stringWithFormat:@"0.0/%d",ratingTitle_IDAry.count*10+10];
            totalscrore_lbl.text=[NSString stringWithFormat:@"0.0/%d",DivScore_stunt];
            [tableview1 reloadData];
            
            
            if (buttonIndex==0)
            {
                //AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
                //[delegate.viewController_leftPane showLeftPanelAnimated:YES];
                
                
                // tf Values Clear
                
                
                //next team
                
                Singleton *s=[Singleton getObject];
                
                 NSArray *ar_key=[Dict_session  allKeys];
                
                    //[s setTeam_id:[ar_secTeam objectAtIndex:nextTeam_index]];
                    NSLog(@"TeamID=%@",[s team_id]);
                    
                    //[s setLevel_Name:[ar_secTeam_level objectAtIndex:nextTeam_index]];
                    //[s setGym_Name:[ar_secTeam_div objectAtIndex:nextTeam_index]];
                    
                    //[s setSelected_index:[NSString stringWithFormat:@"%d",nextTeam_index]];
                    
                    //[s setLevel_Name:[[[Dict_session objectForKey:[sortArray objectAtIndex:i]]objectAtIndex:j]objectForKey:@"team_level"]];
                    //[s setGym_Name:[[[Dict_session objectForKey:[sortArray objectAtIndex:i]]objectAtIndex:j]objectForKey:@"division"]];
                    NSLog(@"Level:%@",[s level_Name]);
                    NSLog(@"Division :%@",[s gym_Name]);
                    
                    nextTeam_index=[s.selected_index intValue];
                    
                   
                    
                    NSArray *sortArray= [ar_key sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
                    NSString *sec_str=[sortArray objectAtIndex:[s.selected_section intValue]];
                    
                    NSArray *sec_countArray=[Dict_session objectForKey:sec_str];
                    int sec = [s.selected_section intValue];
                    //nextTeam_index++;
                    if ([sec_countArray count]-1==nextTeam_index)
                    {
                        
                       

                        if ((sec==[sortArray count]-1)&&([sec_countArray count]-1==nextTeam_index))
                        {
                            NoMoreTeam_alert=[[UIAlertView alloc]initWithTitle:@"No More Team" message:@"Please Search Again" delegate:self cancelButtonTitle:@"Search" otherButtonTitles:@"Cancel", nil];
                            [NoMoreTeam_alert show];
                        }
                        else
                        {
                             sec++;
                            //sec=[s.selected_section intValue];
                            nextTeam_index=0;
                            [s setSelected_index:[NSString stringWithFormat:@"%d",nextTeam_index]];
                            [s setSelected_section:[NSString stringWithFormat:@"%d",sec]];
                            
                            [s setTeam_id:[[[Dict_session objectForKey:[sortArray objectAtIndex:sec]] objectAtIndex:nextTeam_index] objectForKey:@"team_id"]];
                            [s setLevel_Name:[[[Dict_session objectForKey:[sortArray objectAtIndex:sec]] objectAtIndex:nextTeam_index] objectForKey:@"team_level"]];
                            [s setGym_Name:[[[Dict_session objectForKey:[sortArray objectAtIndex:sec]] objectAtIndex:nextTeam_index] objectForKey:@"division"]];
                            
                            nextTeam_index++;
                            
                        }
                        
                        
                       
                        
                        

                    }
                    else
                    {
                         nextTeam_index++;
                        [s setSelected_index:[NSString stringWithFormat:@"%d",nextTeam_index]];
                        [s setSelected_section:[NSString stringWithFormat:@"%d",sec]];
                        
                        [s setTeam_id:[[[Dict_session objectForKey:[sortArray objectAtIndex:sec]] objectAtIndex:nextTeam_index] objectForKey:@"team_id"]];
                        [s setLevel_Name:[[[Dict_session objectForKey:[sortArray objectAtIndex:sec]] objectAtIndex:nextTeam_index] objectForKey:@"team_level"]];
                        [s setGym_Name:[[[Dict_session objectForKey:[sortArray objectAtIndex:sec]] objectAtIndex:nextTeam_index] objectForKey:@"division"]];
                        
                        //nextTeam_index++;
                        
                        
                    }
                    
                    
                    
                    
                    
                    //[s setSelected_section:[NSString stringWithFormat:@"%d",nextTeam_index]];
                    
                    //[s setLeftpan_selecteTeam:[NSString stringWithFormat:@"%d",nextTeam_index]];
                    
                    //lbl_main_cheer_name.text=[array_List objectAtIndex:nextTeam_index];
                    //lbl_main_cheer_address.text=[ar_secTeam_location objectAtIndex:nextTeam_index];
                    
                    [self display_performancetype];
                    [self teamInfo_Display];
                    
                    
                    
                
 
            }
            else if (buttonIndex==1)
            {
                //Singleton *s=[Singleton getObject];
                //[s setScreenID:@"2"];
                //dropdownArray_IDSTR=@"2";
                //[self display_performancetype];
                [self pickbtn_clicked:btn_Selected_cat];
                [pickview selectRow:1 inComponent:0 animated:YES];
                
            }
            
        }
        else if ([value isEqualToString:[dropdownArray objectAtIndex:1]])
        {
            //AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
            //[delegate.viewController_leftPane showLeftPanelAnimated:YES];
            
            
            
            // tf Values Clear
            [_mainScoreDict_tumbling removeAllObjects];
            _mainScoreDict_tumbling = [[NSMutableDictionary alloc]init];
            for (int i=0; i<[sortedAry count]; i++)
            {
                [_mainScoreDict_tumbling setObject:[NSArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil] forKey:[NSNumber numberWithInt:i]];
            }
            
            // Check box clear
            [containsArrayTumble removeAllObjects];
            containsArrayTumble =[[NSMutableArray alloc]initWithObjects:@"",@"",@"", nil];
            [dictionTumble removeAllObjects];
            dictionTumble=[[NSMutableDictionary alloc]init];
            //for tumbling numberofcell
            for(int i=0;i<[sortedAry count];i++)
            {
                
                
                [containsArrayTumble insertObject:[[NSMutableArray alloc]initWithObjects:@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png", @"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",nil] atIndex:i];
                
                
                [dictionTumble setObject:[[NSMutableArray alloc]initWithObjects:@"", nil] forKey:[NSNumber numberWithInt:i]];
                
            }
            
            // Clear TF
            txt_overAll_impr_scor_value_tc.text=nil;
            lbl_totalScore_value_tc.text=nil;
            // lbl_totalScore_value_tc.text=@"0.0/75";
            tumble_overallScore=nil;
            ThumbsumFloat=0.0;
            
            //lbl_totalScore_value_tc.text=[NSString stringWithFormat:@"0.0/%d",ratingTitle_IDAry.count*10+5];
            lbl_totalScore_value_tc.text=[NSString stringWithFormat:@"0.0/%d",DivScore_tumble];
            
            
            [tableview1 reloadData];
            
            if (buttonIndex==0)
            {
                //AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
                //[delegate.viewController_leftPane showLeftPanelAnimated:YES];
                
                
                // tf Values Clear
                
                
                //next team
                
                Singleton *s=[Singleton getObject];
                
                NSArray *ar_key=[Dict_session  allKeys];
                
                //[s setTeam_id:[ar_secTeam objectAtIndex:nextTeam_index]];
                NSLog(@"TeamID=%@",[s team_id]);
                
                //[s setLevel_Name:[ar_secTeam_level objectAtIndex:nextTeam_index]];
                //[s setGym_Name:[ar_secTeam_div objectAtIndex:nextTeam_index]];
                
                //[s setSelected_index:[NSString stringWithFormat:@"%d",nextTeam_index]];
                
                //[s setLevel_Name:[[[Dict_session objectForKey:[sortArray objectAtIndex:i]]objectAtIndex:j]objectForKey:@"team_level"]];
                //[s setGym_Name:[[[Dict_session objectForKey:[sortArray objectAtIndex:i]]objectAtIndex:j]objectForKey:@"division"]];
                NSLog(@"Level:%@",[s level_Name]);
                NSLog(@"Division :%@",[s gym_Name]);
                
                nextTeam_index=[s.selected_index intValue];
                
                
                
                NSArray *sortArray= [ar_key sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
                NSString *sec_str=[sortArray objectAtIndex:[s.selected_section intValue]];
                
                NSArray *sec_countArray=[Dict_session objectForKey:sec_str];
                int sec = [s.selected_section intValue];
                //nextTeam_index++;
                if ([sec_countArray count]-1==nextTeam_index)
                {
                    
                    
                    
                    if ((sec==[sortArray count]-1)&&([sec_countArray count]-1==nextTeam_index))
                    {
                        NoMoreTeam_alert=[[UIAlertView alloc]initWithTitle:@"No More Team" message:@"Please Search Again" delegate:self cancelButtonTitle:@"Search" otherButtonTitles:@"Cancel", nil];
                        [NoMoreTeam_alert show];
                    }
                    else
                    {
                        sec++;
                        //sec=[s.selected_section intValue];
                        nextTeam_index=0;
                        [s setSelected_index:[NSString stringWithFormat:@"%d",nextTeam_index]];
                        [s setSelected_section:[NSString stringWithFormat:@"%d",sec]];
                        
                        [s setTeam_id:[[[Dict_session objectForKey:[sortArray objectAtIndex:sec]] objectAtIndex:nextTeam_index] objectForKey:@"team_id"]];
                        [s setLevel_Name:[[[Dict_session objectForKey:[sortArray objectAtIndex:sec]] objectAtIndex:nextTeam_index] objectForKey:@"team_level"]];
                        [s setGym_Name:[[[Dict_session objectForKey:[sortArray objectAtIndex:sec]] objectAtIndex:nextTeam_index] objectForKey:@"division"]];
                        
                        nextTeam_index++;
                        
                    }
                    
                    
                    
                    
                    
                    
                }
                else
                {
                    nextTeam_index++;
                    [s setSelected_index:[NSString stringWithFormat:@"%d",nextTeam_index]];
                    [s setSelected_section:[NSString stringWithFormat:@"%d",sec]];
                    
                    [s setTeam_id:[[[Dict_session objectForKey:[sortArray objectAtIndex:sec]] objectAtIndex:nextTeam_index] objectForKey:@"team_id"]];
                    [s setLevel_Name:[[[Dict_session objectForKey:[sortArray objectAtIndex:sec]] objectAtIndex:nextTeam_index] objectForKey:@"team_level"]];
                    [s setGym_Name:[[[Dict_session objectForKey:[sortArray objectAtIndex:sec]] objectAtIndex:nextTeam_index] objectForKey:@"division"]];
                    
                    //nextTeam_index++;
                    
                    
                }
                
                
                
                
                
                //[s setSelected_section:[NSString stringWithFormat:@"%d",nextTeam_index]];
                
                //[s setLeftpan_selecteTeam:[NSString stringWithFormat:@"%d",nextTeam_index]];
                
                //lbl_main_cheer_name.text=[array_List objectAtIndex:nextTeam_index];
                //lbl_main_cheer_address.text=[ar_secTeam_location objectAtIndex:nextTeam_index];
                
                [self display_performancetype];
                [self teamInfo_Display];
                
                
                
                
                
            }
            else if (buttonIndex==1)
            {
                //Singleton *s=[Singleton getObject];
                //[s setScreenID:@"2"];
                //dropdownArray_IDSTR=@"2";
                //[self display_performancetype];
                [self pickbtn_clicked:btn_Selected_cat];
                [pickview selectRow:2 inComponent:0 animated:YES];
                
            }
            
        }
        else if ([value isEqualToString:[dropdownArray objectAtIndex:2]])
        {
            
            //AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
            //[delegate.viewController_leftPane showLeftPanelAnimated:YES];
            
            
            
            
            // tf Values Clear
            [_mainScoreDict_choreoghaphy removeAllObjects];
            _mainScoreDict_choreoghaphy = [[NSMutableDictionary alloc]init];
            
            //  Number of cells for text fields
            for (int i=0; i<[sortedAry count]; i++)
            {
                [_mainScoreDict_choreoghaphy setObject:[NSArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil] forKey:[NSNumber numberWithInt:i]];
            }
            
            // Check box clear
            [containsArrayChoreo removeAllObjects];
            containsArrayChoreo=[[NSMutableArray alloc]initWithObjects:@"",@"",@"", nil];
            [dictionChoreo removeAllObjects];
            dictionChoreo=[[NSMutableDictionary alloc]init];
            //for choreo number of cell
            for(int i=0;i<[sortedAry count];i++)
            {
                
                
                [containsArrayChoreo insertObject:[[NSMutableArray alloc]initWithObjects:@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png", nil] atIndex:i];
                
                [dictionChoreo setObject:[[NSMutableArray alloc]initWithObjects:@"", nil] forKey:[NSNumber numberWithInt:i]];
                
            }
            
            // Clear TF
            txt_overAll_impr_scor_value_tc.text=nil;
            lbl_totalScore_value_tc.text=nil;
            // lbl_totalScore_value_tc.text=@"0.0/45";
            choreo_overallScore=nil;
            
            ChoreosumFloat=0.0;
            //lbl_totalScore_value_tc.text=[NSString stringWithFormat:@"0.0/%d",ratingTitle_IDAry.count*10+5];
            
            lbl_totalScore_value_tc.text=[NSString stringWithFormat:@"0.0/%d",DivScore_choreo];
            
            
            [tableview1 reloadData];
            
            if (buttonIndex==0)
            {
                //AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
                //[delegate.viewController_leftPane showLeftPanelAnimated:YES];
                
                
                // tf Values Clear
                
                
                //next team
                
                Singleton *s=[Singleton getObject];
                
                NSArray *ar_key=[Dict_session  allKeys];
                
                //[s setTeam_id:[ar_secTeam objectAtIndex:nextTeam_index]];
                NSLog(@"TeamID=%@",[s team_id]);
                
                //[s setLevel_Name:[ar_secTeam_level objectAtIndex:nextTeam_index]];
                //[s setGym_Name:[ar_secTeam_div objectAtIndex:nextTeam_index]];
                
                //[s setSelected_index:[NSString stringWithFormat:@"%d",nextTeam_index]];
                
                //[s setLevel_Name:[[[Dict_session objectForKey:[sortArray objectAtIndex:i]]objectAtIndex:j]objectForKey:@"team_level"]];
                //[s setGym_Name:[[[Dict_session objectForKey:[sortArray objectAtIndex:i]]objectAtIndex:j]objectForKey:@"division"]];
                NSLog(@"Level:%@",[s level_Name]);
                NSLog(@"Division :%@",[s gym_Name]);
                
                nextTeam_index=[s.selected_index intValue];
                
                
                
                NSArray *sortArray= [ar_key sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
                NSString *sec_str=[sortArray objectAtIndex:[s.selected_section intValue]];
                
                NSArray *sec_countArray=[Dict_session objectForKey:sec_str];
                int sec = [s.selected_section intValue];
                //nextTeam_index++;
                if ([sec_countArray count]-1==nextTeam_index)
                {
                    
                    
                    
                    if ((sec==[sortArray count]-1)&&([sec_countArray count]-1==nextTeam_index))
                    {
                        NoMoreTeam_alert=[[UIAlertView alloc]initWithTitle:@"No More Team" message:@"Please Search Again" delegate:self cancelButtonTitle:@"Search" otherButtonTitles:@"Cancel", nil];
                        [NoMoreTeam_alert show];
                    }
                    else
                    {
                        sec++;
                        //sec=[s.selected_section intValue];
                        nextTeam_index=0;
                        [s setSelected_index:[NSString stringWithFormat:@"%d",nextTeam_index]];
                        [s setSelected_section:[NSString stringWithFormat:@"%d",sec]];
                        
                        [s setTeam_id:[[[Dict_session objectForKey:[sortArray objectAtIndex:sec]] objectAtIndex:nextTeam_index] objectForKey:@"team_id"]];
                        [s setLevel_Name:[[[Dict_session objectForKey:[sortArray objectAtIndex:sec]] objectAtIndex:nextTeam_index] objectForKey:@"team_level"]];
                        [s setGym_Name:[[[Dict_session objectForKey:[sortArray objectAtIndex:sec]] objectAtIndex:nextTeam_index] objectForKey:@"division"]];
                        
                        nextTeam_index++;
                        
                    }
                    
                }
                else
                {
                    nextTeam_index++;
                    [s setSelected_index:[NSString stringWithFormat:@"%d",nextTeam_index]];
                    [s setSelected_section:[NSString stringWithFormat:@"%d",sec]];
                    
                    [s setTeam_id:[[[Dict_session objectForKey:[sortArray objectAtIndex:sec]] objectAtIndex:nextTeam_index] objectForKey:@"team_id"]];
                    [s setLevel_Name:[[[Dict_session objectForKey:[sortArray objectAtIndex:sec]] objectAtIndex:nextTeam_index] objectForKey:@"team_level"]];
                    [s setGym_Name:[[[Dict_session objectForKey:[sortArray objectAtIndex:sec]] objectAtIndex:nextTeam_index] objectForKey:@"division"]];
                    
                    //nextTeam_index++;
                    
                    
                }
                
                
                
                
                
                //[s setSelected_section:[NSString stringWithFormat:@"%d",nextTeam_index]];
                
                //[s setLeftpan_selecteTeam:[NSString stringWithFormat:@"%d",nextTeam_index]];
                
                //lbl_main_cheer_name.text=[array_List objectAtIndex:nextTeam_index];
                //lbl_main_cheer_address.text=[ar_secTeam_location objectAtIndex:nextTeam_index];
                
                [self display_performancetype];
                [self teamInfo_Display];
                
                
                
                
                
            }

            else if (buttonIndex==1)
            {
                //Singleton *s=[Singleton getObject];
                //[s setScreenID:@"2"];
                //dropdownArray_IDSTR=@"2";
                //[self display_performancetype];
                [self pickbtn_clicked:btn_Selected_cat];
                [pickview selectRow:3 inComponent:0 animated:YES];
            }
            
            
            
        }
        
        else if([value isEqualToString:[dropdownArray objectAtIndex:3]])
        {
        
           
            if(alertView==savePerformance_Alert)
            {
                
                
                main_Dict_final=[[NSMutableDictionary alloc]init];
                lbl_totalScore_value_inDeduction.text=@"0.0";
                lbl_total_deduction.text=@"0.0";
                
                dedDict_IndexPath_Total_Lbl=[[NSMutableDictionary alloc]init];
                dedDict_IndexPath_Total_Lbl_Save=[[NSMutableDictionary alloc]init];
                //for timer
                dedDict_IndexPath_Total_Lbl_timeStamp=[[NSMutableDictionary alloc]init];
                dedDict_IndexPath_Total_Lbl_timeStamp_Save=[[NSMutableDictionary alloc]init];
                ar_ded_heading=[[NSMutableArray alloc]init];
                ar_Ded_Label=[[NSMutableArray alloc]init];
                array_cellLbl_tumbling=[[NSMutableArray alloc]init];
                
                [deddict enumerateKeysAndObjectsUsingBlock:^(id obj,id key,BOOL *flag)
                 {
                     [ar_ded_heading addObject:obj];
                     NSLog(@"%@",ar_ded_heading);
                     
                     
                     
                 }];
                
                
                for(int i=0;i<[ar_ded_heading count];i++)
                {
                    [total_Sum setObject:[[NSMutableArray alloc]initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil] forKey:[NSNumber numberWithInt:i]];
                    
                    
                    
                    
                    [array_cellLbl_tumbling addObject:[deddict objectForKey:[ar_ded_heading objectAtIndex:i]]];
                    
                    
                    
                    NSDictionary *dict=  [array_cellLbl_tumbling objectAtIndex:i];
                    NSLog(@"%@",dict.allKeys);
                    
                    main_Dict=[[NSMutableDictionary alloc]init];
                    
                    main_Dict_Save=[[NSMutableDictionary alloc]init];
                    
                    main_Dict_TimeStamp_Save=[[NSMutableDictionary alloc]init];
                    
                    
                    for(int row=0;row<[[dict allKeys]count];row++)
                    {
                        [main_Dict_Save setObject:[[NSMutableArray alloc]initWithObjects:@"0.0",@"0.0",@"0.0", nil] forKey:[NSNumber numberWithInt:row]];
                        
                        
                        //for timer
                        [main_Dict_TimeStamp_Save setObject:[[NSMutableArray alloc]initWithObjects:@"00:00:00",nil] forKey:[NSNumber numberWithInt:row]];
                        
                        
                        
                        for(int k=0;k<3;k++)
                        {
                            [main_Dict setObject:[[NSMutableArray alloc]initWithObjects:@"0.0",@"0.0",@"0.0", nil] forKey:[NSNumber numberWithInt:row]];
                            
                            
                        }
                        
                    }
                    
                    [main_Dict_final setObject:main_Dict forKey:[NSNumber numberWithInt:i]];
                    [dedDict_IndexPath_Total_Lbl_Save setObject:main_Dict_Save forKey:[NSNumber numberWithInt:i]];
                    
                    //for timer
                    
                    [dedDict_IndexPath_Total_Lbl_timeStamp_Save setObject:main_Dict_TimeStamp_Save forKey:[NSNumber numberWithInt:i]];
                }
                
                
                
                [tableview1 reloadData];
                
                
                if (buttonIndex==0)
                {
                    //AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
                    //[delegate.viewController_leftPane showLeftPanelAnimated:YES];
                    
                    
                    // tf Values Clear
                    
                    
                    //next team
                    
                    Singleton *s=[Singleton getObject];
                    
                    NSArray *ar_key=[Dict_session  allKeys];
                    
                    //[s setTeam_id:[ar_secTeam objectAtIndex:nextTeam_index]];
                    NSLog(@"TeamID=%@",[s team_id]);
                    
                    //[s setLevel_Name:[ar_secTeam_level objectAtIndex:nextTeam_index]];
                    //[s setGym_Name:[ar_secTeam_div objectAtIndex:nextTeam_index]];
                    
                    //[s setSelected_index:[NSString stringWithFormat:@"%d",nextTeam_index]];
                    
                    //[s setLevel_Name:[[[Dict_session objectForKey:[sortArray objectAtIndex:i]]objectAtIndex:j]objectForKey:@"team_level"]];
                    //[s setGym_Name:[[[Dict_session objectForKey:[sortArray objectAtIndex:i]]objectAtIndex:j]objectForKey:@"division"]];
                    NSLog(@"Level:%@",[s level_Name]);
                    NSLog(@"Division :%@",[s gym_Name]);
                    
                    nextTeam_index=[s.selected_index intValue];
                    
                    
                    
                    NSArray *sortArray= [ar_key sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
                    NSString *sec_str=[sortArray objectAtIndex:[s.selected_section intValue]];
                    
                    NSArray *sec_countArray=[Dict_session objectForKey:sec_str];
                    int sec = [s.selected_section intValue];
                    //nextTeam_index++;
                    if ([sec_countArray count]-1==nextTeam_index)
                    {
                        if ((sec==[sortArray count]-1)&&([sec_countArray count]-1==nextTeam_index))
                        {
                            NoMoreTeam_alert=[[UIAlertView alloc]initWithTitle:@"No More Team" message:@"Please Search Again" delegate:self cancelButtonTitle:@"Search" otherButtonTitles:@"Cancel", nil];
                            [NoMoreTeam_alert show];
                        }
                        else
                        {
                            sec++;
                            //sec=[s.selected_section intValue];
                            nextTeam_index=0;
                            [s setSelected_index:[NSString stringWithFormat:@"%d",nextTeam_index]];
                            [s setSelected_section:[NSString stringWithFormat:@"%d",sec]];
                            
                            [s setTeam_id:[[[Dict_session objectForKey:[sortArray objectAtIndex:sec]] objectAtIndex:nextTeam_index] objectForKey:@"team_id"]];
                            [s setLevel_Name:[[[Dict_session objectForKey:[sortArray objectAtIndex:sec]] objectAtIndex:nextTeam_index] objectForKey:@"team_level"]];
                            [s setGym_Name:[[[Dict_session objectForKey:[sortArray objectAtIndex:sec]] objectAtIndex:nextTeam_index] objectForKey:@"division"]];
                            
                            nextTeam_index++;
                            
                        }
                
                        
                    }
                    else
                    {
                        nextTeam_index++;
                        [s setSelected_index:[NSString stringWithFormat:@"%d",nextTeam_index]];
                        [s setSelected_section:[NSString stringWithFormat:@"%d",sec]];
                        
                        [s setTeam_id:[[[Dict_session objectForKey:[sortArray objectAtIndex:sec]] objectAtIndex:nextTeam_index] objectForKey:@"team_id"]];
                        [s setLevel_Name:[[[Dict_session objectForKey:[sortArray objectAtIndex:sec]] objectAtIndex:nextTeam_index] objectForKey:@"team_level"]];
                        [s setGym_Name:[[[Dict_session objectForKey:[sortArray objectAtIndex:sec]] objectAtIndex:nextTeam_index] objectForKey:@"division"]];
                        
                        //nextTeam_index++;
                    }
                    //[s setSelected_section:[NSString stringWithFormat:@"%d",nextTeam_index]];
                    
                    //[s setLeftpan_selecteTeam:[NSString stringWithFormat:@"%d",nextTeam_index]];
                    
                    //lbl_main_cheer_name.text=[array_List objectAtIndex:nextTeam_index];
                    //lbl_main_cheer_address.text=[ar_secTeam_location objectAtIndex:nextTeam_index];
                    
                    [self display_performancetype];
                    [self teamInfo_Display];

                    
                }
            if(buttonIndex==1)
            {
                if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
                {
                    TeamSummaryViewController *controller=[[TeamSummaryViewController alloc]initWithNibName:@"TeamSummaryViewController" bundle:nil];
                    
                    // [self presentViewController:controller animated:YES completion:nil];
                    [self.navigationController pushViewController:controller animated:YES];
                }
                else
                {
                    TeamSummaryViewController *controller=[[TeamSummaryViewController alloc]initWithNibName:@"TeamSummaryViewController_ios6" bundle:nil];
                    
                    // [self presentViewController:controller animated:YES completion:nil];
                    [self.navigationController pushViewController:controller animated:YES];
                }
                
            }
                
            }

        
        }
    }
    
    else if (alertView==NoMoreTeam_alert)
    {
        if (buttonIndex==0)
        {
            if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
            {
                SearchViewController *obj=[[SearchViewController alloc]initWithNibName:@"SearchViewController" bundle:nil];
                [obj setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
                [self presentViewController:obj animated:YES completion:nil];
            }
            else
            {
                SearchViewController *obj=[[SearchViewController alloc]initWithNibName:@"SearchViewController_ios6" bundle:nil];
                [obj setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
                [self presentViewController:obj animated:YES completion:nil];
            }
            
        }
        else if (buttonIndex==1)
        {
            
        }
    }
    
}
- (IBAction)search_clicked:(id)sender
{
    
    [tf_gym setPlaceholder:@"Gym"];
    UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"" message:@"Results Not Found" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alt show];
 

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    if ([value isEqualToString:[dropdownArray objectAtIndex:3]])
    {
        
        NSDictionary *dict=  [array_cellLbl_tumbling objectAtIndex:indexPath.row];

       if (dict.allKeys.count<=3)
        {
            return 180;
        }
        else
            return dict.allKeys.count*40+44;
        
    }
    else
    {
        
        NSString *Fullstr=[res_dict_comments objectForKey:[sortedAry objectAtIndex:indexPath.row]];
        Ary_getcomments=[Fullstr componentsSeparatedByString:@"|"];
        
        NSLog(@"heightForCell=%d",(int)[[heightForCell objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]integerValue]);
        
        NSLog(@"heightForCell=%d",(int)[Ary_getcomments count]/2);
        
        if ([[heightForCell objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]integerValue] >= [Ary_getcomments count]/2)
        {
            
            NSLog(@"heightForCell=%@",[heightForCell objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]);
            return [[heightForCell objectForKey:[NSNumber numberWithInt:(int)indexPath.row]]integerValue]*63+44;
        }
        else
        {
            NSLog(@"heightForCell=%u",[Ary_getcomments count]/2*63+44);
            return [Ary_getcomments count]/2*63+44;
        }
        
        
    }
    
    
}

// overall comment button which is in not cell ...side one comment
-(IBAction)overAll_imp_comnt_clicked1:(id)sender
{
     comment_vf_Overall.text=nil;
    
    overAll_imp_comt_View_New1.transform = CGAffineTransformMakeScale(0.05, 0.05);
    [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        // animate it to the identity transform (100% scale)
        overAll_imp_comt_View_New1.transform = CGAffineTransformIdentity;
    } completion:nil];
    btn_submitFrom_comment.hidden=NO;
    
    [self.view addSubview:overAll_imp_comt_View_New1];
    
}

//stunts check box button
-(void)checked_button_clicked:(UIButton *)sender
{
    //int tagVale=sender.tag;
    
    //Singleton *s=[Singleton getObject];
    
   UIButton *btn=(UIButton *)sender;
    
   // NSLog(@"%d",[btn tag]);
    //CustomCell *cell1 = (CustomCell *)[self.tableview1 cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[sender tag] inSection:0]];
  // CustomCell *cell1 = (CustomCell *)[self.view viewWithTag:100];
    
    
   // ars=[ [[s ar_tick_comment_stunts_data]objectAtIndex:[sender tag]] mutableCopy];
    ars=[[diction objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]mutableCopy];
    
    
    for (int i=0; i<[[DictCheckLbl_stunt objectForKey:[NSNumber numberWithInt:(int)sender.tag]] count]; i++)
    {
        if ([[DictCheckBtn_stunt objectForKey:[NSNumber numberWithInt:(int)sender.tag]] objectAtIndex:i]==sender)
        {
            if ([btn.imageView.image isEqual:[UIImage imageNamed:@"Without-Tick_iph.png"]])
            {
                if(![ars containsObject:[[DictCheckLbl_stunt objectForKey:[NSNumber numberWithInt:(int)sender.tag]] objectAtIndex:i]])
                {
                    [[diction objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]addObject:[[[DictCheckLbl_stunt objectForKey:[NSNumber numberWithInt:(int)sender.tag]] objectAtIndex:i] text]];
                    
                    NSLog(@"Checked comment is:::%@",[[[DictCheckLbl_stunt objectForKey:[NSNumber numberWithInt:(int)sender.tag]] objectAtIndex:i] text]);
                    
                    
                    
              
                }
                
                [[containsArray objectAtIndex:[sender tag]]removeObjectAtIndex:i];
                
                [[containsArray objectAtIndex:[sender tag]] insertObject:@"With-tick_iph.png" atIndex:i];
                [btn setImage:[UIImage imageNamed: [[containsArray objectAtIndex:[sender tag]] objectAtIndex:i]] forState:UIControlStateNormal];
                
                
            }
            else
            {
                
                for(id x in ars)
                    
                {
                    if([[diction objectForKey:[NSNumber numberWithInt:(int)[sender tag]]] containsObject:[[[DictCheckLbl_stunt objectForKey:[NSNumber numberWithInt:(int)sender.tag]] objectAtIndex:i] text]])
                    {
                        
                        [[diction objectForKey:[NSNumber numberWithInt:(int)[sender tag]]] removeObject:[[[DictCheckLbl_stunt objectForKey:[NSNumber numberWithInt:(int)sender.tag]] objectAtIndex:i] text]];
                        NSLog(@"unched cmt:::%@",[[[DictCheckLbl_stunt objectForKey:[NSNumber numberWithInt:(int)sender.tag]] objectAtIndex:i] text]);
                        NSLog(@"Check dictionary %@",diction);

                        
                        
                    }
                    
                }
                
                [[containsArray objectAtIndex:[sender tag]]removeObjectAtIndex:i];
                [[containsArray objectAtIndex:[sender tag]] insertObject:@"Without-Tick_iph.png" atIndex:i];
                [btn setImage:[UIImage imageNamed: [[containsArray objectAtIndex:[sender tag]] objectAtIndex:i]] forState:UIControlStateNormal];
                
                
            }
            
            
        }
    
    }

    NSLog(@"stuntsat index:%d value: %@",(int)[sender tag],[diction objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]);
    
}

//tumbling screen checkbox button
-(void)checked_button_clicked1:(UIButton *)sender
{


    UIButton *btn=(UIButton *)sender;
     //CustomCell *cell1 = (CustomCell *)[self.tableview1 cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[sender tag] inSection:0]];
            ars=[[dictionTumble objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]mutableCopy];
    
    for (int i=0; i<[[DictCheckLbl_tumble objectForKey:[NSNumber numberWithInt:(int)sender.tag]] count]; i++)
    {
        if ([[DictCheckBtn_tumble objectForKey:[NSNumber numberWithInt:(int)sender.tag]] objectAtIndex:i]==sender)
        {
            if ([btn.imageView.image isEqual:[UIImage imageNamed:@"Without-Tick_iph.png"]])
            {
                if(![ars containsObject:[[DictCheckLbl_tumble objectForKey:[NSNumber numberWithInt:(int)sender.tag]] objectAtIndex:i]])
                {
                    [[dictionTumble objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]addObject:[[[DictCheckLbl_tumble objectForKey:[NSNumber numberWithInt:(int)sender.tag]] objectAtIndex:i] text]];
                    
                    NSLog(@"Checked comment is:::%@",[[[DictCheckLbl_tumble objectForKey:[NSNumber numberWithInt:(int)sender.tag]] objectAtIndex:i] text]);
                    
                    NSLog(@"Check dictionary %@",dictionTumble);
                    
                    
                    
                    
                }
                
                [[containsArrayTumble objectAtIndex:[sender tag]]removeObjectAtIndex:i];
                
                [[containsArrayTumble objectAtIndex:[sender tag]] insertObject:@"With-tick_iph.png" atIndex:i];
                [btn setImage:[UIImage imageNamed: [[containsArrayTumble objectAtIndex:[sender tag]] objectAtIndex:i]] forState:UIControlStateNormal];
                
                
            }
            else
            {
                
                for(id x in ars)
                    
                {
                    if([[dictionTumble objectForKey:[NSNumber numberWithInt:(int)[sender tag]]] containsObject:[[[DictCheckLbl_tumble objectForKey:[NSNumber numberWithInt:(int)sender.tag]] objectAtIndex:i] text]])
                    {
                        
                        [[dictionTumble objectForKey:[NSNumber numberWithInt:(int)[sender tag]]] removeObject:[[[DictCheckLbl_tumble objectForKey:[NSNumber numberWithInt:(int)sender.tag]] objectAtIndex:i] text]];
                        NSLog(@"unched cmt:::%@",[[[DictCheckLbl_tumble objectForKey:[NSNumber numberWithInt:(int)sender.tag]] objectAtIndex:i] text]);
                        NSLog(@"Check dictionary %@",dictionTumble);
                        
                        
                        
                    }
                    
                }
                
                [[containsArrayTumble objectAtIndex:[sender tag]]removeObjectAtIndex:i];
                [[containsArrayTumble objectAtIndex:[sender tag]] insertObject:@"Without-Tick_iph.png" atIndex:i];
                [btn setImage:[UIImage imageNamed: [[containsArrayTumble objectAtIndex:[sender tag]] objectAtIndex:i]] forState:UIControlStateNormal];
                
                
            }
            
            
        }
    }

    
       NSLog(@"tumble index:%d value: %@",(int)[sender tag],[dictionTumble objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]);
    
}
//check box button for choreo
-(void)checked_button_clicked2:(UIButton *)sender
{
    
    UIButton *btn=(UIButton *)sender;
    
    // NSLog(@"%d",[btn tag]);
    //CustomCell *cell1 = (CustomCell *)[self.tableview1 cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[sender tag] inSection:0]];
    
         ars=[[dictionChoreo objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]mutableCopy];
    
    
    
    for (int i=0; i<[[DictCheckLbl_choreo objectForKey:[NSNumber numberWithInt:(int)sender.tag]] count];i++)
    {
        if ([[DictCheckBtn_choreo objectForKey:[NSNumber numberWithInt:(int)sender.tag]] objectAtIndex:i]==sender)
        {
            if ([btn.imageView.image isEqual:[UIImage imageNamed:@"Without-Tick_iph.png"]])
            {
                if(![ars containsObject:[[DictCheckLbl_choreo objectForKey:[NSNumber numberWithInt:(int)sender.tag]] objectAtIndex:i]])
                {
                    [[dictionChoreo objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]addObject:[[[DictCheckLbl_choreo objectForKey:[NSNumber numberWithInt:(int)sender.tag]] objectAtIndex:i] text]];
                    
                    NSLog(@"Checked comment is:::%@",[[[DictCheckLbl_choreo objectForKey:[NSNumber numberWithInt:(int)sender.tag]] objectAtIndex:i] text]);
                    
                    NSLog(@"Check dictionary %@",dictionChoreo);
                    
                    
                    
                    
                }
                
                [[containsArrayChoreo objectAtIndex:[sender tag]]removeObjectAtIndex:i];
                
                [[containsArrayChoreo objectAtIndex:[sender tag]] insertObject:@"With-tick_iph.png" atIndex:i];
                [btn setImage:[UIImage imageNamed: [[containsArrayChoreo objectAtIndex:[sender tag]] objectAtIndex:i]] forState:UIControlStateNormal];
                
                
            }
            else
            {
                
                for(id x in ars)
                    
                {
                    if([[dictionChoreo objectForKey:[NSNumber numberWithInt:(int)[sender tag]]] containsObject:[[[DictCheckLbl_choreo objectForKey:[NSNumber numberWithInt:(int)sender.tag]] objectAtIndex:i] text]])
                    {
                        
                        [[dictionChoreo objectForKey:[NSNumber numberWithInt:(int)[sender tag]]] removeObject:[[[DictCheckLbl_choreo objectForKey:[NSNumber numberWithInt:(int)sender.tag]] objectAtIndex:i] text]];
                        NSLog(@"unched cmt:::%@",[[[DictCheckLbl_choreo objectForKey:[NSNumber numberWithInt:(int)sender.tag]] objectAtIndex:i] text]);
                        NSLog(@"Check dictionary %@",dictionChoreo);
                        
                        
                        
                    }
                    
                }
                
                [[containsArrayChoreo objectAtIndex:[sender tag]]removeObjectAtIndex:i];
                [[containsArrayChoreo objectAtIndex:[sender tag]] insertObject:@"Without-Tick_iph.png" atIndex:i];
                [btn setImage:[UIImage imageNamed: [[containsArrayChoreo objectAtIndex:[sender tag]] objectAtIndex:i]] forState:UIControlStateNormal];
                
                
            }
            
            
        }
    }
    
           NSLog(@"choreo index:%d value: %@",(int)[sender tag],[dictionChoreo objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]);

}

//checkbox button for dance
-(void)checked_button_clicked3:(UIButton *)sender
{
    
    UIButton *btn=(UIButton *)sender;
    
    // NSLog(@"%d",[btn tag]);
    //CustomCell *cell1 = (CustomCell *)[self.tableview1 cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[sender tag] inSection:0]];
    
    ars=[[dictionDance objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]mutableCopy];
    
    
    for (int i=0; i<[[DictCheckLbl_Dance objectForKey:[NSNumber numberWithInt:(int)sender.tag]] count]; i++)
    {
        if ([[DictCheckBtn_Dance objectForKey:[NSNumber numberWithInt:(int)sender.tag]] objectAtIndex:i]==sender)
        {
           if ([btn.imageView.image isEqual:[UIImage imageNamed:@"Without-Tick_iph.png"]])
            {
                if(![ars containsObject:[[DictCheckLbl_Dance objectForKey:[NSNumber numberWithInt:(int)sender.tag]] objectAtIndex:i]])
                {
                    [[dictionDance objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]addObject:[[[DictCheckLbl_Dance objectForKey:[NSNumber numberWithInt:(int)sender.tag]] objectAtIndex:i] text]];
                    
                    NSLog(@"Checked comment is:::%@",[[[DictCheckLbl_Dance objectForKey:[NSNumber numberWithInt:(int)sender.tag]] objectAtIndex:i] text]);
                    
                    NSLog(@"Check dictionary %@",dictionDance);
                    
                    
                }
                
                [[containsArrayDance objectAtIndex:[sender tag]]removeObjectAtIndex:i];
                
                [[containsArrayDance objectAtIndex:[sender tag]] insertObject:@"With-tick_iph.png" atIndex:i];
                [btn setImage:[UIImage imageNamed: [[containsArrayDance objectAtIndex:[sender tag]] objectAtIndex:i]] forState:UIControlStateNormal];
                
                
            }
            else
            {
                
                for(id x in ars)
                    
                {
                    if([[dictionDance objectForKey:[NSNumber numberWithInt:(int)[sender tag]]] containsObject:[[[DictCheckLbl_Dance objectForKey:[NSNumber numberWithInt:(int)sender.tag]] objectAtIndex:i] text]])
                    {
                        
                        [[dictionDance objectForKey:[NSNumber numberWithInt:(int)[sender tag]]] removeObject:[[[DictCheckLbl_Dance objectForKey:[NSNumber numberWithInt:(int)sender.tag]] objectAtIndex:i] text]];
                        NSLog(@"unched cmt:::%@",[[[DictCheckLbl_Dance objectForKey:[NSNumber numberWithInt:(int)sender.tag]] objectAtIndex:i] text]);
                        NSLog(@"Check dictionary %@",dictionDance);
                        
                        
                        
                    }
                    
                }
                
                [[containsArrayDance objectAtIndex:[sender tag]]removeObjectAtIndex:i];
                [[containsArrayDance objectAtIndex:[sender tag]] insertObject:@"Without-Tick_iph.png" atIndex:i];
                [btn setImage:[UIImage imageNamed: [[containsArrayDance objectAtIndex:[sender tag]] objectAtIndex:i]] forState:UIControlStateNormal];
                
                
            }
            
            
        }
    }
    NSLog(@"choreo index:%d value: %@",(int)[sender tag],[dictionDance objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]);
    
}


-(void)addbtn_clicked_fromDeduction:(UIButton *)sender
{
    if (running==NO)
    {
        [self starts];

        
    }
    
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:[sender tag] inSection:0];
    
    
    NSLog(@"sender is==%d",(int)[sender tag]);
    
    DeductionCell *cell1 = (DeductionCell *)[tableview1 cellForRowAtIndexPath:indexpath];
    NSLog(@"%@",[cell1.Lbl_cellHeading_fromDeduct1 text]);
    
    
    NSDictionary *dict1=  [array_cellLbl_tumbling objectAtIndex:indexpath.row];
   
    for(int i=0;i<[[dict1 allKeys]count];i++)
    {
        
        NSArray *ar_btn=  [[dedDict_indexPath_Button objectForKey:[NSNumber numberWithInt:(int)indexpath.row]]objectForKey:[NSNumber numberWithInt:i]];
        NSArray *ar= [[dedDict_indexPath objectForKey:[NSNumber numberWithInt:(int)indexpath.row]]objectForKey:[NSNumber numberWithInt:i]];
        
        NSMutableDictionary *d=[[NSMutableDictionary alloc]init];
        
        
        [d setObject:[[dedDict_indexPath objectForKey:[NSNumber numberWithInt:(int)indexpath.row]]objectForKey:[NSNumber numberWithInt:i]] forKey:[NSNumber numberWithInt:i]];
        
        
        
        
        for(int k=0;k<3;k++)
        {
            UIButton  *btn=(UIButton *)[ar_btn objectAtIndex:k];
            
            if(btn==sender)
            {
                UILabel *lb=(UILabel *)[ar objectAtIndex:k];
                
                
                //    [lb setText:@".5"];
                
                if(k==0)
                {
                    ftotal=[[[[main_Dict_final objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]objectForKey:[NSNumber  numberWithInt:i]]objectAtIndex:0]floatValue];
                    
                    if(ftotal >=5.0f)
                    {
                        NSLog(@"hi");
                        
                    }
                    else
                    {
                        
                        
                        ftotal+=0.5f;
                        [lb setText:[NSString stringWithFormat:@"%.1f",ftotal]];
                        NSLog(@"%f",ftotal);
                    }
                    
                }
                
                if(k==1)
                {
                    
                    ftotal=[[[[main_Dict_final objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]objectForKey:[NSNumber  numberWithInt:i]]objectAtIndex:1]floatValue];
                    
                    if(ftotal >=5.0f)
                    {
                        NSLog(@"hi");
                        
                    }
                    
                    
                    else
                    {
                        ftotal+=0.5f;
                        
                        [lb setText:[NSString stringWithFormat:@"%.1f",ftotal]];
                        
                    }
                    
                }
                
                if(k==2)
                {
                    
                    ftotal=[[[[main_Dict_final objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]objectForKey:[NSNumber  numberWithInt:i]]objectAtIndex:2]floatValue];
                    if(ftotal >=5.0f)
                    {
                        NSLog(@"hi");
                        
                    }
                    
                    
                    else
                    {
                        ftotal+=0.5f;
                        
                        [lb setText:[NSString stringWithFormat:@"%.1f",ftotal]];
                        
                    }
                    
                    
                }
                
                
                [d setObject:[[dedDict_indexPath objectForKey:[NSNumber numberWithInt:(int)indexpath.row]]objectForKey:[NSNumber numberWithInt:i]] forKey:[NSNumber numberWithInt:i]];
                
                //
                //   NSLog(@"value is %@",[d objectForKey:[NSNumber numberWithInt:i]]);
                
                float vals=0;
                
                
                
                
                for(int k=0;k<3;k++)
                {
                    UILabel *lb=(UILabel *)[ar objectAtIndex:k];
                    
                    vals=vals+[[lb text]floatValue];
                    
                    
                    [[[main_Dict_final objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]objectForKey:[NSNumber numberWithInt:i]]removeObjectAtIndex:k];
                    
                    
                    
                    
                    [[[main_Dict_final objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]objectForKey:[NSNumber numberWithInt:i]]insertObject:[lb text] atIndex:k];
                    
                    
                                   }
                
                float x=      [[[[main_Dict_final objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]objectForKey:[NSNumber  numberWithInt:i]]objectAtIndex:0]floatValue]+[[[[main_Dict_final objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]objectForKey:[NSNumber  numberWithInt:i]]objectAtIndex:1]floatValue]+[[[[main_Dict_final objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]objectForKey:[NSNumber  numberWithInt:i]]objectAtIndex:2]floatValue];
                
                
                UILabel *lbls=[[dedDict_IndexPath_Total_Lbl objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]objectForKey:[NSNumber numberWithInt:i]];
                
                [lbls setText:[NSString stringWithFormat:@"%.1f",x]];
                
                NSLog(@"deduction main dict %@",main_Dict_final);
                
                
                UILabel *lbd=[[dedDict_IndexPath_Total_Lbl_timeStamp objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]objectForKey:[NSNumber numberWithInt:i]];
                //for timer
                
                if(ftotal >=5.0f)
                {
                    
                }
                else
                {
                    [lbd setText:[NSString stringWithFormat:@"deducted at %@",[showTime text]]];//[showTime text]];
                    
                    [[[dedDict_IndexPath_Total_Lbl_Save objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]objectForKey:[NSNumber numberWithInt:i]]removeObjectAtIndex:0];
                    
                    [[[dedDict_IndexPath_Total_Lbl_Save objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]objectForKey:[NSNumber numberWithInt:i]]insertObject:[lbls text] atIndex:0];
                    
                    
                    //for timer
                    
                    [[[dedDict_IndexPath_Total_Lbl_timeStamp_Save objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]objectForKey:[NSNumber numberWithInt:i]]removeObjectAtIndex:0];
                    
                    NSString *lbl_Str=[lbd text];
                    
                    [[[dedDict_IndexPath_Total_Lbl_timeStamp_Save objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]objectForKey:[NSNumber numberWithInt:i]]insertObject:[lbl_Str stringByReplacingOccurrencesOfString:@"deducted at " withString:@""] atIndex:0];
                    
                }

                
                
                //////////////////////////
                
                //[[[dedDict_IndexPath_Total_Lbl_timeStamp_Save objectForKey:[NSNumber numberWithInt:[sender tag]]]objectForKey:[NSNumber numberWithInt:i]] addObject:[NSString stringWithFormat:@"%@ %@",lbls.text,lbd.text]];
                
                

                
                ////////////////////
                [[total_Sum objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]removeObjectAtIndex:i];
                [[total_Sum objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]insertObject:[lbls text] atIndex:i];
                
                
                NSLog(@"%@",total_Sum);
                
                
                
            }
            
        }
        
        
        
    }
    
    
    falt=0.0f;
    
    NSArray *Temp_Arr=[total_Sum allKeys];
    for(int i=0;i<Temp_Arr.count;i++)
    {
        NSArray *Temp_Val=[total_Sum objectForKey:[Temp_Arr objectAtIndex:i]];
        for(int k=0;k<[Temp_Val count];k++)
        {
            NSLog(@"%@ k=%d ",[Temp_Val objectAtIndex:k],k);
            
            falt+=[[Temp_Val objectAtIndex:k]floatValue];;
        }
    }
    
    
     lbl_total_deduction.text=[NSString stringWithFormat:@"%.1f",falt];
     lbl_totalScore_value_inDeduction.text=[NSString stringWithFormat:@"%.1f",falt];
    
    
}

-(void)subtractbtn_clicked_fromDeduction:(UIButton *)sender
{
    if (running==NO)
    {
        [self starts];
        
        
    }
    
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:[sender tag] inSection:0];
    
    
    NSLog(@"sender is==%d",(int)[sender tag]);
    
    DeductionCell *cell1 = (DeductionCell *)[tableview1 cellForRowAtIndexPath:indexpath];
    NSLog(@"%@",[cell1.Lbl_cellHeading_fromDeduct1 text]);
    
    
    NSDictionary *dict1=  [array_cellLbl_tumbling objectAtIndex:indexpath.row];
    for(int i=0;i<[[dict1 allKeys]count];i++)
    {
        
        NSArray *ar_btn=  [[dedDict_indexPath_Button_Minus objectForKey:[NSNumber numberWithInt:(int)indexpath.row]]objectForKey:[NSNumber numberWithInt:i]];
        NSArray *ar= [[dedDict_indexPath objectForKey:[NSNumber numberWithInt:(int)indexpath.row]]objectForKey:[NSNumber numberWithInt:i]];
        
        NSMutableDictionary *d=[[NSMutableDictionary alloc]init];
        
        
        [d setObject:[[dedDict_indexPath objectForKey:[NSNumber numberWithInt:(int)indexpath.row]]objectForKey:[NSNumber numberWithInt:i]] forKey:[NSNumber numberWithInt:i]];
        
        
        
        
        for(int k=0;k<3;k++)
        {
            UIButton  *btn=(UIButton *)[ar_btn objectAtIndex:k];
            
            if(btn==sender)
            {
                UILabel *lb=(UILabel *)[ar objectAtIndex:k];
                
                
                //    [lb setText:@".5"];
                
                if(k==0)
                {
                    ftotal=[[[[main_Dict_final objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]objectForKey:[NSNumber  numberWithInt:i]]objectAtIndex:0]floatValue];
                    
                    if(ftotal <=-5.0f)
                    {
                        NSLog(@"hi");
                        
                    }
                    else{
                        
                        
                        ftotal-=0.5f;
                        [lb setText:[NSString stringWithFormat:@"%.1f",ftotal]];
                        
                    }
                    
                }
                
                if(k==1)
                {
                    
                    ftotal=[[[[main_Dict_final objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]objectForKey:[NSNumber  numberWithInt:i]]objectAtIndex:1]floatValue];
                    
                    if(ftotal <=-5.0f)
                    {
                        NSLog(@"hi");
                        
                    }
                    
                    
                    else
                    {
                        ftotal-=0.5f;
                        [lb setText:[NSString stringWithFormat:@"%.1f",ftotal]];
                    }
                    
                }
                
                if(k==2)
                {
                    
                    ftotal=[[[[main_Dict_final objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]objectForKey:[NSNumber  numberWithInt:i]]objectAtIndex:2]floatValue];
                    if(ftotal <=-5.0f)
                    {
                        NSLog(@"hi");
                        
                    }
                    
                    
                    else
                    {
                        ftotal-=0.5f;
                        [lb setText:[NSString stringWithFormat:@"%.1f",ftotal]];
                        
                    }
                    
                }
                
                
                [d setObject:[[dedDict_indexPath objectForKey:[NSNumber numberWithInt:(int)indexpath.row]]objectForKey:[NSNumber numberWithInt:i]] forKey:[NSNumber numberWithInt:i]];
                
                
                //   NSLog(@"value is %@",[d objectForKey:[NSNumber numberWithInt:i]]);
                
                
                
                for(int k=0;k<3;k++)
                {
                    UILabel *lb=(UILabel *)[ar objectAtIndex:k];
                    
                    
                    
                    [[[main_Dict_final objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]objectForKey:[NSNumber numberWithInt:i]]removeObjectAtIndex:k];
                    
                    
                    
                    
                    [[[main_Dict_final objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]objectForKey:[NSNumber numberWithInt:i]]insertObject:[lb text] atIndex:k];
                                      
                    
                }
                
                float x=      [[[[main_Dict_final objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]objectForKey:[NSNumber  numberWithInt:i]]objectAtIndex:0]floatValue]+[[[[main_Dict_final objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]objectForKey:[NSNumber  numberWithInt:i]]objectAtIndex:1]floatValue]+[[[[main_Dict_final objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]objectForKey:[NSNumber  numberWithInt:i]]objectAtIndex:2]floatValue];
                
                //   NSLog(@"%.1f",x);
                
                
                UILabel *lbls=[[dedDict_IndexPath_Total_Lbl objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]objectForKey:[NSNumber numberWithInt:i]];
                [lbls setText:[NSString stringWithFormat:@"%.1f",x]];
                
                
               
                
                
                //for timer
                
                
                
                UILabel *lbd=[[dedDict_IndexPath_Total_Lbl_timeStamp objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]objectForKey:[NSNumber numberWithInt:i]];
                //for timer
                
                if(ftotal <=-5.0f)
                {
                    
                }
                else
                {
                    
                    [[[dedDict_IndexPath_Total_Lbl_Save objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]objectForKey:[NSNumber numberWithInt:i]]removeObjectAtIndex:0];
                    
                    
                    [[[dedDict_IndexPath_Total_Lbl_Save objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]objectForKey:[NSNumber numberWithInt:i]]insertObject:[lbls text] atIndex:0];
                    
                    
                    
                    [lbd setText:[NSString stringWithFormat:@"deducted at %@",[showTime text]]];
                    
                    [[[dedDict_IndexPath_Total_Lbl_timeStamp_Save objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]objectForKey:[NSNumber numberWithInt:i]]removeObjectAtIndex:0];
                    
                    NSString *lbl_Str=[lbd text];
                    
                    
                    [[[dedDict_IndexPath_Total_Lbl_timeStamp_Save objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]objectForKey:[NSNumber numberWithInt:i]]insertObject:[lbl_Str stringByReplacingOccurrencesOfString:@"deducted at " withString:@""] atIndex:0];
                    
                }

                
                [[total_Sum objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]removeObjectAtIndex:i];
                [[total_Sum objectForKey:[NSNumber numberWithInt:(int)[sender tag]]]insertObject:[lbls text] atIndex:i];
          
            }
        }
    }
    
    
    falt=0.0f;
    
    NSArray *Temp_Arr=[total_Sum allKeys];
    for(int i=0;i<Temp_Arr.count;i++)
    {
        NSArray *Temp_Val=[total_Sum objectForKey:[Temp_Arr objectAtIndex:i]];
        for(int k=0;k<[Temp_Val count];k++)
        {
            NSLog(@"%@ k=%d ",[Temp_Val objectAtIndex:k],k);
            
            falt+=[[Temp_Val objectAtIndex:k]floatValue];;
        }
    }
    
    
    lbl_total_deduction.text=[NSString stringWithFormat:@"%.1f",falt];
    lbl_totalScore_value_inDeduction.text=[NSString stringWithFormat:@"%.1f",falt];
    
    
    NSLog(@"totalsum%@",total_Sum);}


-(void)comntFromDeductcell:(UIButton *)sender
{
    btn_submitFrom_comment.tag=[sender tag];
    comment_vf.text=nil;
    if (![[commentStore_indedction objectAtIndex:sender.tag] isEqualToString:@""]) {
        
    comment_vf.text=[commentStore_indedction objectAtIndex:sender.tag];
    }
    //comment_vf.text=nil;
    
    subTypeSTR=[[NSMutableString alloc]init];
    subTypeSTR=[ar_ded_heading objectAtIndex:sender.tag];
    NSLog(@"subTypeSTR=%@",subTypeSTR);
    
    overAll_imp_comt_View.transform = CGAffineTransformMakeScale(0.05, 0.05);
    [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        // animate it to the identity transform (100% scale)
        overAll_imp_comt_View.transform = CGAffineTransformIdentity;
    } completion:nil];
    
     [self.view addSubview:overAll_imp_comt_View];
     [comment_vf becomeFirstResponder];
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    
    [textField resignFirstResponder];
    [self.tableview1 setContentOffset:CGPointZero animated:YES];
    
    if (textField==txt_scor_value || textField==overallimpression_tf)
    {
        
        
    }
    else
    {
        CGPoint pointInTable = [textField.superview convertPoint:textField.frame.origin toView:self.tableview1];
        CGPoint contentOffset = self.tableview1.contentOffset;
        
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
        {
            contentOffset.y = (pointInTable.y - textField.inputAccessoryView.frame.size.height)-10;
        }
        else
        {
            contentOffset.y = (pointInTable.y - textField.inputAccessoryView.frame.size.height)-15;
        }
        
        NSLog(@"contentOffset is: %@", NSStringFromCGPoint(contentOffset));
        
        [self.tableview1 setContentOffset:contentOffset animated:YES];
    }
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if([textField text].length>3)
    {
        [textField setText:nil];
        //  return NO;
        
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    for(int i=0;i<[[array123Dict objectForKey:[NSNumber numberWithInt:(int)textField.tag]]count];i++)
        
    {
        
        
        if ( [[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)[textField tag]]]objectAtIndex:i] == textField)
            
        {
            [[[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)[textField tag]]]objectAtIndex:i]setKeyboardType:UIKeyboardTypeNumberPad];
        }
    }
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"tag=%ld",(long)[textField tag]);
    
    
    CustomCell *cell1=(CustomCell *)[tableview1 cellForRowAtIndexPath:[NSIndexPath indexPathForRow:textField.tag inSection:0]];
    
    
    
    [[[cell1.contentView subviews] objectAtIndex:0] tag ];
    
    NSLog(@"%d",(int)[[[cell1.contentView subviews] objectAtIndex:0] tag ]);
    NSLog(@"%d",(int)[[[cell1.contentView subviews] objectAtIndex:1] tag ]);
    NSLog(@"%d",(int)[[[cell1.contentView subviews] objectAtIndex:2] tag ]);
    
    if([value isEqualToString:[dropdownArray objectAtIndex:0]])
    {
        // Kundan
        NSMutableArray *arrr = [NSMutableArray arrayWithArray:[_mainScoreDict objectForKey:[NSNumber numberWithInt:(int)[textField tag]]]];
        
        for(int i=0;i<[[array123Dict objectForKey:[NSNumber numberWithInt:(int)textField.tag]]count];i++)
            
        {
            
            if ( [[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)[textField tag]]]objectAtIndex:i] == textField)
            {
                [arrr removeObjectAtIndex:i];
                
                NSLog(@"%@ i=%d",[[[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)[textField tag]]]objectAtIndex:i] text],i);
                [arrr insertObject:[[[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)[textField tag]]]objectAtIndex:i] text] atIndex:i];
                
            }
            
        }
        
        
        [_mainScoreDict setObject:arrr forKey:[NSNumber numberWithInt:(int)[textField tag]]];
        NSLog(@"_mainScoreDict=%@",_mainScoreDict);
        NSLog(@"======%@",[_mainScoreDict objectForKey:[NSNumber numberWithInt:(int)[textField tag]]]);
        
        // [ratingTF_ValueAry addObject:[_mainScoreDict objectForKey:[NSNumber numberWithInt:[textField tag]]]];
        
        StuntsumFloat=0.0;
        for (int i=0; i<[[_mainScoreDict allKeys]count]; i++)
        {
            for (j=0; j<[[_mainScoreDict objectForKey:[NSNumber numberWithInt:i]] count]; j++)
            {
                StuntsumFloat+=[[[_mainScoreDict objectForKey:[NSNumber numberWithInt:i]] objectAtIndex:j] floatValue];
                
            }
            
            
        }
        
        StuntsumFloat+=[txt_scor_value.text floatValue]+[overallimpression_tf.text floatValue];
        
        
        NSLog(@"StuntsSumFloat=%.2f",StuntsumFloat);
        //totalscrore_lbl.text=[NSString stringWithFormat:@"%.1f/%d",StuntsumFloat,ratingTitle_IDAry.count*10+10];
        totalscrore_lbl.text=[NSString stringWithFormat:@"%.1f/%d",StuntsumFloat,DivScore_stunt];
        
        
        
        
    }
    else if ([value isEqualToString:[dropdownArray objectAtIndex:1]])
    {
        NSMutableArray *arrr = [NSMutableArray arrayWithArray:[_mainScoreDict_tumbling objectForKey:[NSNumber numberWithInt:(int)textField.tag]]];
        
        for(int i=0;i<[[array123Dict objectForKey:[NSNumber numberWithInt:(int)textField.tag]]count];i++)
            
        {
            
            if ( [[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)[textField tag]]]objectAtIndex:i] == textField)
            {
                [arrr removeObjectAtIndex:i];
                
                NSLog(@"%@ i=%d",[[[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)[textField tag]]]objectAtIndex:i] text],i);
                [arrr insertObject:[[[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)[textField tag]]]objectAtIndex:i] text] atIndex:i];
                
            }
        }
        [_mainScoreDict_tumbling setObject:arrr forKey:[NSNumber numberWithInt:(int)textField.tag]];
        NSLog(@"_mainScoreDict=%@",_mainScoreDict_tumbling);
        
        //calculation
        ThumbsumFloat=0.0;
        for (int i=0; i<[[_mainScoreDict_tumbling allKeys] count]; i++)
        {
            for (j=0; j<[[_mainScoreDict_tumbling objectForKey:[NSNumber numberWithInt:i]] count]; j++)
            {
                ThumbsumFloat+=[[[_mainScoreDict_tumbling objectForKey:[NSNumber numberWithInt:i]] objectAtIndex:j] floatValue];
                
            }
            
            
        }
        
        
        tumble_overallScore=txt_overAll_impr_scor_value_tc.text;
        ThumbsumFloat+=[tumble_overallScore floatValue];
        
        
        NSLog(@"ThumbsumFloat=%.2f",ThumbsumFloat);
        // lbl_totalScore_value_tc.text=[NSString stringWithFormat:@"%.1f/%d",ThumbsumFloat,ratingTitle_IDAry.count*10+5];
        lbl_totalScore_value_tc.text=[NSString stringWithFormat:@"%.1f/%d",ThumbsumFloat,DivScore_tumble];
        
    }
    else if ([value isEqualToString:[dropdownArray objectAtIndex:2]])
    {
        NSMutableArray *arrr = [NSMutableArray arrayWithArray:[_mainScoreDict_choreoghaphy objectForKey:[NSNumber numberWithInt:(int)textField.tag]]];
        for(int i=0;i<[[array123Dict objectForKey:[NSNumber numberWithInt:(int)textField.tag]]count];i++)
            
        {
            
            if ( [[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)[textField tag]]]objectAtIndex:i] == textField)
            {
                [arrr removeObjectAtIndex:i];
                
                NSLog(@"%@ i=%d",[[[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)[textField tag]]]objectAtIndex:i] text],i);
                [arrr insertObject:[[[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)[textField tag]]]objectAtIndex:i] text] atIndex:i];
                
            }
        }
        [_mainScoreDict_choreoghaphy setObject:arrr forKey:[NSNumber numberWithInt:(int)textField.tag]];
        
        NSLog(@"_mainScoreDict=%@",_mainScoreDict_choreoghaphy);
        
        
        //calculation
        ChoreosumFloat=0.0;
        for (int i=0; i<[[_mainScoreDict_choreoghaphy allKeys] count]; i++)
        {
            for (j=0; j<[[_mainScoreDict_choreoghaphy objectForKey:[NSNumber numberWithInt:i]] count]; j++)
            {
                ChoreosumFloat+=[[[_mainScoreDict_choreoghaphy objectForKey:[NSNumber numberWithInt:i]] objectAtIndex:j] floatValue];
                
            }
            
            
        }
        
        choreo_overallScore=txt_overAll_impr_scor_value_tc.text;
        ChoreosumFloat+=[choreo_overallScore floatValue];
        
        
        NSLog(@"ThumbsumFloat=%.2f",ThumbsumFloat);
        // lbl_totalScore_value_tc.text=[NSString stringWithFormat:@"%.1f/%d",ChoreosumFloat,choroTotal*10+5];
        
        //lbl_totalScore_value_tc.text=[NSString stringWithFormat:@"%.1f/%d",ChoreosumFloat,ratingTitle_IDAry.count*10+5];
        
        lbl_totalScore_value_tc.text=[NSString stringWithFormat:@"%.1f/%d",ChoreosumFloat,DivScore_choreo];
        
        
    }
       
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self.tableview1 setContentOffset:CGPointZero animated:YES];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    for(int i=0;i<[[array123Dict objectForKey:[NSNumber numberWithInt:(int)textField.tag]]count];i++)
        
    {
        if ( [[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)[textField tag]]]objectAtIndex:i] == textField)
            
        {
            //dynamic validatio for all
            NSArray *Ar_validate=[divLableDict objectForKey:[NSNumber numberWithInt:textField.tag]];
            
            //[divLableDict setObject:[[[results objectForKey:@"perforamces"] objectForKey:[sortedAry objectAtIndex:i]] objectForKey:@"max_score"] forKey:[NSNumber numberWithInt:i]];
            
            //NSLog(@"Validation array:%@",Ar_validate);
            
            NSCharacterSet *nonNumberSet= [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
            //NSLog(@"%@ Validate val:%d",[sortedAry objectAtIndex:textField.tag],[[Ar_validate objectAtIndex:i] intValue]);
            
            
            int val=[[Ar_validate objectAtIndex:i] intValue];
//            if (range.location==0)
//            {
//                if ([textField.text isEqualToString:@""])
//                {
//                    if(val < [[string stringByAppendingString:textField.text] integerValue])
//                        return NO;
//                }
//                else
//                {
////                    if ([string isEqualToString:@""])
////                    {
//                        if(val < [[string stringByAppendingString:textField.text]floatValue])
//                            return NO;
//                   // }
//                   
//                }
//                
//            }
//            if (range.location==1)
//            {
//                if ([string isEqualToString:@"0"])
//                {
//                    NSMutableString *textfieldText = [NSMutableString stringWithString:textField.text];
//                    [textfieldText insertString:string atIndex:range.location];
//                    if ([textField.text isEqualToString:@"1"])
//                    {
//                        if (val <= textfieldText.floatValue)
//                        {
//                            return YES;
//                        }
//                    }
//                        return NO;
//                }
//            
//            }
            
            
            if(string.length > 0)
            {
                if ([string rangeOfCharacterFromSet:nonNumberSet].location != NSNotFound)
                {
                    return NO;
                }
                else if ([string isEqualToString:@"."])
                {
                    if([textField.text rangeOfString:@"."].location == NSNotFound)
                    {
                        return YES;
                    }
                    return NO;
                }
                else if(range.location >= 3)
                    return NO;
                else if (range.location == 1 || range.location == 0)
                {
                    NSMutableString *textfieldText = [NSMutableString stringWithString:textField.text];
                    [textfieldText insertString:string atIndex:range.location];
                    if([textfieldText rangeOfString:@"00"].location != NSNotFound)
                        return NO;
                    return [textfieldText floatValue] <= val;
                }
                else
                    return  textField.text.integerValue < val;
                
            }
            if([string isEqualToString:@""])
            {
                if([textField.text rangeOfString:@"."].location != NSNotFound)
                {
                    if(range.location == 1 && textField.text.length>2)
                        return NO;
                    if(range.location == 0)
                    {
                        if([textField.text substringFromIndex:1].integerValue > val)
                            return NO;
                    }
                }
                return YES;
            }
            
            return NO;
            
            // dynamic validation
            
            
            
        }
        
    }
    
}

//{
//    
//    for(int i=0;i<[[array123Dict objectForKey:[NSNumber numberWithInt:(int)textField.tag]]count];i++)
//        
//    {
//        
//        if ( [[txtFiledDict objectForKey:[NSNumber numberWithInt:(int)[textField tag]]]objectAtIndex:i] == textField)
//            
//        {
//            //dynamic validatio for all
//            NSArray *Ar_validate=[divLableDict objectForKey:[NSNumber numberWithInt:textField.tag]];
//            
//            //[divLableDict setObject:[[[results objectForKey:@"perforamces"] objectForKey:[sortedAry objectAtIndex:i]] objectForKey:@"max_score"] forKey:[NSNumber numberWithInt:i]];
//            
//            //NSLog(@"Validation array:%@",Ar_validate);
//            
//            NSCharacterSet *nonNumberSet= [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
//            //NSLog(@"%@ Validate val:%d",[sortedAry objectAtIndex:textField.tag],[[Ar_validate objectAtIndex:i] intValue]);
//            int val=[[Ar_validate objectAtIndex:i] intValue];
//           
//           
//            if(range.location>=3)
//                
//            {
//                return NO;
//            
//            }
//            if([string isEqualToString:@""])
//                
//            {
//                if([textField.text containsString:@"."] && range.location == 1 && textField.text.length>2)
//                    return NO;
//                return YES;
//                
//            }
//            
////            if (![string isEqualToString:@""] && range.location==0 && [string intValue]<=val)
////            {
////                if (![textField.text isEqualToString:@""])
////                {
////                    return NO;
////                }
////                return YES;
////                
////            }
//            
//            
//            
//            
//            
//            if (range.location==0)
//                
//            {
//                
//                if ([string isEqualToString:@"."])
//                    
//                {
//                    
//                    return NO;
//                    
//                }
//                
//                else
//                    
//                {
//                    
//                    if ([string intValue]>val)
//                        
//                    {
//                        return NO;
//                        
//                    }
//                    
//                    else
//                        
//                    {
//                        
//                        if ([string isEqualToString:[NSString stringWithFormat:@"%d",val]])
//                            
//                        {
//                            
//                            return YES;
//                            
//                        }
//                        
//                        else
//                            return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
//                        
//                        
//                        
//                    }
//                    
//                    
//                    
//                }
//                
//                
//                
//            }
//            
//            else if (range.location==1)
//                
//            {
//                
//                if ([string isEqualToString:@"."])
//                    
//                {
//                    
//                    NSString *subStr=[textField.text substringWithRange:NSMakeRange(0, 1)];
//                    
//                    if ([subStr isEqualToString:[NSString stringWithFormat:@"%d",val]])
//                        
//                    {
//                        
//                        return NO;
//                        
//                    }
//                    
//                    else
//                    {
//                        
//                        //return YES;
//                        return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
//                        
//                    }
//                    
//                }
//                
//                else if (val>=10)
//                    
//                {
//                    
//                    if ([string intValue]>=val)
//                        
//                    {
//                        
//                        return NO;
//                        
//                    }
//                    
//                    else
//                        
//                    {
//                        
//                        NSString *subStr=[textField.text substringWithRange:NSMakeRange(0, 1)];
//                        
//                        if ([subStr isEqualToString:@"1"])
//                            
//                        {
//                        NSCharacterSet *nonNumberSet1 = [[NSCharacterSet characterSetWithCharactersInString:@"0"] invertedSet];
//
//                            // return YES;
//                            
//                            return ([string stringByTrimmingCharactersInSet:nonNumberSet1].length>0);
//                            
//                        }
//                        
//                        
//                            return NO;
//                            //return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
//                            
//                      
//                        
//                    }
//                    
//                    return NO;
//                    //return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
//                    
//                }
//                
//                
//                
//            }
//            
//            else if (range.location==2)
//                
//            {
//                
//                if ([string isEqualToString:@"."])
//                    
//                {
//                    
//                    return NO;
//                    
//                }
//                
//                else
//                    
//                {
//                    
//                    NSString *subStr=[textField.text substringWithRange:NSMakeRange(1, 1)];
//                    
//                    if ([subStr isEqualToString:@"."])
//                        
//                    {
//                        
//                        // return YES;
//                        
//                        return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
//                        
//                    }
//                    
//                    else
//                        
//                    {
//                        
//                        return NO;
//                        
//                    }
//                    
//                    
//                    
//                }
//                
//                
//                
//            }
//            
//            
//            if (![string isEqualToString:@""] && range.location==0)
//            {
//                if (![textField.text isEqualToString:@""])
//                {
//                    return NO;
//                }
//                return YES;
//                
//            }
//            
//            return NO;
//            
//            // dynamic validation
//            
//         
//            
//        }
//        
//    }
//    
//    
//    
//}



- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if(textView == comment_vf)
    {
        
        CGRect frame = overAll_imp_comt_View.frame;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        frame.origin.y -= 90;
        overAll_imp_comt_View.frame = frame;
        [UIView commitAnimations];
       
    }

    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView == comment_vf)
    {
        
        CGRect frame = overAll_imp_comt_View.frame;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        frame.origin.y += 90;
        overAll_imp_comt_View.frame = frame;
        [UIView commitAnimations];
      
    }

}
-(void)display_performancetype
{
    // http://joomerang.geniusport.com/cheerinfinity/webservices/getwbs_performancetype.php?json=[{"performance_id":"1"}]
    //http://54.191.2.63/spiritcentral_uat/webservices_dev/
    
    [self showBusyView];
    CheckWebService=@"PerformanceType_Display";
    NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
    [dct setObject:dropdownArray_IDSTR forKey:@"performance_id"];
    
    NSString *jsonstring1=[dct JSONRepresentation];
    ////NSLog(@"jsonstring=%@",jsonstring1);
    NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring1];
    ////NSLog(@"Post %@", post1);
    
    NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_performancetype.php",BASEURL];
    m_pWebService			= [[WebService alloc] initWebService:l_pURL];
    m_pWebService.mDelegate		= self;
    [m_pWebService  sendHTTPPost:post1];
}
-(void)dispaly_Commetns
{

    
    //http://joomerang.geniusport.com/cheerinfinity/webservices/getwbs_comments.php
    // http://joomerang.geniusport.com/cheerinfinity/webservices_dev/getwbs_comments.php?json=[{"performance_id":"1"}]
    //http://54.191.2.63/spiritcentral_uat/webservices_dev/
    
    [self showBusyView];
    CheckWebService=@"CommentsDisplay";
    NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
    Singleton *s=[Singleton getObject];
    [dct setObject:[s screenID] forKey:@"performance_id"];
    
    NSLog(@"CommentsDisplay=%@",dct);
    NSString *jsonstring1=[dct JSONRepresentation];
    ////NSLog(@"jsonstring=%@",jsonstring1);
    NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring1];
    ////NSLog(@"Post %@", post1);
    
    NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_comments.php",BASEURL];
    m_pWebService			= [[WebService alloc] initWebService:l_pURL];
    m_pWebService.mDelegate		= self;
    [m_pWebService  sendHTTPPost:post1];
    
}

-(void)CheckRatingGivenOrNot
{
    Singleton *s=[Singleton getObject];
    // new requirmenet, show the score of team of rating is already given in the same page and same format
    
    //api call to get rating is given or not
    
    //http://54.191.2.63/spiritcentral/webservices_dev/getwbs_team_summary.php?json=[{"userid":"1340","event":"148","date":"2014-11-13","team":"19","level":"6","division":"27","performance_id":"1"}]
    
    //CheckWebService=@"CommentsDisplay";
    
    NSMutableDictionary *Dict_checkRaingGiven=[[NSMutableDictionary alloc]init];
    
    [Dict_checkRaingGiven setObject:[s loginUserID] forKey:@"userid"];
    [Dict_checkRaingGiven setObject:[s event_ID1] forKey:@"event"];
    [Dict_checkRaingGiven setObject:[s team_id] forKey:@"team"];
    [Dict_checkRaingGiven setObject:[s level_id_new] forKey:@"level"];
    [Dict_checkRaingGiven setObject:[s division_id] forKey:@"division"];
    //[Dict_checkRaingGiven setObject:[s date_Name1]  forKey:@"date"];
    [Dict_checkRaingGiven setObject:@"12-17-2014"  forKey:@"date"];
    
    [Dict_checkRaingGiven setObject:@"" forKey:@"performance_id"];
    [Dict_checkRaingGiven setObject:[s screenID] forKey:@"performance_id"];
    
    NSLog(@"Display=%@",[Dict_checkRaingGiven JSONRepresentation]);
    NSString *jsonstring1=[Dict_checkRaingGiven JSONRepresentation];
    ////NSLog(@"jsonstring=%@",jsonstring1);
    NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring1];
    ////NSLog(@"Post %@", post1);
    
    NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_team_summary.php",BASEURL];
    
    //[ServiceEngine CallService].webServiceDelegate=self;
    
    //[[ServiceEngine CallService] PostService:l_pURL body:post1 context:@"checkRatingGiven" authorization:@""];

    
}


-(void)WebServiceRequestCompleted:(NSDictionary *)result context:(NSString *)context
{
    NSLog(@"%@ : %@",context,result);
    Singleton *s=[Singleton getObject];
    
    if ([[[result objectForKey:@"Team_Summary"] objectForKey:@"msg"]isEqualToString:@"Successful"])
    {
        NSArray *temp=[result objectForKey:@"keys_order"];
        
        for (int i=0; i<[temp count]; i++)
        {
            [Dict_givenRating setValue:[[[result objectForKey:@"perforamces"] objectForKey:[temp objectAtIndex:i]] objectForKey:@"score"] forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
        NSLog(@"given rating is :- %@",Dict_givenRating);
        
        if ([[s.AccessScreenArray objectAtIndex:0] intValue]==4)
        {
            btn_submit.enabled=YES;
        }
        else btn_submit.enabled=NO;
        
        [tableview1 reloadData];
        
    }
    else
    {
         btn_submit.enabled=YES;
        
        
    }
    
    
    
}


-(void)WebServiceRequestFailed:(NSString *)context service:(NSString *)api
{
    
    
}

- (void)webServiceRequestCompleted
{
    if (!m_pWebService.m_pSuccessData)
    {
        // [self hideBusyView];
      
        return;
    }
    
    else
    {
        Singleton *s=[Singleton getObject];
       
        [self hideBusyView];
        
        NSString *json_string = [[NSString alloc] initWithData:m_pWebService.m_pHTTPRsp encoding:NSUTF8StringEncoding];
        NSDictionary *results = [json_string JSONValue];
        NSLog(@"Result= %@",results);
       
        
        
        
        
        if ([CheckWebService isEqualToString:@"Performance_Display"])
        {
            NSDictionary *perf_Dict=[results objectForKey:@"perforamces"];
            NSString *resultStr=[perf_Dict objectForKey:@"message"];
            
                if([resultStr isEqualToString:@"Successful"])
                {
                
                    commentStore_indedction=[[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"", nil];
                    dropdownArray=[[NSMutableArray alloc]init ];
                      dropdownArray_ID=[[NSMutableArray alloc]init];
                    
                    NSDictionary *res_dict=[perf_Dict objectForKey:@"results"];
                    NSArray *Key_ary=[res_dict allKeys];
                    NSLog(@"===%@",[[res_dict objectForKey:@"1"]objectForKey:@"performance_name"]);
                    
                    for (int i=0; i<[Key_ary count]; i++)
                    {
                        [dropdownArray addObject:[[res_dict objectForKey:[NSString stringWithFormat:@"%d",i+1]] objectForKey:@"performance_name"]];
                        [dropdownArray_ID addObject:[[res_dict objectForKey:[NSString stringWithFormat:@"%d",i+1]] objectForKey:@"performance_id"]];
        
                     }
                    Singleton *sing=[Singleton getObject];
                    
                    
                    for (NSString *idString in [[[sing AccessScreenArray] firstObject] componentsSeparatedByString:@","])
                     {
                    for (id dict in [[perf_Dict objectForKey:@"results"] allValues])
                        
                        {
                            if([idString isEqualToString:[dict objectForKey:@"performance_id"]])
                            {
                                [dropdownArray1 addObject:[dict objectForKey:@"performance_name"]];
                                [dropdownArray_ID1 addObject:[dict objectForKey:@"performance_id"]];
                            }
                        }
                    }
                    
                    
                    
                    
                    if (dropdownArray1.count==1)
                    {

                        [btn_Selected_cat setUserInteractionEnabled:NO];
                        
                        img_dropdown.image=[UIImage imageNamed:@"submit-button@2x.png"];
                        
                        img_dropdown.backgroundColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
                    
                    }
                    
                    
                    if ([[[[sing screenID]componentsSeparatedByString:@","]objectAtIndex:0]isEqualToString:@"1"])
                    {
                        if(b6==YES)
                        {
                            
                            b1=YES;
                            b6=NO;
                        }
                        
                        else
                        {
                            //dont do anything
                        }
                        
                        catLable.text=[dropdownArray objectAtIndex:0];
                        tf_dropdown.text=[dropdownArray objectAtIndex:0];
                        
                        value=[dropdownArray objectAtIndex:0];
                        doneValue=[dropdownArray objectAtIndex:0];
                        
                                              
                        [view_Tumb_Choreo setHidden:YES];
                        [deductionView setHidden:YES];
                        [stuntsView setHidden:NO];
                        [stuntsView setFrame:CGRectMake(724, 180, 280, 135)];
                        [[self view]addSubview:stuntsView];
                        
                        //////////
                        
                        //totalscrore_lbl.text=[NSString stringWithFormat:@"%.1f/%d",StuntsumFloat,stuntTotal*10+10];
                        
                        totalscrore_lbl.text=[NSString stringWithFormat:@"%.1f/%d",StuntsumFloat,DivScore_stunt];
                        
                        
                        
                        
                        
                    }
                    
                    if ([[[[sing screenID]componentsSeparatedByString:@","]objectAtIndex:0]isEqualToString:@"2"])
                    {
                        
                        
                        if(b4==YES)
                        {
                            
                            b2=YES;
                            b4=NO;
                        }
                        else
                        {
                            //dont do anything
                        }
                      
                        
                        catLable.text=[dropdownArray objectAtIndex:1];
                        tf_dropdown.text=[dropdownArray objectAtIndex:1];
                        
                        value=[dropdownArray objectAtIndex:1];
                        doneValue=[dropdownArray objectAtIndex:1];
                        
                        /////////
                        [stuntsView setHidden:YES];
                        [deductionView setHidden:YES];
                        [view_Tumb_Choreo setHidden:NO];
                        [view_Tumb_Choreo setFrame:CGRectMake(724, 187, 280, 135)];
                        [[self view]addSubview:view_Tumb_Choreo];
                        /////////
                        
                        //lbl_totalScore_value_tc.text=[NSString stringWithFormat:@"%.1f/%d",ThumbsumFloat,thumbTotal*10+5];
                        
                        lbl_totalScore_value_tc.text=[NSString stringWithFormat:@"%.1f/%d",ThumbsumFloat,DivScore_tumble];

                    
                        txt_overAll_impr_scor_value_tc.text=tumble_overallScore;
                    
                    }
                    if ([[[[sing screenID]componentsSeparatedByString:@","]objectAtIndex:0]isEqualToString:@"3"])
                    {
                        
                        
                        if(b5==YES)
                        {
                            b3=YES;
                            b5=NO;
                            
                        }
                        else
                        {
                            
                        }
                        
                        
                        catLable.text=[dropdownArray objectAtIndex:2];
                        tf_dropdown.text=[dropdownArray objectAtIndex:2];
                        
                        value=[dropdownArray objectAtIndex:2];
                        doneValue=[dropdownArray objectAtIndex:2];
                        
                        /////////
                        [stuntsView setHidden:YES];
                        [deductionView setHidden:YES];
                        [view_Tumb_Choreo setHidden:NO];
                        [view_Tumb_Choreo setFrame:CGRectMake(724, 187, 280, 135)];
                        [[self view]addSubview:view_Tumb_Choreo];
                        
                        /////////
                        
                        //lbl_totalScore_value_tc.text=[NSString stringWithFormat:@"%.1f/%d",ThumbsumFloat,thumbTotal*10+5];
                        
                        lbl_totalScore_value_tc.text=[NSString stringWithFormat:@"%.1f/%d",ChoreosumFloat,DivScore_choreo];
                        
                        txt_overAll_impr_scor_value_tc.text=tumble_overallScore;
                    }
                    
                    if ([[[[sing screenID]componentsSeparatedByString:@","]objectAtIndex:0]isEqualToString:@"4"])                    {
                        catLable.text=[dropdownArray objectAtIndex:3];
                        tf_dropdown.text=[dropdownArray objectAtIndex:3];
                        
                        value=[dropdownArray objectAtIndex:3];
                        doneValue=[dropdownArray objectAtIndex:3];
                        
                        /////////////
                        
                        [stuntsView setHidden:YES];
                        [view_Tumb_Choreo setHidden:YES];
                        [deductionView setHidden:NO];
                        [deductionView setFrame:CGRectMake(723, 187, 280, 135)];
                        [[self view]addSubview:deductionView];
                        
                        /////////
                        //totalscrore_lbl.text=@"0.0";
                       
                        Finalsumfloat=Dedutionsumfloat+StuntsumFloat+ChoreosumFloat+ThumbsumFloat;
                    }
                    
                    //[self dispaly_Commetns];
                    
                    [self display_performancetype];
                    
                }
        }
        
        else if ([CheckWebService isEqualToString:@"PerformanceType_Display"])
        {
            Singleton *s=[Singleton getObject];
            
           //deduction webservice
            if([value isEqualToString:[dropdownArray objectAtIndex:3]])
           {
               if(kundan_Check_ded==0)
               {
               
               dedDict_IndexPath_Total_Lbl=[[NSMutableDictionary alloc]init];
               dedDict_IndexPath_Total_Lbl_Save=[[NSMutableDictionary alloc]init];
               //for timer
               dedDict_IndexPath_Total_Lbl_timeStamp=[[NSMutableDictionary alloc]init];
               dedDict_IndexPath_Total_Lbl_timeStamp_Save=[[NSMutableDictionary alloc]init];
               ar_ded_heading=[[NSMutableArray alloc]init];
               ar_Ded_Label=[[NSMutableArray alloc]init];
               array_cellLbl_tumbling=[[NSMutableArray alloc]init];
               deddict=[results objectForKey:@"perforamces"];
               
               
               [deddict enumerateKeysAndObjectsUsingBlock:^(id obj,id key,BOOL *flag)
               {
                   [ar_ded_heading addObject:obj];
                   NSLog(@"%@",ar_ded_heading);
                  
                   
                   
               }];
               
               ar_ded_heading=[results objectForKey:@"keys_order"];
               for(int i=0;i<[ar_ded_heading count];i++)
               {
                   [total_Sum setObject:[[NSMutableArray alloc]initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil] forKey:[NSNumber numberWithInt:i]];
            [array_cellLbl_tumbling addObject:[deddict objectForKey:[ar_ded_heading objectAtIndex:i]]];
                [[array_cellLbl_tumbling objectAtIndex:i] removeObjectForKey:@"max_score"];
                   
                   NSDictionary *dict=  [array_cellLbl_tumbling objectAtIndex:i];
                   
                   
                   NSLog(@"%@",dict.allKeys);
                   
                   main_Dict=[[NSMutableDictionary alloc]init];
                   
                   main_Dict_Save=[[NSMutableDictionary alloc]init];
                   
                   main_Dict_TimeStamp_Save=[[NSMutableDictionary alloc]init];
                   
                   for(int row=0;row<[[dict allKeys]count];row++)
                   {
                       [main_Dict_Save setObject:[[NSMutableArray alloc]initWithObjects:@"0.0",@"0.0",@"0.0", nil] forKey:[NSNumber numberWithInt:row]];
                       
                       
                       //for timer
                       [main_Dict_TimeStamp_Save setObject:[[NSMutableArray alloc]initWithObjects:@"00:00:00",nil] forKey:[NSNumber numberWithInt:row]];
                       
                       
                       
                       for(int k=0;k<3;k++)
                       {
                           [main_Dict setObject:[[NSMutableArray alloc]initWithObjects:@"0.0",@"0.0",@"0.0", nil] forKey:[NSNumber numberWithInt:row]];
                           
                           
                       }
                       
                   }
                   
                   [main_Dict_final setObject:main_Dict forKey:[NSNumber numberWithInt:i]];
                   [dedDict_IndexPath_Total_Lbl_Save setObject:main_Dict_Save forKey:[NSNumber numberWithInt:i]];
                   
                   //for timer
                   
                   [dedDict_IndexPath_Total_Lbl_timeStamp_Save setObject:main_Dict_TimeStamp_Save forKey:[NSNumber numberWithInt:i]];
               }
               }
               
               [tableview1 setContentOffset:CGPointZero];
               [tableview1 reloadData];
               [self teamInfo_Display];
           
           }
            else
            {
                
                //deduction is done before
                ar_Total_lab=[[NSMutableArray alloc]init];
                ar_Total_txt=[[NSMutableArray alloc]init];
                ar_total_lab_data=[[NSMutableArray alloc]init];
                ar_total_div_data=[[NSMutableArray alloc]init];
                
                
                indexDict=[[NSMutableDictionary alloc]init];
                array123Dict=[[NSMutableDictionary alloc]init];
                txtFiledDict=[[NSMutableDictionary alloc]init];
                // divLableDict=[[NSMutableDictionary alloc]init];
                
                heightForCell=[[NSMutableDictionary alloc]init];
                
                //  per_resultAry=[[NSMutableArray alloc]init];
                ratingTitle_IDAry=[[NSMutableArray alloc]init];
                ar_total_lab_data=[[NSMutableArray alloc]init];
                
                //NSDictionary *perfType_Dict=[results objectForKey:@"perforamces"];
                // NSString *Check_STR=[perfType_Dict objectForKey:@"message"];
                // NSDictionary *perfType_Dict_result=[perfType_Dict objectForKey:@"results"];
                perfType_Dict_result=[results objectForKey:@"perforamces"];
                
                NSArray *arr_keys=[perfType_Dict_result allKeys];
                
                
                
                sortedAry=[arr_keys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
                sortedAry=[results objectForKey:@"keys_order"];
                NSLog(@"sortedAry==%@",sortedAry);
                
                //here to
                
                [per_resultAry removeAllObjects];
                per_resultAry=[[NSMutableArray alloc]init];
                per_resultAry=[arr_keys mutableCopy];
                for (int i1=0; i1<arr_keys.count; i1++)
                {
                    for (int j1=0; j1<arr_keys.count; j1++)
                    {
                        NSString *s1=[NSString stringWithFormat:@"%@",[per_resultAry objectAtIndex:i1]];
                        NSString *s2=[NSString stringWithFormat:@"%@",[per_resultAry objectAtIndex:j1]];
                        
                        int l=[s1 intValue];
                        int k=[s2 intValue];
                        //                        NSLog(@"%d %d",l,k);
                        if(l<k)
                        {
                            NSString *t=[per_resultAry objectAtIndex:i1];
                            [per_resultAry replaceObjectAtIndex:i1 withObject:[per_resultAry objectAtIndex:j1]];
                            [per_resultAry replaceObjectAtIndex:j1 withObject:t];
                        }
                        
                    }
                }
                
                
                
                /////////
                
                
                //based on number of cell
                for(int i=0;i<[sortedAry count];i++)
                {
                    [ar_Total_lab insertObject:[[NSMutableArray alloc]init] atIndex:i];
                    [ar_Total_txt insertObject:[[NSMutableArray alloc]init] atIndex:i];
                    [ar_total_lab_data insertObject:[[NSMutableArray alloc]init] atIndex:i];
                    [ar_total_div_data insertObject:[[NSMutableArray alloc]init] atIndex:i];
                    
                }
                
                //i means stunts/pyramid/tosses/otherr
                for(int i=0;i<[sortedAry count];i++)
                {
                    
                    count=0;
                    NSMutableDictionary *ddd=[[perfType_Dict_result objectForKey:[sortedAry objectAtIndex:i]] mutableCopy];
                    
                    // NSDictionary *d=[per_resultAry objectAtIndex:i];
                    
                    
                    [ddd removeObjectForKey:@"max_score"];
                    
                    NSArray *arrrrr=[ddd allKeys];
                    NSLog(@"ddd==%@",[ddd allKeys]);
                    NSLog(@"ddd==%ld",(unsigned long)[ddd allKeys].count);
                    
                    
                    [titles_resultAry removeAllObjects];
                    titles_resultAry=[[NSMutableArray alloc]init];
                    titles_resultAry=[arrrrr mutableCopy];
                    for (int i1=0; i1<arrrrr.count; i1++)
                    {
                        for (int j1=0; j1<arrrrr.count; j1++)
                        {
                            NSString *s1=[NSString stringWithFormat:@"%@",[titles_resultAry objectAtIndex:i1]];
                            NSString *s2=[NSString stringWithFormat:@"%@",[titles_resultAry objectAtIndex:j1]];
                            
                            int l=[s1 intValue];
                            int k=[s2 intValue];
                            //                        NSLog(@"%d %d",l,k);
                            if(l<k)
                            {
                                NSString *t=[titles_resultAry objectAtIndex:i1];
                                [titles_resultAry replaceObjectAtIndex:i1 withObject:[titles_resultAry objectAtIndex:j1]];
                                [titles_resultAry replaceObjectAtIndex:j1 withObject:t];
                                
                                
                            }
                            
                        }
                    }
                    
                    for (int p=0; p<titles_resultAry.count; p++)
                    {
                        
                        
                        NSLog(@"dddd=%@",[ddd objectForKey:[NSString stringWithFormat:@"%@",[titles_resultAry objectAtIndex:p]]]);
                        [[ar_total_lab_data objectAtIndex:i] addObject:[ddd objectForKey:[NSString stringWithFormat:@"%@",[titles_resultAry objectAtIndex:p]]]];
                        
                        NSString *strrrr=[titles_resultAry objectAtIndex:p];
                        [ratingTitle_IDAry addObject:strrrr];
                        count++;
                        
                        
                        
                    }
                    [heightForCell setObject:[NSString stringWithFormat:@"%d",count] forKey:[NSNumber numberWithInt:i]];
                }
                
                NSLog(@"ratingTitle_IDAry==%ld",(unsigned long)ratingTitle_IDAry.count);
                NSLog(@"ar_total_lab_data==%@",ar_total_lab_data);
                
                
                
                //based on number of cell
                for(int i=0;i<[per_resultAry count];i++)
                {
                    
                    [indexDict setObject:[ar_Total_lab objectAtIndex:i] forKey:[NSNumber numberWithInt:i ]];
                    [array123Dict setObject:[ar_total_lab_data objectAtIndex:i] forKey:[NSNumber numberWithInt:i]];
                    [txtFiledDict setObject:[ar_Total_txt objectAtIndex:i] forKey:[NSNumber numberWithInt:i]];
                    [divLableDict setObject:[[[results objectForKey:@"perforamces"] objectForKey:[sortedAry objectAtIndex:i]] objectForKey:@"max_score"] forKey:[NSNumber numberWithInt:i]];
                    
                    
                    
                }
                
                
                

                if(b1)
                {
                    if([value isEqualToString:[dropdownArray objectAtIndex:0]])
                    {
                        [s setRatingTile_idArray_build:ratingTitle_IDAry];
                        DictCheckBtn_stunt=[[NSMutableDictionary alloc]init];
                        DictCheckLbl_stunt=[[NSMutableDictionary alloc]init];
                        DivScore_stunt=0;
                        
                        for(int i=0;i<[sortedAry count];i++)
                        {
                            
                            //tick btn related
                            [containsArray insertObject:[[NSMutableArray alloc]initWithObjects:@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png", nil] atIndex:i];
                            
                            
                            [diction setObject:[[NSMutableArray alloc]initWithObjects:@"", nil] forKey:[NSNumber numberWithInt:i]];
                            
                            [DictCheckBtn_stunt setObject:[[NSMutableArray alloc]init] forKey:[NSNumber numberWithInt:i]];
                            [DictCheckLbl_stunt setObject:[[NSMutableArray alloc]init] forKey:[NSNumber numberWithInt:i]];
                            
                            //text related
                            [_mainScoreDict setObject:[NSArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",nil] forKey:[NSNumber numberWithInt:i]];
                            for (int k=0; k<[[divLableDict objectForKey:[NSNumber numberWithInt:i]] count]; k++)
                            {
                                
                                DivScore_stunt+=[[[divLableDict objectForKey:[NSNumber numberWithInt:i]] objectAtIndex:k] intValue];
                            }
                            
                        }
                        
                        b1=NO;
                        totalscrore_lbl.text=[NSString stringWithFormat:@"%.1f/%d",StuntsumFloat,DivScore_stunt];
                        
                        
                        
                    }
                    
                    
                    // check rating given or not
                    [self CheckRatingGivenOrNot];
                }
                else if(b2)
                {
                    //for tumble
                    if([value isEqualToString:[dropdownArray objectAtIndex:1]])
                    {
                        [s setRatingTile_idArray_tum:ratingTitle_IDAry];

                        DictCheckBtn_tumble=[[NSMutableDictionary alloc]init];
                        DictCheckLbl_tumble=[[NSMutableDictionary alloc]init];
                        DivScore_tumble=0;
                        
                        for(int i=0;i<[sortedAry count];i++)
                        {
                            
                            //tick btn related
                            [containsArrayTumble insertObject:[[NSMutableArray alloc]initWithObjects:@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png", @"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",nil] atIndex:i];
                            
                            
                            [dictionTumble setObject:[[NSMutableArray alloc]initWithObjects:@"", nil] forKey:[NSNumber numberWithInt:i]];
                            //text related
                            [_mainScoreDict_tumbling setObject:[NSArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",nil] forKey:[NSNumber numberWithInt:i]];
                            
                            [DictCheckBtn_tumble setObject:[[NSMutableArray alloc]init] forKey:[NSNumber numberWithInt:i]];
                            [DictCheckLbl_tumble setObject:[[NSMutableArray alloc]init] forKey:[NSNumber numberWithInt:i]];
                            
                            for (int k=0; k<[[divLableDict objectForKey:[NSNumber numberWithInt:i]] count]; k++)
                            {
                                
                                DivScore_tumble+=[[[divLableDict objectForKey:[NSNumber numberWithInt:i]] objectAtIndex:k] intValue];
                            }
                            
                        }
                        
                        b2=NO;
                        lbl_totalScore_value_tc.text=[NSString stringWithFormat:@"%.1f/%d",ThumbsumFloat,DivScore_tumble];
                    }
                    
                   //check rating given or not
                    [self CheckRatingGivenOrNot];
                }
                
                else if(b3)
                {//for choreo
                    if([value isEqualToString:[dropdownArray objectAtIndex:2]])
                    {
                        [s setRatingTile_idArray_cho:ratingTitle_IDAry];

                        DictCheckBtn_choreo=[[NSMutableDictionary alloc]init];
                        DictCheckLbl_choreo=[[NSMutableDictionary alloc]init];
                        DivScore_choreo=0;
                        
                        for(int i=0;i<[sortedAry count];i++)
                        {
                            
                            //tick btn related
                            [containsArrayChoreo insertObject:[[NSMutableArray alloc]initWithObjects:@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png",@"Without-Tick_iph.png", nil] atIndex:i];
                            
                            [dictionChoreo setObject:[[NSMutableArray alloc]initWithObjects:@"", nil] forKey:[NSNumber numberWithInt:i]];
                            //text related
                            [_mainScoreDict_choreoghaphy setObject:[NSArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil] forKey:[NSNumber numberWithInt:i]];
                            
                            [DictCheckBtn_choreo setObject:[[NSMutableArray alloc]init] forKey:[NSNumber numberWithInt:i]];
                            [DictCheckLbl_choreo setObject:[[NSMutableArray alloc]init] forKey:[NSNumber numberWithInt:i]];
                            
                            for (int k=0; k<[[divLableDict objectForKey:[NSNumber numberWithInt:i]] count]; k++)
                            {
                                
                                DivScore_choreo+=[[[divLableDict objectForKey:[NSNumber numberWithInt:i]] objectAtIndex:k] intValue];
                            }
                            
                            
                            
                            
                            
                        }
                        
                                             
                    }
                    
                    
                    b3=NO;
                    lbl_totalScore_value_tc.text=[NSString stringWithFormat:@"%.1f/%d",ChoreosumFloat,DivScore_choreo];
                    
                    //check rating given or not
                    [self CheckRatingGivenOrNot];
                    
                }
               
                
                               
                [self dispaly_Commetns];
                
                
               
                
            }
            
            
            
            
            
        }
        else if ([CheckWebService isEqualToString:@"Team_Display"])
        {
    
            NSDictionary *team_Dict=[results objectForKey:@"teams"];
            NSString *resultStr=[team_Dict objectForKey:@"message"];
            
                if([resultStr isEqualToString:@"Successful"])
                {
                    teamArray=[[NSMutableArray alloc]init];
                    teamIDArray=[[NSMutableArray alloc]init];
                    
                    NSDictionary *res_dict=[team_Dict objectForKey:@"results"];
                    NSArray *Key_ary=[res_dict allKeys];
                    NSLog(@"===%@",[[res_dict objectForKey:@"1"]objectForKey:@"team_name"]);
                    
                    for (int i=0; i<[Key_ary count]; i++) {
                        
                        [teamArray addObject:[[res_dict objectForKey:[NSString stringWithFormat:@"%d",i+1]] objectForKey:@"team_name"]];
                        [teamIDArray addObject:[[res_dict objectForKey:[NSString stringWithFormat:@"%d",i+1]] objectForKey:@"team_id"]];
                        
                    }
                    
                    
                    
                    [pickview setShowsSelectionIndicator:YES];
                    
                    pickview.dataSource=self;
                    pickview.delegate=self;
                    
                    self.popView = [[UIViewController alloc]init];
                    [self.popView.view addSubview:picker_uiview];
                    self.aPopover = [[UIPopoverController alloc]initWithContentViewController:self.popView];
                    self.aPopover.delegate=self;
                    self.aPopover.popoverContentSize=picker_uiview.frame.size;
                    //  [self.aPopover presentPopoverFromRect:btn_Team.frame inView:self.view
                    //permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
                }
                else
                {
                    UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Un Successful" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                    [alert1 show];
                    
                }
        
        }
        else if ([CheckWebService isEqualToString:@"TeamInfo_Display"])
        {
            NSDictionary *team_Dict=[results objectForKey:@"teaminfo"];
            NSString *resultStr=[team_Dict objectForKey:@"message"];
            
            if([resultStr isEqualToString:@"Successful"])
            {
                NSDictionary *res_dict=[team_Dict objectForKey:@"results"];
                
                NSLog(@"teamlogo==%@",[res_dict objectForKey:@"teamlogo"]);
                
                
                NSString *profilePic=[res_dict objectForKey:@"teamlogo"];
                
                NSString *citys=[res_dict objectForKey:@"city"];
                // NSString *citys=[res_dict objectForKey:@"city"];
                NSString *countrys=[res_dict objectForKey:@"country"];
                
                NSString *strs=[NSString stringWithFormat:@"%@,%@",citys,countrys];
                // NSString *img=[res_dict objectForKey:@"teamlogo"];
                
                judgepicipad_Bg.hidden=NO;
                //[NSString stringWithFormat:@"http://joomerang.geniusport.com/cheerinfinity/webservices/profilepics/%@",[res_dict objectForKey:profilePic] ];
                
               // NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://joomerang.geniusport.com/cheerinfinity/webservices/profilepics/%@",profilePic]];
                //NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                
                //judgepicipad.image=[UIImage imageWithData:imageData];
                
                lbl_main_cheer_address.text=strs;
               lbl_main_cheer_name.text=[res_dict objectForKey:@"teamname"];
                teamID=[res_dict objectForKey:@""];
            
                NSLog(@"%@",lbl_main_cheer_name.text);
                
                if(mybool)
                {
                
                    
                    
                    mybool=NO;
                }
                else
                {
                
                }
                Singleton *s=[Singleton getObject];
               [tf_level setText:[s level_Name]];
                [tf_gym setText:[s gym_Name]];
                /////////////
                
                int index1=(int)[[s ar_Team_ids]indexOfObject:[s team_id]];
                
                if([[s ar_Team_ids]count]==1 && index1==0)
                    
                {
                }
                
                else if([[s ar_Team_ids]count]>1 && index1==0)
                {
                    
                    
                }
                
                else if([[s ar_Team_ids]count]>1 && index1==[[s ar_Team_ids]count]-1)
                    
                {
                    
                    
                    
                }
              
            }
            
        }
        
        else if ([CheckWebService isEqualToString:@"CommentsDisplay"])
        {
            NSDictionary *coment_Dict=[results objectForKey:@"comments"];
            NSString *resultStr=[coment_Dict objectForKey:@"message"];
            
            if([resultStr isEqualToString:@"Successful"])
            {
                res_dict_comments=[coment_Dict objectForKey:@"results"];
                
               /* NSArray *ar=[res_dict_comments allKeys];
                for(int i=0;i<[ar count];i++)
               {
                
                //NSLog(@"%@",[res_dict objectForKey:[NSString stringWithFormat:@"%d",i]]);
              
                   NSString *Fullstr=[res_dict_comments objectForKey:[ar objectAtIndex:i]];
                  Ary_getcomments=[Fullstr componentsSeparatedByString:@"|"];

               }*/
                
                
               [tableview1 setContentOffset:CGPointZero];
               [tableview1 reloadData];
                
               
            }
              [self teamInfo_Display];
            
        }
        else if ([CheckWebService isEqualToString:@"SubmitAllValues"])
        {
            NSDictionary *savePerformance_Dict=[results objectForKey:@"saveperformance"];
            NSString *resultStr=[savePerformance_Dict objectForKey:@"message"];
            
            if([resultStr isEqualToString:@"Successfully Saved"])
            {
                EmptyCountval=0;
                
                Singleton *s=[Singleton getObject];
                
                // screen access
                
                if(dropdownArray1.count==4) //(s.AccessScreenArray.count>1)
                {
                    
                    savePerformance_Alert=[[UIAlertView alloc]initWithTitle:@"Data Saved Successfully" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"NextTeam",@"NextScreen", nil];
                   
                    
                    
                }
                else
                {
                    savePerformance_Alert=[[UIAlertView alloc]initWithTitle:@"Data Saved Successfully" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"NextTeam",nil, nil];
                    
                    
                }
                
                 [savePerformance_Alert show];
            }
            else
            {
               UIAlertView *savePerformance_AlertNot=[[UIAlertView alloc]initWithTitle:@"" message:@"Not Saved" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [savePerformance_AlertNot show];
            }
            
        }
        else if ([CheckWebService isEqualToString:@"SaveComments"])
        {
            NSDictionary *saveComment_Dict=[results objectForKey:@"savecomment"];
            NSString *resultStr=[saveComment_Dict objectForKey:@"message"];
            
            if([resultStr isEqualToString:@"Successfully Saved"])
            {
                saveComment_Alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Comment Submitted" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [saveComment_Alert show];
                
            }
            else
            {
                UIAlertView *saveComment_AlertNot=[[UIAlertView alloc]initWithTitle:@"" message:@"Comment Not Submitted" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [saveComment_AlertNot show];
            }
            
        }
        
        else if ([CheckWebService isEqualToString:@"SubmitAllValues_FromDeduction"])
        {
            NSDictionary *savePerformance_Dict=[results objectForKey:@"saveperformance"];
            NSString *resultStr=[savePerformance_Dict objectForKey:@"message"];
            
            if([resultStr isEqualToString:@"Successfully Saved"])
            {
                
                Singleton *s=[Singleton getObject];
                if ([[s.AccessScreenArray1 objectAtIndex:0]isEqualToString:@"0"])
                {
                    savePerformance_Alert=[[UIAlertView alloc]initWithTitle:@"Data Saved Successfully" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"NextTeam", nil];
                    [savePerformance_Alert show];
                }
                
                else
                {
                   savePerformance_Alert=[[UIAlertView alloc]initWithTitle:@"Data Saved Successfully" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"NextTeam",@"Summary", nil];
                  [savePerformance_Alert show];
                }
                
               /*UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"Data Saved Successfully" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [alt show];*/
                
            }
            else
            {
                UIAlertView *savePerformance_AlertNot=[[UIAlertView alloc]initWithTitle:@"" message:@"Not Saved" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [savePerformance_AlertNot show];
            }
            
        }
        else if ([CheckWebService isEqualToString:@"TeamSummary"])
        {
            
            if([results objectForKey:@"Event_Summary"])
            {
                if([[[results objectForKey:@"Event_Summary"]objectForKey:@"msg"]isEqualToString:@"Successful"])
                {
                  
                    NSDictionary *dict_Summary=[[[[[results objectForKey:@"Event_Summary"]objectForKey:@"summary"]objectAtIndex:0] objectAtIndex:0]objectForKey:@"categories"];
                    
                if(([[[dict_Summary objectForKey:@"TUMBLING/JUMPS"] objectForKey:@"total"] isEqualToString:@"0"]
                       ||[[[dict_Summary objectForKey:@"TUMBLING/JUMPS"] objectForKey:@"total"]isEqual:nil]) &&([[[dict_Summary objectForKey:@"CHOREOGRAPHY"] objectForKey:@"total"] isEqualToString:@"0"]
                       ||[[[dict_Summary objectForKey:@"CHOREOGRAPHY"] objectForKey:@"total"]isEqual:nil])
                       && ([[[dict_Summary objectForKey:@"BUILDING SKILLS"] objectForKey:@"total"] isEqualToString:@"0"]
                           ||[[[dict_Summary objectForKey:@"DEDUCTION/CUMULATIVE"] objectForKey:@"total"]isEqual:nil])&&([[[dict_Summary objectForKey:@"DEDUCTION/CUMULATIVE"] objectForKey:@"total"] isEqualToString:@"0"]
                                                                                                                    ||[[[dict_Summary objectForKey:@"DEDUCTION/CUMULATIVE"] objectForKey:@"total"]isEqual:nil]))
                    {
                    
                        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"No scoring has been completed" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                    else
                    {
//                        AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
//                        [delegate CallSlide1];
//                        [self presentViewController:delegate.viewController_leftPane animated:YES completion:NULL];
                        
            if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
            {
                        TeamSummaryViewController *controller=[[TeamSummaryViewController alloc]initWithNibName:@"TeamSummaryViewController" bundle:nil];
                        
                       // [self presentViewController:controller animated:YES completion:nil];
                        [self.navigationController pushViewController:controller animated:YES];
                }
                else
                {
                    TeamSummaryViewController *controller=[[TeamSummaryViewController alloc]initWithNibName:@"TeamSummaryViewController_ios6" bundle:nil];
                    
                    // [self presentViewController:controller animated:YES completion:nil];
                    [self.navigationController pushViewController:controller animated:YES];
                }
                
            }
                    
                }
                else
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"No scoring has been completed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    NSLog(@"msg unsuccesfull from team summary");
                    
                }

            }
            
        }
        
        
        else if ([CheckWebService isEqualToString:@"Ranking Event"])
        {
            if ([[results objectForKey:@"msg"]isEqualToString:@"Successful"])
            {
                if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
                {
                    RankingEventViewController *rank=[[RankingEventViewController alloc]initWithNibName:@"RankingEventViewController" bundle:nil];
                    [rank setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
                    [self presentViewController:rank animated:YES completion:nil];
                }
                else
                {
                    RankingEventViewController *rank=[[RankingEventViewController alloc]initWithNibName:@"RankingEventViewController_ios6" bundle:nil];
                    [rank setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
                    [self presentViewController:rank animated:YES completion:nil];
                }
            }
            else
            {
             UIAlertView   *rankingAlert=[[UIAlertView alloc]initWithTitle:@"None team has been approved" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [rankingAlert show];
                
            }
            
        }

    }

}
-(void)webServiceRequestFail :(NSError *)error
{
    [self hideBusyView];
    
   //  NoInternetConnection=YES;
    
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status == NotReachable)
    {
    UIAlertView *alert2=[[UIAlertView alloc] initWithTitle:@"" message:@"Please check your Wi-Fi or 3G connection and try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert2 show];
    }
    
}

-(IBAction)submitBtn_Values:(id)sender
{
    
    [self.view endEditing:YES];
     NSLog(@"stunt_OverallCommentSTR1===%@",stunt_OverallCommentSTR1);
    
    Singleton *s=[Singleton getObject];
    teamID=[s team_id];
    NSLog(@"myid==%@",teamID);
    if ([teamID isEqualToString:@""]||teamID==nil)
    {
        
        UIAlertView *ve=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Select the Team" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [ve show];
    }
    else
        
   {
        
        Singleton *s_Obj=[Singleton getObject];
        NSLog(@"LoginUserID=%@",[s_Obj loginUserID]);
        
   if( [value isEqualToString:[dropdownArray objectAtIndex:0]])
    {
    // http://joomerang.geniusport.com/cheerinfinity/webservices/getwbs_saveperformance.php?json=[{"commented_by":"1","team_id":"1","perf_id":"1","overall_impression":"5","overall_comment":"good work","team_perf_skill":"3.5","scores":{"1":{"title_id":"1","score":"8"},"2":{"title_id":"2","score":"6.5"},"3":{"title_id":"3","score":"2.5"},"4":{"title_id":"4","score":""},"5":{"title_id":"5","score":"8"},"6":{"title_id":"6","score":""},"7":{"title_id":"7","score":"2.5"},"8":{"title_id":"8","score":""}},"comments":{"1":{"title":"STUNTS","comments":{"1":"Motions/Dance Variety","2":"FOrmations/Use of Floor","3":"Good Work"}},"2":{"title":"PYRAMIDS","comments":{"1":"Motions/Dance Variety","2":"FOrmations/Use of Floor","3":"Good Work"}},"3":{"title":"TOSESS","comments":{"1":"Motions/Dance Variety","2":"FOrmations/Use of Floor","3":"Good Work"}}}}]
    
        
        //http://54.191.2.63/spiritcentral_uat/webservices_dev/
        
   // http://joomerang.geniusport.com/cheerinfinity/webservices/getwbs_saveperformance.php?json=[{"commented_by":"1","team_id":"1","perf_id":"1","overall_impression":"5","overall_comment":"good%20work","team_perf_skill":"3.5","scores":{"1":{"title_id":"1","score":"8"},"2":{"title_id":"2","score":"6.5"},"3":{"title_id":"3","score":"2.5"},"4":{"title_id":"4","score":""},"5":{"title_id":"5","score":"8"},"6":{"title_id":"6","score":""},"7":{"title_id":"7","score":"2.5"},"8":{"title_id":"8","score":""}},"comments":{"1":{"title":"STUNTS","comments":["Motions/Dance%20Variety","Formations/Use%20of%20Floor","Good%20Work"]},"2":{"title":"PYRAMIDS","comments":["Motions/Dance%20Variety","Formations/Use%20of%20Floor","Good%20Work"]},"3":{"title":"TOSESS","comments":["Motions/Dance%20Variety","Formations/Use%20of%20Floor","Good%20Work"]}}}]

    
        
    
    /////////////////
    [self showBusyView];
    CheckWebService=@"SubmitAllValues";
    Singleton *st=[Singleton getObject];
        
        
        
    NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
    [dct setObject:[st event_ID] forKey:@"event_id"];
            
//            [dct setObject:[tf_gym text] forKey:@"division"];
//            [dct setObject:[tf_level text] forKey:@"level"];
        
        [dct setObject:[st division_id] forKey:@"division"];
        [dct setObject:[st level_id_new] forKey:@"level"];
        
            
    [dct setObject:[s_Obj loginUserID] forKey:@"commented_by"];
    if ([teamID isEqualToString:@""]||teamID==nil) {
        [dct setObject:@"" forKey:@"team_id"];
    }
    else
    {
        [dct setObject:teamID forKey:@"team_id"];
    }
    
    [dct setObject:@"1" forKey:@"perf_id"];
        if ([overallimpression_tf.text isEqualToString:@""]||overallimpression_tf.text==nil) {
            [dct setObject:@"" forKey:@"overall_impression"];
        }
        else
        {
            [dct setObject:overallimpression_tf.text forKey:@"overall_impression"];
        }
        if ([stunt_OverallCommentSTR1 isEqualToString:@""]||stunt_OverallCommentSTR1==nil) {
            [dct setObject:@"" forKey:@"overall_comment"];
        }
        else
        {
            NSString *jsonstring_encoding1 = [NSString stringWithFormat:@"%@",
                                             [stunt_OverallCommentSTR1 urlEncodeUsingEncoding:NSUTF8StringEncoding]];
            [dct setObject:jsonstring_encoding1 forKey:@"overall_comment"];
        }
   
        if ([txt_scor_value.text isEqualToString:@""]||txt_scor_value.text==nil)
        {
            [dct setObject:@"0" forKey:@"team_perf_skill"];
        }
        else
        {
             [dct setObject:txt_scor_value.text forKey:@"team_perf_skill"];
        }
            
      [dct setObject:[totalscrore_lbl text] forKey:@"total_score"];

    
    /////////
    NSArray *arr_keys=[perfType_Dict_result allKeys];
    
    //sortedAry=[arr_keys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [per_resultAry removeAllObjects];
    per_resultAry=[[NSMutableArray alloc]init];
    per_resultAry=[arr_keys mutableCopy];
    
    for (int i1=0; i1<arr_keys.count; i1++)
    {
        for (int j1=0; j1<arr_keys.count; j1++)
        {
            NSString *s1=[NSString stringWithFormat:@"%@",[per_resultAry objectAtIndex:i1]];
            NSString *s2=[NSString stringWithFormat:@"%@",[per_resultAry objectAtIndex:j1]];
            
            int l=[s1 intValue];
            int k=[s2 intValue];
            //                        NSLog(@"%d %d",l,k);
            if(l<k)
            {
                NSString *t=[per_resultAry objectAtIndex:i1];
                [per_resultAry replaceObjectAtIndex:i1 withObject:[per_resultAry objectAtIndex:j1]];
                [per_resultAry replaceObjectAtIndex:j1 withObject:t];
            }
            
        }
    }
    NSMutableDictionary *scoreID_Dict;
    scoreID_Dict=[[NSMutableDictionary alloc]init];
    
            
    NSMutableArray *tmepArray=[NSMutableArray array];
    int k=0;
    //EmptyCountval=0;
        
    for(int i=0;i<[sortedAry count];i++)
    {
        NSMutableDictionary *ddd=[[perfType_Dict_result objectForKey:[sortedAry objectAtIndex:i]] mutableCopy];
        [ddd removeObjectForKey:@"max_score"];
      NSArray *arrrrr=[ddd allKeys];
     [titles_resultAry removeAllObjects];
        titles_resultAry=[[NSMutableArray alloc]init];
        titles_resultAry=[arrrrr mutableCopy];
        for (int i1=0; i1<arrrrr.count; i1++)
        {
            for (int j1=0; j1<arrrrr.count; j1++)
            {
                NSString *s1=[NSString stringWithFormat:@"%@",[titles_resultAry objectAtIndex:i1]];
                NSString *s2=[NSString stringWithFormat:@"%@",[titles_resultAry objectAtIndex:j1]];
                
                int l=[s1 intValue];
                int k=[s2 intValue];
                NSLog(@"%d %d",l,k);
                if(l<k)
                {
                    NSString *t=[titles_resultAry objectAtIndex:i1];
                    [titles_resultAry replaceObjectAtIndex:i1 withObject:[titles_resultAry objectAtIndex:j1]];
                    [titles_resultAry replaceObjectAtIndex:j1 withObject:t];
                 
                }
                
            }
        }
        
        for (int p=0; p<titles_resultAry.count; p++)
        {
            [tmepArray insertObject:[[_mainScoreDict objectForKey:[NSNumber numberWithInt:i]] objectAtIndex:p] atIndex:k];
            k++;
            
            if ([[[_mainScoreDict objectForKey:[NSNumber numberWithInt:i]]objectAtIndex:p] floatValue]==0)
            {
                EmptyCountval++;
            }
            
        }
    }
    
        if (EmptyCountval==[ratingTitle_IDAry count])
        {
            checkEmptyAlert=[[UIAlertView alloc]initWithTitle:@"All Score fields are empty" message:@"Please enter a score before submitting" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [checkEmptyAlert show];
        }
        
        else
        {
            
            for (int x=0; x<[ratingTitle_IDAry count]; x++)
            {
                NSMutableDictionary *score_Dict=[[NSMutableDictionary alloc]init];
                [score_Dict setObject:[ratingTitle_IDAry objectAtIndex:x] forKey:@"title_id"];
                [score_Dict setObject:[tmepArray objectAtIndex:x] forKey:@"score"];
                [scoreID_Dict setObject:score_Dict forKey:[ratingTitle_IDAry objectAtIndex:x]];
            }
            
            [dct setObject:scoreID_Dict forKey:@"scores"];
            NSLog(@"dcttt===%@",dct);
            
            //NSMutableArray *scoreAry1=[[NSMutableArray alloc]initWithObjects:@"Motions",@"farmations",@"cretivityy", nil];
            NSMutableDictionary *comments_Dict,*comments_DictID;
            comments_DictID=[[NSMutableDictionary alloc]init];
            for (int a=0; a<[sortedAry count]; a++) {
                
                comments_Dict=[[NSMutableDictionary alloc]init];
                [comments_Dict setObject:[sortedAry objectAtIndex:a] forKey:@"title"];
                
                [comments_Dict setObject:[diction objectForKey:[NSNumber numberWithInt:a]] forKey:@"comments"];
                [comments_DictID setObject:comments_Dict forKey:[NSString stringWithFormat:@"%d",a]];
                
            }
            
            [dct setObject:comments_DictID forKey:@"comments"];
            NSLog(@"dcttt_AllValues===%@",dct);
            
            
            NSString *jsonstring1=[dct JSONRepresentation];
            NSString *jsonstring_encoding1 = [NSString stringWithFormat:@"%@",
                                              [jsonstring1 urlEncodeUsingEncoding:NSUTF8StringEncoding]];
            NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring_encoding1];
            ////NSLog(@"Post %@", post1);
            
            //NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_saveperformance.php",BASEURL];//getwbs_saveperformance_kishore.php
            
            NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_saveperformance_kishore.php",BASEURL];
            
            
            m_pWebService			= [[WebService alloc] initWebService:l_pURL];
            m_pWebService.mDelegate		= self;
            [m_pWebService  sendHTTPPost:post1];
            
        }
        
        
    
    
        }
       
    //////tumbling
    else if([value isEqualToString:[dropdownArray objectAtIndex:1]])
    {
        
        
       [self showBusyView];
        CheckWebService=@"SubmitAllValues";
        Singleton *st=[Singleton getObject];
        NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
        [dct setObject:[st event_ID] forKey:@"event_id"];
            //for level and division
//            [dct setObject:[tf_gym text] forKey:@"division"];
//            [dct setObject:[tf_level text] forKey:@"level"];
        
        [dct setObject:[st division_id] forKey:@"division"];
        [dct setObject:[st level_id_new] forKey:@"level"];
            

            
        [dct setObject:[s_Obj loginUserID] forKey:@"commented_by"];
        if ([teamID isEqualToString:@""]||teamID==nil) {
            [dct setObject:@"" forKey:@"team_id"];
        }
        else
        {
            [dct setObject:teamID forKey:@"team_id"];
        }
        
            
        [dct setObject:@"2" forKey:@"perf_id"];

        if ([thumb_OverallCommentSTR1 isEqualToString:@""]||thumb_OverallCommentSTR1==nil) {
            [dct setObject:@"" forKey:@"overall_comment"];
        }
        else
        {
            NSString *jsonstring_encoding = [NSString stringWithFormat:@"%@",
                                             [thumb_OverallCommentSTR1 urlEncodeUsingEncoding:NSUTF8StringEncoding]];
            [dct setObject:jsonstring_encoding forKey:@"overall_comment"];
        }
       
        [dct setObject:@"0" forKey:@"team_perf_skill"];
            
            
            
            //set here for total score
        [dct setObject:[lbl_totalScore_value_tc text] forKey:@"total_score"];
        
        
        /////////
        NSArray *arr_keys=[perfType_Dict_result allKeys];
        
        //sortedAry=[arr_keys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        [per_resultAry removeAllObjects];
        per_resultAry=[[NSMutableArray alloc]init];
        per_resultAry=[arr_keys mutableCopy];
        
        for (int i1=0; i1<arr_keys.count; i1++)
        {
            for (int j1=0; j1<arr_keys.count; j1++)
            {
                NSString *s1=[NSString stringWithFormat:@"%@",[per_resultAry objectAtIndex:i1]];
                NSString *s2=[NSString stringWithFormat:@"%@",[per_resultAry objectAtIndex:j1]];
                
                int l=[s1 intValue];
                int k=[s2 intValue];
                //                        NSLog(@"%d %d",l,k);
                if(l<k)
                {
                    NSString *t=[per_resultAry objectAtIndex:i1];
                    [per_resultAry replaceObjectAtIndex:i1 withObject:[per_resultAry objectAtIndex:j1]];
                    [per_resultAry replaceObjectAtIndex:j1 withObject:t];
                }
                
            }
        }
        NSMutableDictionary *scoreID_Dict;
        scoreID_Dict=[[NSMutableDictionary alloc]init];
        
        NSMutableArray *tmepArray=[NSMutableArray array];
        int k=0;
        
        
        for(int i=0;i<[sortedAry count];i++)
        {
            NSMutableDictionary *ddd=[[perfType_Dict_result objectForKey:[sortedAry objectAtIndex:i]] mutableCopy];
            [ddd removeObjectForKey:@"max_score"];
            NSArray *arrrrr=[ddd allKeys];
            [titles_resultAry removeAllObjects];
            titles_resultAry=[[NSMutableArray alloc]init];
            titles_resultAry=[arrrrr mutableCopy];
            for (int i1=0; i1<arrrrr.count; i1++)
            {
                for (int j1=0; j1<arrrrr.count; j1++)
                {
                    NSString *s1=[NSString stringWithFormat:@"%@",[titles_resultAry objectAtIndex:i1]];
                    NSString *s2=[NSString stringWithFormat:@"%@",[titles_resultAry objectAtIndex:j1]];
                    
                    int l=[s1 intValue];
                    int k=[s2 intValue];
                    NSLog(@"%d %d",l,k);
                    if(l<k)
                    {
                        NSString *t=[titles_resultAry objectAtIndex:i1];
                        [titles_resultAry replaceObjectAtIndex:i1 withObject:[titles_resultAry objectAtIndex:j1]];
                        [titles_resultAry replaceObjectAtIndex:j1 withObject:t];
                        
                    }
                    
                }
            }
            
            for (int p=0; p<titles_resultAry.count; p++)
            {
                [tmepArray insertObject:[[_mainScoreDict_tumbling objectForKey:[NSNumber numberWithInt:i]] objectAtIndex:p] atIndex:k];
                k++;
                
                if ([[[_mainScoreDict_tumbling objectForKey:[NSNumber numberWithInt:i]]objectAtIndex:p] floatValue]==0)
                {
                    EmptyCountval++;
                }
                
            }
        }
        
        
        if (EmptyCountval==[ratingTitle_IDAry count])
        {
            checkEmptyAlert=[[UIAlertView alloc]initWithTitle:@"All Score fields are empty" message:@"Please enter a score before submitting" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [checkEmptyAlert show];
        }
        else
        {
            
            for (int x=0; x<[ratingTitle_IDAry count]; x++)
            {
                NSMutableDictionary *score_Dict=[[NSMutableDictionary alloc]init];
                [score_Dict setObject:[ratingTitle_IDAry objectAtIndex:x] forKey:@"title_id"];
                [score_Dict setObject:[tmepArray objectAtIndex:x] forKey:@"score"];
                [scoreID_Dict setObject:score_Dict forKey:[ratingTitle_IDAry objectAtIndex:x]];
            }
            
            
            [dct setObject:scoreID_Dict forKey:@"scores"];
            NSLog(@"dcttt===%@",dct);
            ///////
            
            
            
            //NSMutableArray *scoreAry1=[[NSMutableArray alloc]initWithObjects:@"Motions",@"farmations",@"cretivityy", nil];
            NSMutableDictionary *comments_Dict,*comments_DictID;
            comments_DictID=[[NSMutableDictionary alloc]init];
            for (int a=0; a<[sortedAry count]; a++) {
                
                comments_Dict=[[NSMutableDictionary alloc]init];
                [comments_Dict setObject:[sortedAry objectAtIndex:a] forKey:@"title"];
                
                [comments_Dict setObject:[dictionTumble objectForKey:[NSNumber numberWithInt:a]] forKey:@"comments"];
                [comments_DictID setObject:comments_Dict forKey:[NSString stringWithFormat:@"%d",a]];
                
            }
            
            [dct setObject:comments_DictID forKey:@"comments"];
            NSLog(@"dcttt_AllValues===%@",dct);
            
            NSString *jsonstring2=[dct JSONRepresentation];
            NSString *jsonstring_encoding2 = [NSString stringWithFormat:@"%@",
                                              [jsonstring2 urlEncodeUsingEncoding:NSUTF8StringEncoding]];
            NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring_encoding2];
            ////NSLog(@"Post %@", post1);
            
            //NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_saveperformance.php",BASEURL];
            
            NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_saveperformance_kishore.php",BASEURL];
            m_pWebService			= [[WebService alloc] initWebService:l_pURL];
            m_pWebService.mDelegate		= self;
            [m_pWebService  sendHTTPPost:post1];
            
        }
        
    }//choreography
    else if([value isEqualToString:[dropdownArray objectAtIndex:2]])
    {
        
        [self showBusyView];
        CheckWebService=@"SubmitAllValues";
        Singleton *sts=[Singleton getObject];
        NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
        [dct setObject:[sts event_ID] forKey:@"event_id"];
            
            //for level and division
//            [dct setObject:[tf_gym text] forKey:@"division"];
//            [dct setObject:[tf_level text] forKey:@"level"];
        [dct setObject:[sts division_id] forKey:@"division"];
        [dct setObject:[sts level_id_new] forKey:@"level"];

        
        [dct setObject:[s_Obj loginUserID] forKey:@"commented_by"];
        if ([teamID isEqualToString:@""]||teamID==nil) {
            [dct setObject:@"" forKey:@"team_id"];
        }
        else
        {
            [dct setObject:teamID forKey:@"team_id"];
        }
            Singleton *st=[Singleton getObject];
        
        [dct setObject:@"3" forKey:@"perf_id"];
        if ([txt_overAll_impr_scor_value_tc.text isEqualToString:@""]||txt_overAll_impr_scor_value_tc.text==nil) {
            [dct setObject:@"" forKey:@"overall_impression"];
        }
        else
        {
            [dct setObject:txt_overAll_impr_scor_value_tc.text forKey:@"overall_impression"];
        }
        if ([choreo_OverallCommentSTR1 isEqualToString:@""]||choreo_OverallCommentSTR1==nil) {
            [dct setObject:@"" forKey:@"overall_comment"];
        }
        else
        {
            NSString *jsonstring_encoding = [NSString stringWithFormat:@"%@",
                                             [choreo_OverallCommentSTR1 urlEncodeUsingEncoding:NSUTF8StringEncoding]];
            [dct setObject:jsonstring_encoding forKey:@"overall_comment"];
        }
       
        [dct setObject:@"0" forKey:@"team_perf_skill"];
      //[dct setObject:[NSString stringWithFormat:@"%@",dropdownArray_IDSTR] forKey:@"perf_id"];
        [dct setObject:[lbl_totalScore_value_tc text] forKey:@"total_score"];
        
        
        /////////
        NSArray *arr_keys=[perfType_Dict_result allKeys];
        
        //sortedAry=[arr_keys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        [per_resultAry removeAllObjects];
        per_resultAry=[[NSMutableArray alloc]init];
        per_resultAry=[arr_keys mutableCopy];
        
        for (int i1=0; i1<arr_keys.count; i1++)
        {
            for (int j1=0; j1<arr_keys.count; j1++)
            {
                NSString *s1=[NSString stringWithFormat:@"%@",[per_resultAry objectAtIndex:i1]];
                NSString *s2=[NSString stringWithFormat:@"%@",[per_resultAry objectAtIndex:j1]];
                
                int l=[s1 intValue];
                int k=[s2 intValue];
                //                        NSLog(@"%d %d",l,k);
                if(l<k)
                {
                    NSString *t=[per_resultAry objectAtIndex:i1];
                    [per_resultAry replaceObjectAtIndex:i1 withObject:[per_resultAry objectAtIndex:j1]];
                    [per_resultAry replaceObjectAtIndex:j1 withObject:t];
                }
                
            }
        }
        NSMutableDictionary *scoreID_Dict;
        scoreID_Dict=[[NSMutableDictionary alloc]init];
        
            NSMutableArray *tmepArray;
            [tmepArray removeAllObjects];
            tmepArray=[[NSMutableArray alloc]init];
        int k=0;
        
        
        for(int i=0;i<[sortedAry count];i++)
        {
            NSMutableDictionary *ddd=[[perfType_Dict_result objectForKey:[sortedAry objectAtIndex:i]] mutableCopy];
            [ddd removeObjectForKey:@"max_score"];
            
            NSArray *arrrrr=[ddd allKeys];
            [titles_resultAry removeAllObjects];
            titles_resultAry=[[NSMutableArray alloc]init];
            titles_resultAry=[arrrrr mutableCopy];
            for (int i1=0; i1<arrrrr.count; i1++)
            {
                for (int j1=0; j1<arrrrr.count; j1++)
                {
                    NSString *s1=[NSString stringWithFormat:@"%@",[titles_resultAry objectAtIndex:i1]];
                    NSString *s2=[NSString stringWithFormat:@"%@",[titles_resultAry objectAtIndex:j1]];
                    
                    int l=[s1 intValue];
                    int k=[s2 intValue];
                    NSLog(@"%d %d",l,k);
                    if(l<k)
                    {
                        NSString *t=[titles_resultAry objectAtIndex:i1];
                        [titles_resultAry replaceObjectAtIndex:i1 withObject:[titles_resultAry objectAtIndex:j1]];
                        [titles_resultAry replaceObjectAtIndex:j1 withObject:t];
                        
                    }
                    
                }
            }
            
            for (int p=0; p<titles_resultAry.count; p++)
            {
                //NSLog(@"ddadaqd=%@",[[_mainScoreDict_choreoghaphy objectForKey:[NSNumber numberWithInt:i]] objectAtIndex:p] atIndex:k]);
                
                [tmepArray insertObject:[[_mainScoreDict_choreoghaphy objectForKey:[NSNumber numberWithInt:i]] objectAtIndex:p] atIndex:k];
                k++;
                
                if ([[[_mainScoreDict_choreoghaphy objectForKey:[NSNumber numberWithInt:i]]objectAtIndex:p] floatValue]==0)
                {
                    EmptyCountval++;
                }
                
                
                
            }
        }
        
        
        if (EmptyCountval==[ratingTitle_IDAry count])
        {
            checkEmptyAlert=[[UIAlertView alloc]initWithTitle:@"All Score fields are empty" message:@"Please enter a score before submitting" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [checkEmptyAlert show];
        }
        else
        {
            for (int x=0; x<[ratingTitle_IDAry count]; x++)
            {
                NSMutableDictionary *score_Dict=[[NSMutableDictionary alloc]init];
                [score_Dict setObject:[ratingTitle_IDAry objectAtIndex:x] forKey:@"title_id"];
                [score_Dict setObject:[tmepArray objectAtIndex:x] forKey:@"score"];
                [scoreID_Dict setObject:score_Dict forKey:[ratingTitle_IDAry objectAtIndex:x]];
            }
            
            [dct setObject:scoreID_Dict forKey:@"scores"];
            NSLog(@"dcttt===%@",dct);
            ///////
            
            
            //NSMutableArray *scoreAry1=[[NSMutableArray alloc]initWithObjects:@"Motions",@"farmations",@"cretivityy", nil];
            NSMutableDictionary *comments_Dict,*comments_DictID;
            comments_DictID=[[NSMutableDictionary alloc]init];
            for (int a=0; a<[sortedAry count]; a++) {
                
                comments_Dict=[[NSMutableDictionary alloc]init];
                [comments_Dict setObject:[sortedAry objectAtIndex:a] forKey:@"title"];
                
                [comments_Dict setObject:[dictionChoreo objectForKey:[NSNumber numberWithInt:a]] forKey:@"comments"];
                [comments_DictID setObject:comments_Dict forKey:[NSString stringWithFormat:@"%d",a]];
                
            }
            
            [dct setObject:comments_DictID forKey:@"comments"];
            NSLog(@"dcttt_AllValues===%@",dct);
            
            
            NSString *jsonstring3=[dct JSONRepresentation];
            NSString *jsonstring_encoding3 = [NSString stringWithFormat:@"%@",
                                              [jsonstring3 urlEncodeUsingEncoding:NSUTF8StringEncoding]];
            NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring_encoding3];
            ////NSLog(@"Post %@", post1);
            
            //NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_saveperformance.php",BASEURL];
            
            NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_saveperformance_kishore.php",BASEURL];
            
            m_pWebService			= [[WebService alloc] initWebService:l_pURL];
            m_pWebService.mDelegate		= self;
            [m_pWebService  sendHTTPPost:post1];
            
            
            
        }
        
     
  }
    else if([value isEqualToString:[dropdownArray objectAtIndex:3]])
    {
        [self showBusyView];

        [btn_Start setTitle:@"Start" forState:UIControlStateNormal];
        
        secondsLeft=0;
        
        [timer invalidate];
        
        showTime.text = [NSString stringWithFormat:@"00:00:00"];
        
        
        
        CheckWebService=@"SubmitAllValues_FromDeduction";
          Singleton *st=[Singleton getObject];
        //NSMutableDictionary  *dct_deduct=[[NSMutableDictionary alloc] init];
        
        scoreDictmain=[[NSMutableDictionary alloc]init];
        
        scoreDict=[[NSMutableDictionary alloc]init];
        
        [scoreDict setObject:[st event_ID] forKey:@"event_id"];
        
        //for level and division
        [scoreDict setObject:[st division_id] forKey:@"division"];
        [scoreDict setObject:[st level_id_new] forKey:@"level"];
        
      
        [s setLbl_Division:[tf_gym text]];
        [s setLbl_Label:[tf_level text]];
        
        [scoreDict setObject:[s_Obj loginUserID] forKey:@"commented_by"];
        if ([teamID isEqualToString:@""]||teamID==nil)
        {
            [scoreDict setObject:@"" forKey:@"team_id"];
        }
        else
        {
            [scoreDict setObject:teamID forKey:@"team_id"];
        }
        
        [scoreDict setObject:@"4" forKey:@"perf_id"];
        [scoreDict setObject:lbl_total_deduction.text forKey:@"total_score"];
        
        //NSMutableDictionary *scoreDictmain=[[NSMutableDictionary alloc]init];
        //NSMutableDictionary *scoreDict=[[NSMutableDictionary alloc]init];
        
        
        
        
        
        int key=0;
        int ids=21;
        for(int i=0;i<[[main_Dict_final allKeys]count];i++)
        {
            
            NSDictionary *dict=[array_cellLbl_tumbling objectAtIndex:i];
            
            
            for(int i=0;i<[[dict allKeys]count];i++)
            {
                
              sort=[[dict allKeys]sortedArrayUsingComparator:^NSComparisonResult(id obj1,id obj2) {
                    if([obj1 integerValue]>[obj2 integerValue])
                    {
                        return NSOrderedDescending;
                        
                    }
                    else
                    {
                        return NSOrderedAscending;
                    }
                }];
                
                
                
            }
            
            
            //[[[main_Dict_final objectForKey:[NSNumber numberWithInt:i]] allKeys] count]  [[main_Dict_final allKeys]count]
            
            NSArray *temp=[total_Sum objectForKey:[NSNumber numberWithInt:i]];
            // for timer
          // NSArray *temp2= [[dedDict_IndexPath_Total_Lbl_timeStamp_Save objectForKey:[NSNumber numberWithInt:i]] objectForKey:[NSNumber numberWithInt:i]];
            NSDictionary *tempDict=[dedDict_IndexPath_Total_Lbl_timeStamp_Save objectForKey:[NSNumber numberWithInt:i]];
            
            
            for(int k=0;k<[[[main_Dict_final objectForKey:[NSNumber numberWithInt:i]] allKeys] count];k++)
                
            {
                
                
                NSArray *scrArray=[[main_Dict_final objectForKey:[NSNumber numberWithInt:i]] objectForKey:[NSNumber numberWithInt:k]];
                NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] init];
                
                
                [dict1 setObject:[sort objectAtIndex:k] forKey:@"title_id"];
                
                /////
                
                //[dict1 setObject:[NSArray arrayWithObject:[tempDict objectForKey:[NSNumber numberWithInt:k]]] forKey:@"Newtimer"];
                
                ////
                
                
                
                [dict1 setObject:[scrArray objectAtIndex:0] forKey:@"left_score"];
                [dict1 setObject:[scrArray objectAtIndex:1] forKey:@"center_score"];
                [dict1 setObject:[scrArray objectAtIndex:2] forKey:@"right_score"];
                //[dict1 setObject:@"2" forKey:@"deduction_score"];
                [dict1 setObject:[temp objectAtIndex:k] forKey:@"deduction_score"];
                // for timer
                NSString *str1=[[tempDict objectForKey:[NSNumber numberWithInt:k]] objectAtIndex:0];
               //NSString *str2=[str1 stringByTrimmingCharactersInSet:@" "];
                
                [dict1 setObject:[NSString stringWithFormat:@"%@",str1] forKey:@"timer"];
                
                
                NSLog(@"numofcell%d  and num ofrow %d %@",i,k,dict1);
                
                
                [scoreDictmain setObject:dict1 forKey:[NSString stringWithFormat:@"%d",key]];
                key++;
                ids++;
                
            }
            
        }
        
        if ([lbl_total_deduction.text isEqualToString:@"0.0"])
        {
            checkEmptyAlert=[[UIAlertView alloc]initWithTitle:@"All Score fields are empty" message:@"Please enter a score before submitting" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [checkEmptyAlert show];
        }
        
        else
        {
        
        [scoreDict setObject:scoreDictmain forKey:@"scores"];
        
        NSLog(@"scoremain dict %@",scoreDictmain);
        
        NSLog(@"dct dict %@",scoreDict);
        
        NSString *jsonstring1=[scoreDict JSONRepresentation];
        ////NSLog(@"jsonstring=%@",jsonstring1);
        NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring1];
        ////NSLog(@"Post %@", post1);
        
        NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_savededuction.php",BASEURL];
        m_pWebService			= [[WebService alloc] initWebService:l_pURL];
        m_pWebService.mDelegate		= self;
        [m_pWebService  sendHTTPPost:post1];
        
        }
        
        }

    }
    

}

- (UIImage *)captureView:(UIView *)view
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    UIGraphicsBeginImageContext(screenRect.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set];
    CGContextFillRect(ctx, screenRect);
    
    [view.layer renderInContext:ctx];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (IBAction)commentSubmitbtn_clickedFrom_Overall:(id)sender
{
    if([[comment_vf_Overall text]isEqualToString:@""] || comment_vf_Overall.text==nil)
    {
    
        UIAlertView *vew=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Fill The Comments" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [vew show];

    }
   
    else
    {
    if([value isEqualToString:[dropdownArray objectAtIndex:0]])
    {
        NSLog(@"%@",comment_vf.text);
   
        stunt_OverallCommentSTR1=comment_vf_Overall.text;
    }
    else if([value isEqualToString:[dropdownArray objectAtIndex:1]])
    {
       
        thumb_OverallCommentSTR1=comment_vf_Overall.text;
    }
    else if([value isEqualToString:[dropdownArray objectAtIndex:2]])
    {
                choreo_OverallCommentSTR1=comment_vf_Overall.text;
    }
    
        
    saveComment_Alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Comment Submitted" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [saveComment_Alert1 show];
    
       }

}

- (IBAction)cancelfromcomtview_clickedFrom_Overall:(id)sender
{
    [overAll_imp_comt_View_New1 removeFromSuperview];
}
//#pragma mark ******headjudge_Sumary_View

-(IBAction)rankingEventBtn_Clicked:(id)sender
{
    
    
    // http://joomerang.geniusport.com/cheerinfinity/webservices_prod/getwbs_event_ranking.php?json=[{"userid":"41","event":"10"}]
    
    //http://54.191.2.63/spiritcentral_uat/webservices_dev/
    
    
    Singleton *s=[Singleton getObject];
    
    [self showBusyView];
    CheckWebService=@"Ranking Event";
    NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
    
    [dct setObject:[s loginUserID] forKey:@"userid"];
    [dct setObject:[s event_ID] forKey:@"event"];
    
    NSString *jsonstring1=[dct JSONRepresentation];
    ////NSLog(@"jsonstring=%@",jsonstring1);
    NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring1];
    ////NSLog(@"Post %@", post1);
    
    NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_event_ranking_new.php",BASEURL];
    m_pWebService			= [[WebService alloc] initWebService:l_pURL];
    m_pWebService.mDelegate		= self;
    [m_pWebService  sendHTTPPost:post1];
    
   
}

-(void)teamSummaryBtn_Clicked
{
    //http://joomerang.geniusport.com/cheerinfinity/webservices_prod/getwbs_team_eventsummary1.php?json=[{"userid":"41","team":"220","event":"8","division":"Mini","level":"Level 1"}]
    
    
//    TeamSummaryViewController *teamSum=[[TeamSummaryViewController alloc]initWithNibName:@"TeamSummaryViewController" bundle:nil];
//    [self presentModalViewController:teamSum animated:YES];
    
    
    Singleton *s=[Singleton getObject];
    
    [s setLbl_Division:[tf_gym text]];
    [s setLbl_Label:[tf_level text]];
    
    // joomerang.geniusport.com/cheerinfinity/webservices/getwbs_team_eventsummary.php?json=[{"userid":"79","event":"1","team":"1","eventdate":"2014-02-27"}]
    
    [self showBusyView];
    CheckWebService=@"TeamSummary";
    NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
    
    [dct setObject:[s loginUserID] forKey:@"userid"];
    [dct setObject:[s event_ID] forKey:@"event"];
    [dct setObject:[s team_id] forKey:@"team"];
    [dct setObject:[s division_id]forKey:@"division"];
    [dct setObject:[s level_id_new] forKey:@"level"];
    
    NSString *jsonstring1=[dct JSONRepresentation];
    NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring1];
    NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_event_summary_new.php",BASEURL];
    
//    NSString *qwe=[l_pURL stringByAppendingString:post1];
//    NSLog(@"%@",qwe);
    
    m_pWebService			= [[WebService alloc] initWebService:l_pURL];
    m_pWebService.mDelegate		= self;
    [m_pWebService  sendHTTPPost:post1];
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    [UIMenuController sharedMenuController].menuVisible = NO;  //do not display the menu
    [self resignFirstResponder];                      //do not allow the user to selected anything
    return NO;
    
}
-(void)starts
{
    
    secondsLeft=0;
    
  if (running==YES)
        
    {
        
        
        [btn_Start setTitle:@"Stop" forState:UIControlStateNormal];
        
        running=NO;
        
    }
    else
        
    {
  
        [btn_Start setTitle:@"Start" forState:UIControlStateNormal];
        
       running=YES;
        
    }
    
    if ([[btn_Start titleLabel].text isEqualToString:@"Start"])
        
    {
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        [btn_Start setTitle:@"Stop" forState:UIControlStateNormal];
        
    }
    
    else if([[btn_Start titleLabel].text isEqualToString:@"Stop"])
        
    {
        [btn_Start setTitle:@"Start" forState:UIControlStateNormal];
        
        secondsLeft=0;
        
        [timer invalidate];
        
        showTime.text = [NSString stringWithFormat:@"00:00:00"];
        
    }
   }

-(void)updateTimer
{
    secondsLeft ++ ;
    
    hours = secondsLeft / 3600;
    
    minutes = (secondsLeft % 3600) / 60;
    
    seconds = (secondsLeft %3600) % 60;
    
    showTime.text = [NSString stringWithFormat:@"%02d:%02d:%02d",hours,minutes, seconds];
    
    
}
// to test the error cause for "no-index-path-for-table-cell-being-reused"
//[self.cellTextView setClearsOnInsertion:YES];


-(IBAction)leftPan_Clicked:(id)sender
{
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status == NotReachable)
    {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"" message:@"Please check your Wi-Fi or 3G connection and try again" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [al show];

    }
    else
    {
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
        [delegate.viewController_leftPane showLeftPanelAnimated:YES];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"leftPan" object:nil];
        
 //  [[NSNotificationCenter defaultCenter]removeObserver:self name:@"CallSlideOut" object:nil];
        
    }
    
}

-(IBAction)logoutBtn_Clicked:(id)sender
{
    logoutAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"Do you want to Logout?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [logoutAlert show];
}

-(void)showBusyView
{
    AppDelegate *l_pAppDelegate	= (AppDelegate *)[[UIApplication sharedApplication] delegate];
	[l_pAppDelegate startActivity];
}

-(void)hideBusyView
{
    AppDelegate *l_pAppDelegate	= (AppDelegate *)[[UIApplication sharedApplication] delegate];
	[l_pAppDelegate stopActivity];
}

-(IBAction)backBtn_selected:(id)sender
{
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
    {
        ScheduleScreenViewController *obj=[[ScheduleScreenViewController alloc]initWithNibName:@"ScheduleScreenViewController" bundle:nil];
        [self presentViewController:obj animated:YES completion:nil];
    }
    else
    {
        ScheduleScreenViewController *obj=[[ScheduleScreenViewController alloc]initWithNibName:@"ScheduleScreenViewController_ios6" bundle:nil];
        [self presentViewController:obj animated:YES completion:nil];
    }
    
    // [[self view]addSubview:[obj view_SearchView]];
}

-(void)teamInfo_Display
{
    Singleton *s=[Singleton getObject];
    NSLog(@"teaminfoid==%@",[s team_id]);
    if([[s team_id]isEqualToString:@""] || [s team_id]==nil)
    {
        
        UIAlertView *vew=[[UIAlertView alloc]initWithTitle:@"" message:@"No Team Info Available" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [vew show];
        
    }
    else
    {
        
        teamID=[s team_id];
        
        //calling tema info display from viewdidload
        // http://joomerang.geniusport.com/cheerinfinity/webservices/getwbs_teaminfo.php?json=[{"team_id":"1"}]
        //url change
        //http://54.191.2.63/spiritcentral_uat/webservices_dev/
        
        [self showBusyView];
        CheckWebService=@"TeamInfo_Display";
        NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
        //amith change
        
        NSLog(@"teaminfoid==%@",[s team_id]);
        
        [dct setObject:[s team_id] forKey:@"team_id"];
        NSString *jsonstring1=[dct JSONRepresentation];
        ////NSLog(@"jsonstring=%@",jsonstring1);
        NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring1];
        ////NSLog(@"Post %@", post1);
        
        NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_teaminfo.php",BASEURL];
        m_pWebService			= [[WebService alloc] initWebService:l_pURL];
        m_pWebService.mDelegate		= self;
        [m_pWebService  sendHTTPPost:post1];
        
    }
}

- (void) myKeyboardWillHideHandler:(NSNotification *)notification
{
    //    [textField resignFirstResponder];
    [self.view endEditing:YES];
    [self.tableview1 setContentOffset:CGPointZero animated:YES];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer    shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer   *)otherGestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]])
    {
        return  NO;
    }
    else if([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]])
    {
        return  NO;
    }
    else
        return NO;
}

-(void)viewDidlLoadFontAndColorMethod
{
    lbl_divisionTitle.font=[UIFont fontWithName:@"Enigmatic" size:19];
    lbl_levelTitle.font=[UIFont fontWithName:@"Enigmatic" size:19];
    
    [btn_submit.titleLabel setFont:[UIFont fontWithName:@"Enigmatic" size:24]];
    
    btn_rankEvent.titleLabel.font=[UIFont fontWithName:@"Enigmatic" size:20];
    
    //font
    //main header
    lbl_Main_header.font=[UIFont fontWithName:@"Enigmatic" size:26];
    catLable.font=[UIFont fontWithName:@"Enigmatic" size:22];
    
    // team info
    lbl_main_cheer_name.font=[UIFont fontWithName:@"Enigmatic" size:18];
    lbl_main_cheer_address.font=[UIFont fontWithName:@"Enigmatic" size:18];
    
    //perfomance heading
    lbl_Head_Date_title.font=[UIFont fontWithName:@"Enigmatic" size:18];
    lbl_scor_header.font=[UIFont fontWithName:@"Enigmatic" size:18];
    
    //stunt score lable
    lbl_scor_title.font=[UIFont fontWithName:@"Enigmatic" size:16];
    lbl_scor_div_five.font=[UIFont fontWithName:@"Enigmatic" size:20];
    lbl_overAll_impr_title.font=[UIFont fontWithName:@"Enigmatic" size:18];
    lbl_overAll_impr_divFive.font=[UIFont fontWithName:@"Enigmatic" size:20];
    lbl_overAll_impr_score_title.font=[UIFont fontWithName:@"Enigmatic" size:16];
    lbl_overAll_impr_judgeComm.font=[UIFont fontWithName:@"Enigmatic" size:16];
    lbl_totalScore_title.font=[UIFont fontWithName:@"Enigmatic" size:18];
    totalscrore_lbl.font=[UIFont fontWithName:@"Enigmatic" size:40];
    
    //tumble score lable
    lbl_overAll_impr_title_tc.font=[UIFont fontWithName:@"Enigmatic" size:18];
    lbl_overAll_divFive_tum.font=[UIFont fontWithName:@"Enigmatic" size:20];
    lbl_overAll_impr_score_title_tc.font=[UIFont fontWithName:@"Enigmatic" size:16];
    lbl_overAll_impr_judgeComm_tc.font=[UIFont fontWithName:@"Enigmatic" size:16];
    lbl_totalScore_title_tc.font=[UIFont fontWithName:@"Enigmatic" size:18];
    lbl_totalScore_value_tc.font=[UIFont fontWithName:@"Enigmatic" size:40];
    
    //deduction
    lbl_total_heading.font=[UIFont fontWithName:@"Enigmatic" size:18];
    lbl_total_deduction.font=[UIFont fontWithName:@"Enigmatic" size:18];
    lbl_totalScoreTitle_inDedution.font=[UIFont fontWithName:@"Enigmatic" size:18];
    lbl_totalScore_value_inDeduction.font=[UIFont fontWithName:@"Enigmatic" size:40];
    
    
    //comment view
    lbl_header_inOverAllComment.font=[UIFont fontWithName:@"Enigmatic" size:26];
    lbl_header_Comment.font=[UIFont fontWithName:@"Enigmatic" size:26];
    lbl_header_CommentNew.font=[UIFont fontWithName:@"Enigmatic" size:26];
    
    
    // drop down textfields
    
    tf_gym.font=[UIFont fontWithName:@"Enigmatic" size:18];
    tf_level.font=[UIFont fontWithName:@"Enigmatic" size:18];
    tf_dropdown.font=[UIFont fontWithName:@"Enigmatic" size:18];
    txt_scor_value.font=[UIFont fontWithName:@"Enigmatic" size:18];
    overallimpression_tf.font=[UIFont fontWithName:@"Enigmatic" size:18];
    txt_overAll_impr_scor_value_tc.font=[UIFont fontWithName:@"Enigmatic" size:18];
    
    
    
    //for timer
    
    showTime.font=[UIFont fontWithName:@"Enigmatic" size:18];
    showTime.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
    
    btn_Start.titleLabel.font=[UIFont fontWithName:@"Enigmatic" size:16];
    btn_Start.titleLabel.textColor=[UIColor colorWithRed:250.0/250.0 green:250.0/250.0 blue:250.0/250.0 alpha:1.0];
    //text color
    
    //main header
    lbl_Main_header.textColor=[UIColor colorWithRed:250.0/250.0 green:250.0/250.0 blue:250.0/250.0 alpha:1.0];
    tf_dropdown.textColor=[UIColor colorWithRed:250.0/250.0 green:250.0/250.0 blue:250.0/250.0 alpha:1.0];
    
    catLable.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0]
    ;
    
    lbl_Head_Date_title.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
    //stunt score lable
    lbl_scor_title.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
    lbl_scor_div_five.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
    lbl_overAll_impr_score_title.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:90.0/250.0 alpha:1.0];
    lbl_overAll_impr_divFive.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
    lbl_overAll_impr_judgeComm.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
    
    
    //tumble score lable
    lbl_scor_title.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
    lbl_overAll_divFive_tum.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
    lbl_overAll_impr_score_title_tc.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:90.0/250.0 alpha:1.0];
    
    lbl_overAll_impr_judgeComm_tc.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
    
    //deduction score
    
    //main textfild
    txt_scor_value.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
    overallimpression_tf.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
    txt_overAll_impr_scor_value_tc.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];


}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSCharacterSet *nonNumberSet= [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERS1parentEmailID] invertedSet];
    
    if([text isEqualToString:@""])
    {
        return YES;
        
    }
    
    if(range.location>=350)
    {
        return NO;
    }
    else
    {
        return ([text stringByTrimmingCharactersInSet:nonNumberSet].length>0);
    }
    return NO;

}

@end
