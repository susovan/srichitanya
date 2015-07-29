//
//  TeamSummaryViewController.m
//  Cheer&Dance
//
//  Created by Amit on 4/4/14.
//  Copyright (c) 2014 Adeptpros. All rights reserved.
//

#import "TeamSummaryViewController.h"
#import "TeamSummaryCell.h"
#import "AppDelegate.h"
#import "Singleton.h"
#import "Defines.h"
#import "JASidePanelController.h"
#import "ViewController.h"
#import "ScheduleScreenViewController.h"

#define ACCEPTABLE_CHARECTERS @"ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_- "
#define ACCEPTABLE_CHARECTERS1 @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_- "
#define ACCEPTABLE_CHARECTERSstudentID @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_- "
#define ACCEPTABLE_CHARECTERS1parentEmailID @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ~@!#$%^&*()_+-={}[]:;?/><,.1234567890 "
#define Email_CharSet @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"

@interface TeamSummaryViewController ()
{
    UIAlertView *NextTeamAlert;

   NSArray *ar_TimeStamp;
    BOOL comment1;
}

@end

@implementation TeamSummaryViewController


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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)WebServiceRequestCompleted:(NSDictionary *)result context:(NSString *)context
{
    NSLog(@"%@ : %@",context,result);
    
    if ([context isEqualToString:@"performancType_build"])
    {
        keyOrder_build=[result objectForKey:@"keys_order"];
      NSArray *tempary1= [[result objectForKey:@"perforamces"] allKeys];
        NSMutableArray *unsorted=[[NSMutableArray alloc]init];
        for (int i=0; i<[tempary1 count]; i++)
        {
            screenTypeDict_build=[result objectForKey:@"perforamces"];
           NSMutableDictionary *DictTemp= [[[result objectForKey:@"perforamces"] objectForKey:[tempary1 objectAtIndex:i]] mutableCopy];
            
            [DictTemp removeObjectForKey:@"max_score"];
            
            NSArray *aryTemp=[DictTemp allKeys];
            
            for (int j=0; j<[aryTemp count]; j++)
            {
                [unsorted addObject:[aryTemp objectAtIndex:j]];
                
            }
        }
        RatingTile_IDArray_build=[unsorted sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        
    }
    else if ([context isEqualToString:@"performancType_tum"])
    {
        screenTypeDict_tum=[result objectForKey:@"perforamces"];
        keyOrder_tumb=[result objectForKey:@"keys_order"];

        NSArray *tempary1= [[result objectForKey:@"perforamces"] allKeys];
        NSMutableArray *unsorted=[[NSMutableArray alloc]init];
        for (int i=0; i<[tempary1 count]; i++)
        {
            NSMutableDictionary *DictTemp= [[[result objectForKey:@"perforamces"] objectForKey:[tempary1 objectAtIndex:i]] mutableCopy];
            
            [DictTemp removeObjectForKey:@"max_score"];
            
            NSArray *aryTemp=[DictTemp allKeys];
            
            for (int j=0; j<[aryTemp count]; j++)
            {
                [unsorted addObject:[aryTemp objectAtIndex:j]];
                
            }
        }
        RatingTile_IDArray_tumb=[unsorted sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    else if ([context isEqualToString:@"performancType_cho"])
    {
        screenTypeDict_cho=[result objectForKey:@"perforamces"];
        
        keyOrder_cho=[result objectForKey:@"keys_order"];
        NSArray *tempary1= [[result objectForKey:@"perforamces"] allKeys];
        NSMutableArray *unsorted=[[NSMutableArray alloc]init];
        for (int i=0; i<[tempary1 count]; i++)
        {
            NSMutableDictionary *DictTemp= [[[result objectForKey:@"perforamces"] objectForKey:[tempary1 objectAtIndex:i]] mutableCopy];
            
            [DictTemp removeObjectForKey:@"max_score"];
            
            NSArray *aryTemp=[DictTemp allKeys];
            
            for (int j=0; j<[aryTemp count]; j++)
            {
                [unsorted addObject:[aryTemp objectAtIndex:j]];
                
            }
        }
        RatingTile_IDArray_cho=[unsorted sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    
    else if ([context isEqualToString:@"performancType_deduct"])
    {
        screenTypeDict_ded=[result objectForKey:@"perforamces"];
        keyOrder_deduct=[result objectForKey:@"keys_order"];
        
        NSArray *tempary1= [[result objectForKey:@"perforamces"] allKeys];
        NSMutableArray *unsorted=[[NSMutableArray alloc]init];
        for (int i=0; i<[tempary1 count]; i++)
        {
            NSMutableDictionary *DictTemp= [[[result objectForKey:@"perforamces"] objectForKey:[tempary1 objectAtIndex:i]] mutableCopy];
            
            [DictTemp removeObjectForKey:@"max_score"];
            
            NSArray *aryTemp=[DictTemp allKeys];
            
            for (int j=0; j<[aryTemp count]; j++)
            {
                [unsorted addObject:[aryTemp objectAtIndex:j]];
                
            }
        }
        
        RatingTile_IDArray_ded=[[NSArray alloc]init];
        
        RatingTile_IDArray_ded=[unsorted sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }

    Singleton *s=[Singleton getObject];
    
    // joomerang.geniusport.com/cheerinfinity/webservices/getwbs_team_eventsummary.php?json=[{"userid":"79","event":"1","team":"1","eventdate":"2014-02-27"}]
    
    //[self showBusyView];
    CheckWebService=@"TeamSummary";
    NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
    
    [dct setObject:[s loginUserID] forKey:@"userid"];
    [dct setObject:[s event_ID] forKey:@"event"];
    [dct setObject:[s team_id] forKey:@"team"];
    //"eventdate":"2014-02-27"
    //[dct  setObject:[s date_Name1] forKey:@"eventdate"];
    [dct setObject:[s division_id]forKey:@"division"];
    [dct setObject:[s level_id_new] forKey:@"level"];

//    [dct setObject:[s lbl_Division] forKey:@"division"];
//    [dct setObject:[s lbl_Label] forKey:@"level"];
    
    NSString *jsonstring1=[dct JSONRepresentation];
    ////NSLog(@"jsonstring=%@",jsonstring1);
    NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring1];
    ////NSLog(@"Post %@", post1);//getwbs_event_summary_new.php
    
    //NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_team_eventsummary1.php",BASEURL];
    //NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_team_eventsummary_new.php",BASEURL];
    NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_event_summary_new.php",BASEURL];

    m_pWebService			= [[WebService alloc] initWebService:l_pURL];
    m_pWebService.mDelegate		= self;
    [m_pWebService  sendHTTPPost:post1];
}

-(void)WebServiceRequestFailed:(NSString *)context service:(NSString *)api
{
    
    
}

- (void)viewDidLoad
{
   // for edit func
    
    txtDict=[[NSMutableDictionary alloc]init];
    AddBtnDict=[[NSMutableDictionary alloc]init];
    SubBtnDict=[[NSMutableDictionary alloc]init];
    
    //txtTempDict=[[NSMutableDictionary alloc]init];
    //addTempDict=[[NSMutableDictionary alloc]init];
    //subTempDict=[[NSMutableDictionary alloc]init];
    
    //txtValTempDict=[[NSMutableDictionary alloc]init];
    txtValDict=[[NSMutableDictionary alloc]init];
    
    ComntDict=[[NSMutableDictionary alloc]init];
    finalValDict=[[NSMutableDictionary alloc]init];
    
    
    // edit func
    [super viewDidLoad];
    
    [btn_Approve.titleLabel setFont:[UIFont fontWithName:@"Enigmatic" size:18]];
    btn_Approve.titleLabel.textColor=[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    [btn_NotApprove.titleLabel setFont:[UIFont fontWithName:@"Enigmatic" size:18]];
    btn_NotApprove.titleLabel.textColor=[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    [btn_Edit.titleLabel setFont:[UIFont fontWithName:@"Enigmatic" size:18]];
    btn_Edit.titleLabel.textColor=[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    
    
    
    
    lbl_Sumry_Event_Title_Head.font=[UIFont fontWithName:@"Enigmatic" size:24];
    lbl_Sumry_Date_Head.font=[UIFont fontWithName:@"Enigmatic" size:16];
    lbl_Sumry_Event_Title_Head.textColor=[UIColor colorWithRed:250.0/250.0 green:250.0/250.0 blue:250.0/250.0 alpha:1.0];
    lbl_Sumry_Date_Head.textColor=[UIColor colorWithRed:250.0/250.0 green:250.0/250.0 blue:250.0/250.0 alpha:1.0];
    
    
    lbl_Sumry_Choreo_Score_head.font=[UIFont fontWithName:@"Enigmatic" size:17];
    lbl_Sumry_Choreo_Score_head.textColor=[UIColor colorWithRed:250.0/250.0 green:250.0/250.0 blue:250.0/250.0 alpha:1.0];
    lbl_Sumry_Choreo_Score.font=[UIFont fontWithName:@"Enigmatic" size:17];
    lbl_Sumry_Choreo_Score.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];

    
    lbl_Sumry_Stunts_Score_head.font=[UIFont fontWithName:@"Enigmatic" size:17];
    lbl_Sumry_Stunts_Score_head.textColor=[UIColor colorWithRed:250.0/250.0 green:250.0/250.0 blue:250.0/250.0 alpha:1.0];
    lbl_Sumry_Stunts_Score.font=[UIFont fontWithName:@"Enigmatic" size:17];
    lbl_Sumry_Stunts_Score.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];

    
    lbl_Sumry_Tumbling_Score_head.font=[UIFont fontWithName:@"Enigmatic" size:17];
    lbl_Sumry_Tumbling_Score_head.textColor=[UIColor colorWithRed:250.0/250.0 green:250.0/250.0 blue:250.0/250.0 alpha:1.0];
    lbl_Sumry_Tumbling_Score.font=[UIFont fontWithName:@"Enigmatic" size:17];
    lbl_Sumry_Tumbling_Score.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];

    
    lbl_Sumry_Dance_Score_head.font=[UIFont fontWithName:@"Enigmatic" size:17];
    lbl_Sumry_Dance_Score_head.textColor=[UIColor colorWithRed:250.0/250.0 green:250.0/250.0 blue:250.0/250.0 alpha:1.0];
    lbl_Sumry_Dance_Score.font=[UIFont fontWithName:@"Enigmatic" size:17];
    
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
    {
        lbl_Sumry_Deduction_Score_head.font=[UIFont fontWithName:@"Enigmatic" size:15];
        
    }
    else
    {
        lbl_Sumry_Deduction_Score_head.font=[UIFont fontWithName:@"Enigmatic" size:17];

    }
    
    lbl_Sumry_Deduction_Score_head.textColor=[UIColor colorWithRed:250.0/250.0 green:250.0/250.0 blue:250.0/250.0 alpha:1.0];
    
    lbl_Sumry_Deduction_Score.font=[UIFont fontWithName:@"Enigmatic" size:17];
    lbl_Sumry_Deduction_Score.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];

    lbl_Sumry_Total_Score_head.font=[UIFont fontWithName:@"Enigmatic" size:17];
    lbl_Sumry_Total_Score_head.textColor=[UIColor colorWithRed:250.0/250.0 green:250.0/250.0 blue:250.0/250.0 alpha:1.0];
    lbl_Sumry_Total_Score.font=[UIFont fontWithName:@"Enigmatic" size:17];
    lbl_Sumry_Total_Score.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
    
    lbl_Sumry_Team_Name_head.font=[UIFont fontWithName:@"Enigmatic" size:17];
    lbl_Sumry_Team_Name_head.textColor=[UIColor colorWithRed:250.0/250.0 green:250.0/250.0 blue:250.0/250.0 alpha:1.0];
    
    lbl_Sumry_Team_Name.font=[UIFont fontWithName:@"Enigmatic" size:17];
    lbl_Sumry_Team_Name.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
    
      
    
    
    
    // Do any additional setup after loading the view from its nib.
    [self showBusyView];
    
[ServiceEngine CallService].webServiceDelegate=self;
    
[[ServiceEngine CallService] PostService:@"http://54.191.2.63/spiritcentral/webservices_dev/getwbs_performancetype.php" body:@"json=[{\"performance_id\":\"1\"}]" context:@"performancType_build" authorization:@""];
    
[[ServiceEngine CallService] PostService:@"http://54.191.2.63/spiritcentral/webservices_dev/getwbs_performancetype.php" body:@"json=[{\"performance_id\":\"2\"}]" context:@"performancType_tum" authorization:@""];
    
[[ServiceEngine CallService] PostService:@"http://54.191.2.63/spiritcentral/webservices_dev/getwbs_performancetype.php" body:@"json=[{\"performance_id\":\"3\"}]" context:@"performancType_cho" authorization:@""];
    
[[ServiceEngine CallService] PostService:@"http://54.191.2.63/spiritcentral/webservices_dev/getwbs_performancetype.php" body:@"json=[{\"performance_id\":\"4\"}]" context:@"performancType_deduct" authorization:@""];


}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    if([[dict_Summary allKeys]count]==0)
    {
    
    }
    else
    {
        return 4;//[[dict_Summary allKeys]count]-1;
    }
}

-(IBAction)Editbtn_clicked:(id)sender
{
    //Singleton *s=[Singleton getObject];
    
    if (Editflag==YES)
    {
        
        [btn_Edit setTitle:@"Done" forState:UIControlStateNormal];
        Editflag=NO;
        
    }
    else
    {
        [btn_Edit setTitle:@"Edit Score" forState:UIControlStateNormal];
        Editflag=YES;
        
    }
    
    if ([[btn_Edit titleLabel].text isEqualToString:@"Edit Score"])
        
    {
        int a=team_Tableview.contentOffset.y;
        NSLog(@"%d",a);
        
        if (Editflag==YES && team_Tableview.contentOffset.y>1200)
        {
            [team_Tableview setContentOffset:CGPointZero];
        }
        
        [btn_Edit setTitle:@"Done" forState:UIControlStateNormal];
        [team_Tableview reloadData];
    }
    
    else if ([[btn_Edit titleLabel].text isEqualToString:@"Done"])
    {
        if (Editflag==YES && team_Tableview.contentOffset.y>1200)
        {
            [team_Tableview setContentOffset:CGPointZero];
        }
        
        [btn_Edit setTitle:@"Edit Score" forState:UIControlStateNormal];
        [team_Tableview reloadData];
        
        //api call for submit edit score.
        
       [self showBusyView];
        CheckWebService=@"SaveEdit_buildingSkills";
        Singleton *st=[Singleton getObject];
        
        NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
        
        [dct setObject:[st event_ID] forKey:@"event_id"];
        [dct setObject:[st loginUserID] forKey:@"commented_by"];
        [dct setObject:[st team_id] forKey:@"team_id"];
        [dct setObject:@"1" forKey:@"perf_id"];
//        [dct setObject:[st lbl_Division] forKey:@"division"];
//        [dct setObject:[st lbl_Label] forKey:@"level"];
        [dct setObject:[st division_id]forKey:@"division"];
        [dct setObject:[st level_id_new] forKey:@"level"];
        [dct setObject:[lbl_Sumry_Total_Score text] forKey:@"total_score"];
        [dct setObject:@"0" forKey:@"team_perf_skill"];

        NSMutableDictionary *comments_DictID=[[NSMutableDictionary alloc]init];
        
       //NSMutableArray *tempAray=[[[[dict_Summary objectForKey:@"BUILDING SKILLS"] objectForKey:@"comments"] allKeys] mutableCopy];
        
        NSArray *tempAray=keyOrder_build;
        
        NSMutableArray *tempScoreAray=[[NSMutableArray alloc]init];
        int k=0;
        checkEmptyCount=0;
        
        if ([[[dict_Summary objectForKey:@"BUILDING SKILLS"] objectForKey:@"have_comments"]  isEqualToString:@"No"])
        {
            [self saveEditScore_tumb];

        }
        else
        {
            
            for (int i=0; i<[[[[dict_Summary objectForKey:@"BUILDING SKILLS"] objectForKey:@"comments"] allKeys] count]; i++)
            {
                
                NSMutableDictionary *tempDict=[[NSMutableDictionary alloc]init];
                tempDict=[[[[dict_Summary objectForKey:@"BUILDING SKILLS"]objectForKey:@"comments"]objectForKey:[keyOrder_build objectAtIndex:i]] mutableCopy];
                
                [tempDict removeObjectForKey:@"comment"];
                
                NSMutableDictionary *tempDict_title=[[NSMutableDictionary alloc]init];
                
                tempDict_title=[[screenTypeDict_build objectForKey:[keyOrder_build objectAtIndex:i]] mutableCopy];
                
                [tempDict_title removeObjectForKey:@"max_score"];
                
                NSMutableArray *tempAray1=[[NSMutableArray alloc]init];
                
                NSArray *ar_title=[[tempDict_title allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
                
                for (int i=0; i<[ar_title count]; i++)
                {
                    [tempAray1 addObject:[tempDict_title objectForKey:[ar_title objectAtIndex:i]]];
                }
                
                
                
                NSMutableDictionary *comentTempDict=[[NSMutableDictionary alloc]init];
                
                NSString *str=[[[[dict_Summary objectForKey:@"BUILDING SKILLS"]objectForKey:@"comments"]objectForKey:[keyOrder_build objectAtIndex:i]] objectForKey:@"comment"];
                
                
                NSArray* foo = [str componentsSeparatedByString: @"|"];
                [foo componentsJoinedByString:@"\n"];
                [comentTempDict setObject:[tempAray objectAtIndex:i] forKey:@"title"];
                //[comentTempDict setObject:[NSString stringWithFormat:@"%@",foo] forKey:@"comments"];
                [comentTempDict setObject:foo forKey:@"comments"];
                
                [comments_DictID setValue:comentTempDict forKey:[NSString stringWithFormat:@"%d",i]];
             //   [ComntDict setValue:comentTempDict forKey:[NSString stringWithFormat:@"%d",i]];

                
                for (int p=0; p<[tempAray1 count]; p++)
                {
                    if ([[[finalValDict objectForKey:[NSString stringWithFormat:@"%d",i]] objectAtIndex:p]isEqualToString:@""])
                    {
                        [tempScoreAray insertObject:[tempDict objectForKey:[tempAray1 objectAtIndex:p]] atIndex:k];
                        checkEmptyCount++;
                    }
                    else
                    {
                        [tempScoreAray insertObject:[[finalValDict objectForKey:[NSString stringWithFormat:@"%d",i]] objectAtIndex:p] atIndex:k];
                    }
                    
                    
                    k++;
                    
                    
                }
            }
            
          //  [dct setObject:ComntDict forKey:@"comments"];
            if (comment1==YES)
            {
                NSLog(@"nothing");
                
            }else
            {
                [dct setObject:comments_DictID forKey:@"comments"];
            }

            
            NSMutableDictionary *scoreTempDict=[[NSMutableDictionary alloc]init];
            
            if ([RatingTile_IDArray_build count]==checkEmptyCount)
            {
                [self saveEditScore_tumb];
            }
            else
            {
                for (int i=0; i<[tempScoreAray count]; i++)
                {
                    
                    NSMutableDictionary *temp=[[NSMutableDictionary alloc]init];
                    [temp setObject:[tempScoreAray objectAtIndex:i] forKey:@"score"];
                    [temp setObject:[RatingTile_IDArray_build objectAtIndex:i] forKey:@"title_id"];
                    
                    [scoreTempDict setObject:temp forKey:[NSString stringWithFormat:@"%@",[RatingTile_IDArray_build objectAtIndex:i]]];
                    
                }
                
                [dct setObject:scoreTempDict forKey:@"scores"];
                NSLog(@"dcttt_AllValues===%@",dct);
                
                NSString *jsonstring1=[dct JSONRepresentation];
                
                NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring1];
                
                //NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_saveperformance.php",BASEURL];//getwbs_saveperformance_kishore.php
                
                NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_saveperformance_kishore.php",BASEURL];
                
                
                m_pWebService			= [[WebService alloc] initWebService:l_pURL];
                m_pWebService.mDelegate		= self;
                [m_pWebService  sendHTTPPost:post1];
            }

            
        }
    
        
    }
 
    
}

-(void)saveEditScore_tumb
{
    Singleton *s=[Singleton getObject];

  //  [self showBusyView];
    CheckWebService=@"SaveEdit_Tumbling";
    
    NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
    
    [dct setObject:[s event_ID] forKey:@"event_id"];
    [dct setObject:[s loginUserID] forKey:@"commented_by"];
    [dct setObject:[s team_id] forKey:@"team_id"];
    [dct setObject:@"2" forKey:@"perf_id"];
//    [dct setObject:[s lbl_Division] forKey:@"division"];
//    [dct setObject:[s lbl_Label] forKey:@"level"];
    
    
    [dct setObject:[s division_id]forKey:@"division"];
    [dct setObject:[s level_id_new] forKey:@"level"];
    [dct setObject:[lbl_Sumry_Total_Score text] forKey:@"total_score"];
    [dct setObject:@"0" forKey:@"team_perf_skill"];
    
    NSMutableDictionary *comments_DictID=[[NSMutableDictionary alloc]init];
    
    //NSMutableArray *tempAray=[[[[dict_Summary objectForKey:@"TUMBLING/JUMPS"] objectForKey:@"comments"] allKeys] mutableCopy];
    
    NSArray *tempAray=keyOrder_tumb;
    
    NSMutableArray *tempScoreAray=[[NSMutableArray alloc]init];
    int k=0;
    
     if ([[[dict_Summary objectForKey:@"TUMBLING/JUMPS"] objectForKey:@"have_comments"]  isEqualToString:@"No"])
     {
        [self saveEditScore_choreo];
        
     }
     else
     {
         checkEmptyCount=0;

         
         for (int i=0; i<[[[[dict_Summary objectForKey:@"TUMBLING/JUMPS"] objectForKey:@"comments"] allKeys] count]; i++)
         {
             
             NSMutableDictionary *tempDict=[[NSMutableDictionary alloc]init];
             tempDict=[[[[dict_Summary objectForKey:@"TUMBLING/JUMPS"]objectForKey:@"comments"]objectForKey:[keyOrder_tumb objectAtIndex:i]] mutableCopy];
             
             [tempDict removeObjectForKey:@"comment"];
             
             
             
             NSMutableDictionary *tempDict_title=[[NSMutableDictionary alloc]init];
             
             tempDict_title=[[screenTypeDict_tum objectForKey:[keyOrder_tumb objectAtIndex:i]] mutableCopy];
             
             [tempDict_title removeObjectForKey:@"max_score"];
             
             NSMutableArray *tempAray1=[[NSMutableArray alloc]init];
             
             NSArray *ar_title=[[tempDict_title allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
             
             for (int i=0; i<[ar_title count]; i++)
             {
                 [tempAray1 addObject:[tempDict_title objectForKey:[ar_title objectAtIndex:i]]];
             }
             
             
             
             NSMutableDictionary *comentTempDict=[[NSMutableDictionary alloc]init];
             
             NSString *str=[[[[dict_Summary objectForKey:@"TUMBLING/JUMPS"]objectForKey:@"comments"]objectForKey:[keyOrder_tumb objectAtIndex:i]] objectForKey:@"comment"];
             
             
             NSArray* foo = [str componentsSeparatedByString: @"|"];
             [foo componentsJoinedByString:@"\n"];
             [comentTempDict setObject:[tempAray objectAtIndex:i] forKey:@"title"];
             //[comentTempDict setObject:[NSString stringWithFormat:@"%@",foo] forKey:@"comments"];
             [comentTempDict setObject:foo forKey:@"comments"];
             
             
             [comments_DictID setValue:comentTempDict forKey:[NSString stringWithFormat:@"%d",i]];
             
             for (int p=0; p<[tempAray1 count]; p++)
             {
                 if ([[[finalValDict_tum objectForKey:[NSString stringWithFormat:@"%d",i]] objectAtIndex:p]isEqualToString:@""])
                 {
                     [tempScoreAray insertObject:[tempDict objectForKey:[tempAray1 objectAtIndex:p]] atIndex:k];
                     checkEmptyCount++;
                 }
                 else
                 {
                     [tempScoreAray insertObject:[[finalValDict_tum objectForKey:[NSString stringWithFormat:@"%d",i]] objectAtIndex:p] atIndex:k];
                 }
                 
                 
                 k++;
                 
                 
             }
         }
         if (comment1==YES)
         {
             NSLog(@"nothing");
         }else
         {
             [dct setObject:comments_DictID forKey:@"comments"];
         }

//         [dct setObject:comments_DictID forKey:@"comments"];
         
         NSMutableDictionary *scoreTempDict=[[NSMutableDictionary alloc]init];
         
         
         if ([RatingTile_IDArray_tumb count]==checkEmptyCount)
         {
            [self saveEditScore_choreo];
            
         }
         else
         {
             
             for (int i=0; i<[tempScoreAray count]; i++)
             {
                 
                 NSMutableDictionary *temp=[[NSMutableDictionary alloc]init];
                 [temp setObject:[tempScoreAray objectAtIndex:i] forKey:@"score"];
                 [temp setObject:[RatingTile_IDArray_tumb objectAtIndex:i] forKey:@"title_id"];
                 
                 [scoreTempDict setObject:temp forKey:[NSString stringWithFormat:@"%@",[RatingTile_IDArray_tumb objectAtIndex:i]]];
                 
                 
             }
             
             
             [dct setObject:scoreTempDict forKey:@"scores"];
             NSLog(@"dcttt_AllValues===%@",dct);
             
             NSString *jsonstring1=[dct JSONRepresentation];
             
             NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring1];
             
             //NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_saveperformance.php",BASEURL];//getwbs_saveperformance_kishore.php
             
             NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_saveperformance_kishore.php",BASEURL];
             
             
             m_pWebService			= [[WebService alloc] initWebService:l_pURL];
             m_pWebService.mDelegate		= self;
             [m_pWebService  sendHTTPPost:post1];
             
         }

         
         
     }
    
    
    
    
}


-(void)saveEditScore_choreo
{
    
    Singleton *s=[Singleton getObject];
    
    //[self showBusyView];
    CheckWebService=@"SaveEdit_Choreoghaphy";
    
    NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
    
    [dct setObject:[s event_ID] forKey:@"event_id"];
    [dct setObject:[s loginUserID] forKey:@"commented_by"];
    [dct setObject:[s team_id] forKey:@"team_id"];
    [dct setObject:@"3" forKey:@"perf_id"];
//    [dct setObject:[s lbl_Division] forKey:@"division"];
//    [dct setObject:[s lbl_Label] forKey:@"level"];
    
    
    [dct setObject:[s division_id]forKey:@"division"];
    [dct setObject:[s level_id_new] forKey:@"level"];
    [dct setObject:[lbl_Sumry_Total_Score text] forKey:@"total_score"];
    [dct setObject:@"0" forKey:@"team_perf_skill"];
    
    NSMutableDictionary *comments_DictID=[[NSMutableDictionary alloc]init];
    
    //NSMutableArray *tempAray=[[[[dict_Summary objectForKey:@"CHOREOGRAPHY"] objectForKey:@"comments"] allKeys] mutableCopy];
    
    NSArray *tempAray=keyOrder_cho;
    
    NSMutableArray *tempScoreAray=[[NSMutableArray alloc]init];
    int k=0;
    
    if ([[[dict_Summary objectForKey:@"CHOREOGRAPHY"] objectForKey:@"have_comments"]  isEqualToString:@"No"])
    {
        
     //   [self saveEditScore_ded];
//        [self hideBusyView];
//        
       
//        UIAlertView *savePerformance_Alert=[[UIAlertView alloc]initWithTitle:@"Data Saved Successfully" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil, nil];
//        [savePerformance_Alert show];
        
        
        
        NSString *jsonstring1=[dct JSONRepresentation];
        
        NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring1];
        
        //NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_saveperformance.php",BASEURL];//getwbs_saveperformance_kishore.php
        
        NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_saveperformance_kishore.php",BASEURL];
        
        
        m_pWebService			= [[WebService alloc] initWebService:l_pURL];
        m_pWebService.mDelegate		= self;
        [m_pWebService  sendHTTPPost:post1];

    }
    else
    {
        checkEmptyCount=0;
        
        for (int i=0; i<[[[[dict_Summary objectForKey:@"CHOREOGRAPHY"] objectForKey:@"comments"] allKeys] count]; i++)
        {
            
            NSMutableDictionary *tempDict=[[NSMutableDictionary alloc]init];
            tempDict=[[[[dict_Summary objectForKey:@"CHOREOGRAPHY"]objectForKey:@"comments"]objectForKey:[keyOrder_cho objectAtIndex:i]] mutableCopy];
            
            [tempDict removeObjectForKey:@"comment"];
            
            
            
            NSMutableDictionary *tempDict_title=[[NSMutableDictionary alloc]init];
            
            tempDict_title=[[screenTypeDict_cho objectForKey:[keyOrder_cho objectAtIndex:i]] mutableCopy];
            
            [tempDict_title removeObjectForKey:@"max_score"];
            
            NSMutableArray *tempAray1=[[NSMutableArray alloc]init];
            
            NSArray *ar_title=[[tempDict_title allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
            
            for (int i=0; i<[ar_title count]; i++)
            {
                [tempAray1 addObject:[tempDict_title objectForKey:[ar_title objectAtIndex:i]]];
            }
            
            
            
            NSMutableDictionary *comentTempDict=[[NSMutableDictionary alloc]init];
            
            NSString *str=[[[[dict_Summary objectForKey:@"CHOREOGRAPHY"]objectForKey:@"comments"]objectForKey:[keyOrder_cho objectAtIndex:i]] objectForKey:@"comment"];
            
            
            NSArray* foo = [str componentsSeparatedByString: @"|"];
            [foo componentsJoinedByString:@"\n"];
            [comentTempDict setObject:[tempAray objectAtIndex:i] forKey:@"title"];
            //[comentTempDict setObject:[NSString stringWithFormat:@"%@",foo] forKey:@"comments"];
            [comentTempDict setObject:foo forKey:@"comments"];
            
            [comments_DictID setValue:comentTempDict forKey:[NSString stringWithFormat:@"%d",i]];
            
            for (int p=0; p<[tempAray1 count]; p++)
            {
                if ([[[finalValDict_cho objectForKey:[NSString stringWithFormat:@"%d",i]] objectAtIndex:p]isEqualToString:@""])
                {
                    [tempScoreAray insertObject:[tempDict objectForKey:[tempAray1 objectAtIndex:p]] atIndex:k];
                    checkEmptyCount++;
                }
                else
                {
                    [tempScoreAray insertObject:[[finalValDict_cho objectForKey:[NSString stringWithFormat:@"%d",i]] objectAtIndex:p] atIndex:k];
                }
                
                k++;
                
                
            }
        }
        if (comment1==YES)
        {
            NSLog(@"nothing");
        }else
        {
            [dct setObject:comments_DictID forKey:@"comments"];
        }

//        [dct setObject:comments_DictID forKey:@"comments"];
        
        NSMutableDictionary *scoreTempDict=[[NSMutableDictionary alloc]init];
        
        
        if ([RatingTile_IDArray_cho count]==checkEmptyCount)
        {
            //[self saveEditScore_choreo];
          //  [self hideBusyView];

           
            
//            UIAlertView *savePerformance_Alert=[[UIAlertView alloc]initWithTitle:@"Data Saved Successfully" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil, nil];
//            [savePerformance_Alert show];
            
            
            NSString *jsonstring1=[dct JSONRepresentation];
            
            NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring1];
            
            //NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_saveperformance.php",BASEURL];//getwbs_saveperformance_kishore.php
            
            NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_saveperformance_kishore.php",BASEURL];
            
            
            m_pWebService			= [[WebService alloc] initWebService:l_pURL];
            m_pWebService.mDelegate		= self;
            [m_pWebService  sendHTTPPost:post1];
        }
        else
        {
            for (int i=0; i<[tempScoreAray count]; i++)
            {
                
                NSMutableDictionary *temp=[[NSMutableDictionary alloc]init];
                [temp setObject:[tempScoreAray objectAtIndex:i] forKey:@"score"];
                [temp setObject:[RatingTile_IDArray_cho objectAtIndex:i] forKey:@"title_id"];
                
                [scoreTempDict setObject:temp forKey:[NSString stringWithFormat:@"%@",[RatingTile_IDArray_cho objectAtIndex:i]]];
                
                
            }
            
            
            
            [dct setObject:scoreTempDict forKey:@"scores"];
            NSLog(@"dcttt_AllValues===%@",dct);
            
            NSString *jsonstring1=[dct JSONRepresentation];
            
            NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring1];
            
            //NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_saveperformance.php",BASEURL];//getwbs_saveperformance_kishore.php
            
            NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_saveperformance_kishore.php",BASEURL];
            
            
            m_pWebService			= [[WebService alloc] initWebService:l_pURL];
            m_pWebService.mDelegate		= self;
            [m_pWebService  sendHTTPPost:post1];
            
        }

        
    }
  
    
}

-(void)saveEditScore_ded
{
    //api call for submit edit score.
    
    CheckWebService=@"saveEditScore_deduction";
    Singleton *st=[Singleton getObject];
    
    NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
    
    [dct setObject:[st event_ID] forKey:@"event_id"];
    [dct setObject:[st loginUserID] forKey:@"commented_by"];
    [dct setObject:[st team_id] forKey:@"team_id"];
    [dct setObject:@"1" forKey:@"perf_id"];
    [dct setObject:[st lbl_Division] forKey:@"division"];
    [dct setObject:[st lbl_Label] forKey:@"level"];
    [dct setObject:[lbl_Sumry_Total_Score text] forKey:@"total_score"];
    [dct setObject:@"0" forKey:@"team_perf_skill"];
    
    
    //NSMutableArray *tempAray=[[[[dict_Summary objectForKey:@"BUILDING SKILLS"] objectForKey:@"comments"] allKeys] mutableCopy];
    
    NSArray *tempAray=keyOrder_deduct;
    
    NSMutableArray *tempScoreAray=[[NSMutableArray alloc]init];
    
    scoreTempDict=[[NSMutableDictionary alloc]init];
    
    int k=0;
    checkEmptyCount=0;
    
    
    
    for (int i=0; i<[ar_TimeStamp count]; i++)
    {
        
        NSMutableDictionary *tempDict=[[NSMutableDictionary alloc]init];
        
        
        tempAray=[[ar_TimeStamp objectAtIndex:i]objectForKey:@"scores"];
        
        for (int p=0; p<[tempAray count]; p++)
        {
            if ([[[finalValDict_ded objectForKey:[NSString stringWithFormat:@"%d",i]] objectAtIndex:p]isEqualToString:@""])
            {
                
                
                tempDict= [[tempAray objectAtIndex:p]objectForKey:@"sum"];
                
                [tempScoreAray insertObject:tempDict atIndex:k];
                
                checkEmptyCount++;
                
                
                
            }
            
            
            else
                
            {
                [tempScoreAray insertObject:[[finalValDict_ded objectForKey:[NSString stringWithFormat:@"%d",i]] objectAtIndex:p] atIndex:k];
            }
            
            k++;
            
            
            
        }
        
        
    }
    
    
    for (int i=0; i<[tempScoreAray count]; i++)
    {
        
        NSMutableDictionary *temp=[[NSMutableDictionary alloc]init];
        [temp setObject:[tempScoreAray objectAtIndex:i] forKey:@"score"];
        [temp setObject:[RatingTile_IDArray_ded objectAtIndex:i] forKey:@"title_id"];
        
        [scoreTempDict setObject:temp forKey:[NSString stringWithFormat:@"%@",[RatingTile_IDArray_ded objectAtIndex:i]]];
        
    }
    
    [dct setObject:scoreTempDict forKey:@"scores"];
    NSLog(@"dcttt_AllValues===%@",dct);
    
    NSString *jsonstring1=[dct JSONRepresentation];
    
    NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring1];
    
    //  getwbs_savededuction
    
    
    NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_savededuction.php",BASEURL];
    
    
    m_pWebService			= [[WebService alloc] initWebService:l_pURL];
    m_pWebService.mDelegate		= self;
    [m_pWebService  sendHTTPPost:post1];
    
    
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
  
    
       if(section==0)
       {
           if([[[dict_Summary objectForKey:@"BUILDING SKILLS"]objectForKey:@"have_comments"]isEqualToString:@"Yes"])
               
           {
               
               return  [[[[dict_Summary objectForKey:@"BUILDING SKILLS"]objectForKey:@"comments"]allKeys]count];
           }
           else
           {
           
               return 4;
           
           }
           
       }
       else if(section==1)
       {
           if([[[dict_Summary objectForKey:@"TUMBLING/JUMPS"]objectForKey:@"have_comments"]isEqualToString:@"Yes"])
               
           {
               
           return  [[[[dict_Summary objectForKey:@"TUMBLING/JUMPS"]objectForKey:@"comments"]allKeys]count];
           }
           else
           {
           
               return 3;
           }
           
       }
       else  if(section==2)
       {
           
           if([[[dict_Summary objectForKey:@"CHOREOGRAPHY"]objectForKey:@"have_comments"]isEqualToString:@"Yes"])
               
           {
               

           return  [[[[dict_Summary objectForKey:@"CHOREOGRAPHY"]objectForKey:@"comments"]allKeys]count];
           }
           else
           {
               return 3;
               
           }
           
       }
       
       else if(section==3)
       {
           NSLog(@"");
           
           if ([ar_TimeStamp count]==0)
           {
               return 5;
           }
           else
               return [ar_TimeStamp count];
           
         //  int limits = MAX([ar_TimeStamp count],[[[[dict_Summary objectForKey:@"DEDUCTION/CUMULATIVE"]objectForKey:@"comments"]allKeys]count]);
           
          // return  limits;
           
           
           /*
           if([[[dict_Summary objectForKey:@"DEDUCTION/CUMULATIVE"]objectForKey:@"have_comments"]isEqualToString:@"Yes"])
            {
               

return  [[[[dict_Summary objectForKey:@"DEDUCTION/CUMULATIVE"]objectForKey:@"comments"]allKeys]count];
           }
           else
           {
               return 1;
           
           
           }
       */
       
       }

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *cellIdentifier=@"Cell";
  TeamSummaryCell   *team_Cell=    [tableView dequeueReusableCellWithIdentifier:cellIdentifier];


    if(team_Cell==nil)
    {
 
        NSArray *ar=[[NSBundle mainBundle]loadNibNamed:@"TeamSummaryCell" owner:self options:nil];
        
        team_Cell=[ar objectAtIndex:0];
    }
    [team_Cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [team_Cell.txtview_Comments setEditable:NO];
    
    
    team_Cell.lbl_Comments.frame=CGRectMake(297, 11, 154, 21);
    team_Cell.lbl_Timestamp.font=[UIFont fontWithName:@"Enigmatic" size:18];
    team_Cell.lbl_Timestamp.textColor=[UIColor colorWithRed:250.0/250.0 green:250.0/250.0 blue:250.0/250.0 alpha:1.0];
    team_Cell.lbl_Comments.font=[UIFont fontWithName:@"Enigmatic" size:18];
    team_Cell.lbl_Comments.textColor=[UIColor colorWithRed:250.0/250.0 green:250.0/250.0 blue:250.0/250.0 alpha:1.0];

    team_Cell.txtview_Comments.frame=CGRectMake(250, 45, 250, 110);
    team_Cell.txtview_Comments.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];

    // edit element
 //    team_Cell.txtview_Comments.frame=CGRectMake(250, 45, 250, 72);
 //   team_Cell.lbl_Comments.frame=CGRectMake(250+20, 11, 186, 21);
    
    team_Cell.lbl_score.font=[UIFont fontWithName:@"Enigmatic" size:18];
    team_Cell.lbl_score.textColor=[UIColor colorWithRed:250.0/250.0 green:250.0/250.0 blue:250.0/250.0 alpha:1.0];
    
    team_Cell.lbl_HeadingEdit.font=[UIFont fontWithName:@"Enigmatic" size:18];
    team_Cell.lbl_HeadingEdit.textColor=[UIColor colorWithRed:250.0/250.0 green:250.0/250.0 blue:250.0/250.0 alpha:1.0];
    
    team_Cell.lbl_finalScore.font=[UIFont fontWithName:@"Enigmatic" size:18];
    team_Cell.lbl_finalScore.textColor=[UIColor colorWithRed:250.0/250.0 green:250.0/250.0 blue:250.0/250.0 alpha:1.0];
    
    team_Cell.lbl_EditComment.font=[UIFont fontWithName:@"Enigmatic" size:18];
    team_Cell.lbl_EditComment.textColor=[UIColor colorWithRed:250.0/250.0 green:250.0/250.0 blue:250.0/250.0 alpha:1.0];
    
    team_Cell.txtview_EditComments.delegate=self;
    team_Cell.txtview_EditComments.font=[UIFont fontWithName:@"Enigmatic" size:16];
    //team_Cell.txtview_EditComments.textColor=[UIColor colorWithRed:10/250.0 green:40/250.0 blue:150/250.0 alpha:1.0];
    team_Cell.txtview_EditComments.tag=indexPath.row;
    

    
    if(floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
    {
        
        //[[team_Cell img_Div_Line]setFrame:CGRectMake(0, 108,1024 , 1)];
        team_Cell.img_Div_Line.hidden=NO;
        
    }
    else
    {
        team_Cell.img_Div_Line.hidden=YES;
       
        team_Cell.img_header_background.frame=CGRectMake(0, 0,906 , 44);
        [[team_Cell contentView]addSubview:team_Cell.img_header_background];
        
        team_Cell.lbl_Subcateg.frame=CGRectMake(15, 11,218 , 21);
        [[team_Cell contentView]addSubview:team_Cell.lbl_Subcateg];
        
        team_Cell.lbl_Timestamp.frame=CGRectMake(284, 11,186 , 21);
        [[team_Cell contentView]addSubview:team_Cell.lbl_Timestamp];
        
        team_Cell.lbl_Comments.frame=CGRectMake(503, 11,154 , 21);
        [[team_Cell contentView]addSubview:team_Cell.lbl_Comments];

        
        
        //[[team_Cell img_Div_Line]setFrame:CGRectMake(0, 108,906 , 1)];
    }

    
    team_Cell.lbl_Subcateg.font=[UIFont fontWithName:@"Enigmatic" size:16];
    team_Cell.txtview_Comments.font=[UIFont fontWithName:@"Enigmatic" size:15];
    
    NSMutableArray *txtTempAray=[[NSMutableArray alloc]init];
    NSMutableArray *addTempAray=[[NSMutableArray alloc]init];
    NSMutableArray *subTempAray=[[NSMutableArray alloc]init];
    
    
    

    
    
    
    if(indexPath.section==0)
    {
        team_Cell.lbl_Timestamp.hidden=YES;
        
        if([[[dict_Summary objectForKey:@"BUILDING SKILLS"]objectForKey:@"have_comments"]isEqualToString:@"Yes"])
            
        {
            [team_Cell.txtview_EditComments setAccessibilityHint:@"section 0"];
            team_Cell.txtview_EditComments.tag=indexPath.row;
            team_Cell.txtview_EditComments.text=[NSString stringWithFormat:@"%@",[ComntDict objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]];
            //
       //team_Cell.lbl_Subcateg.text=  [[[[dict_Summary objectForKey:@"BUILDING SKILLS"]objectForKey:@"comments"]allKeys]objectAtIndex:indexPath.row];
            
            team_Cell.lbl_Subcateg.text= [keyOrder_build objectAtIndex:indexPath.row];

        
        //NSString *str=[[[[dict_Summary objectForKey:@"BUILDING SKILLS"]objectForKey:@"comments"]objectForKey:[[[[dict_Summary objectForKey:@"BUILDING SKILLS"]objectForKey:@"comments"]allKeys]objectAtIndex:indexPath.row]] objectForKey:@"comment"];
            
        NSString *str=[[[[dict_Summary objectForKey:@"BUILDING SKILLS"]objectForKey:@"comments"]objectForKey:[keyOrder_build objectAtIndex:indexPath.row]] objectForKey:@"comment"];
        
        
        NSArray* foo = [str componentsSeparatedByString: @"|"];
        team_Cell.txtview_Comments.text=[foo componentsJoinedByString:@"\n"];
        
            // edit fun
           
            NSMutableDictionary *tempDict=[[NSMutableDictionary alloc]init];
            
            tempDict=[[[[dict_Summary objectForKey:@"BUILDING SKILLS"]objectForKey:@"comments"]objectForKey:[keyOrder_build objectAtIndex:indexPath.row]] mutableCopy];
            [tempDict removeObjectForKey:@"comment"];
            
            NSMutableDictionary *tempDict_title=[[NSMutableDictionary alloc]init];
            
            tempDict_title=[[screenTypeDict_build objectForKey:[keyOrder_build objectAtIndex:indexPath.row]] mutableCopy];
            
            [tempDict_title removeObjectForKey:@"max_score"];
            
            NSMutableArray *tempAray=[[NSMutableArray alloc]init];
            
            NSArray *ar_title=[[tempDict_title allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
            
        
            
            
            for (int i=0; i<[ar_title count]; i++)
            {
                [tempAray addObject:[tempDict_title objectForKey:[ar_title objectAtIndex:i]]];
                
                UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(193, 55+i*30, 60, 25)];
                
                lbl.text=[NSString stringWithFormat:@"%.1f",[[tempDict objectForKey:[tempAray objectAtIndex:i]] floatValue]];
                
                lbl.font=[UIFont fontWithName:@"Enigmatic" size:16];
                lbl.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
                
                [[team_Cell contentView]addSubview:lbl];
                
                //NSArray *tempar=[[[dict_Newsumery objectForKey:@"BUILDING SKILLS"]objectForKey:@"comments"]allKeys];
                UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(15, 55+i*30, 150, 25)];
                lbl1.text=[tempAray objectAtIndex:i];
                //lbl1.text=@"Technique";
                lbl1.textAlignment=NSTextAlignmentCenter;
                lbl1.font=[UIFont fontWithName:@"Enigmatic" size:16];
                lbl1.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
                
                [[team_Cell contentView]addSubview:lbl1];
                ///edit button
                
                UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
                [btn setFrame:CGRectMake(535, 55+i*30, 25, 25)];
                [btn setBackgroundImage:[UIImage imageNamed:@"plus@2x.png"] forState:UIControlStateNormal];
                [btn setTag:indexPath.row];
                [btn addTarget:self action:@selector(addbtnclicked:) forControlEvents:UIControlEventTouchUpInside];
                [addTempAray insertObject:btn atIndex:i];//store
                [[team_Cell contentView]addSubview:btn];
                
                
                UILabel *lbl_editScore=[[UILabel alloc]initWithFrame:CGRectMake(570, 55+i*30, 38, 25)];
                lbl_editScore.text=[[txtValDict objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]] objectAtIndex:i];
                
                lbl_editScore.font=[UIFont fontWithName:@"Enigmatic" size:15];
                //lbl_editScore.textColor=[UIColor redColor];
                [[team_Cell contentView]addSubview:lbl_editScore];
                
                UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(565, 55+i*30, 40, 25)];
                img.image=[UIImage imageNamed:@"score-box2.png"];
                [[team_Cell contentView]addSubview:img];
                
                UITextField *lbls=[[UITextField alloc]initWithFrame:CGRectMake(565, 55+i*30, 40, 25)];
                lbls.font=[UIFont fontWithName:@"Enigmatic" size:13];
                //lbls.textColor=[UIColor colorWithRed:200.0/250.0 green:10/250.0 blue:10/250.0 alpha:1.0];
                lbls.tag=indexPath.row;
                lbls.keyboardType=UIKeyboardTypeNumberPad;
                NSString *str3=[[txtValDict objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]objectAtIndex:i];
                
                if ([str3 isEqualToString:@"-0.0"])
                {
                    NSString *str4=[str3 stringByReplacingOccurrencesOfString:@"-" withString:@""];
                    lbls.text=str4;
                    
                }else
                {
                    lbls.text=str3;
                    
                }
                

                lbls.delegate=self;
                [lbls setUserInteractionEnabled:NO];
                [lbls setTextAlignment:NSTextAlignmentCenter];
                [lbls setAccessibilityHint:@"section 0"];
                
                [[team_Cell contentView]addSubview:lbls];
                [txtTempAray insertObject:lbls atIndex:i];
                
                
                UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
                [btn1 setFrame:CGRectMake(610, 55+i*30, 25, 25)];
                [btn1 setBackgroundImage:[UIImage imageNamed:@"minus@2x.png"] forState:UIControlStateNormal];
                [btn1 setTag:indexPath.row];
                [btn1 addTarget:self action:@selector(subtbtnclicked:) forControlEvents:UIControlEventTouchUpInside];
                [[team_Cell contentView]addSubview:btn1];
                [subTempAray insertObject:btn1 atIndex:i];
                
                UILabel *lbl_finalScore=[[UILabel alloc]initWithFrame:CGRectMake(695, 55+i*30, 60, 25)];
                lbl_finalScore.font=[UIFont fontWithName:@"Enigmatic" size:16];
                //lbl_finalScore.textColor=[UIColor colorWithRed:10.0/250.0 green:150/250.0 blue:10/250.0 alpha:1.0];
                
                
                NSString *str=[[finalValDict objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]objectAtIndex:i];
                NSString *str1=[str stringByReplacingOccurrencesOfString:@"-" withString:@""];
                
                //lbl_finalScore.text=[[finalValDict objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]objectAtIndex:i];
                lbl_finalScore.text=str1;
                [[team_Cell contentView]addSubview:lbl_finalScore];
                
                
                if (Editflag==YES)
                {
                    //Editflag=NO;
                    btn.hidden=NO;
                    btn1.hidden=NO;
                    lbls.hidden=NO;
                    img.hidden=NO;
                    lbl_finalScore.hidden=NO;
                    team_Cell.lbl_HeadingEdit.hidden=NO;
                    team_Cell.lbl_finalScore.hidden=NO;
                    team_Cell.lbl_EditComment.hidden=NO;
                    team_Cell.txtview_EditComments.hidden=NO;
                    //team_Cell.txtview_EditComments.backgroundColor=[UIColor colorWithRed:50/250.0 green:40/250.0 blue:120/250.0 alpha:0.2];
                    team_Cell.txtview_EditComments.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"grey_commentbox.png"]];
                    
                    
                    team_Cell.txtview_EditComments.frame=CGRectMake(780, 45, 240, team_Cell.frame.size.height-10);
                    
                    [team_Cell.txtview_EditComments setEditable:YES];
                    if ([team_Cell.txtview_EditComments.text isEqual:@""]||[team_Cell.txtview_EditComments.text isEqualToString:nil])
                    {
                        
                        team_Cell.txtview_EditComments.text=@"Enter Comment";

                    }
                    
                }
                else
                {
                    //Editflag=YES;
                    btn.hidden=YES;
                    btn1.hidden=YES;
                    lbls.hidden=YES;
                    img.hidden=YES;
                    lbl_finalScore.hidden=NO;
                    team_Cell.lbl_HeadingEdit.hidden=NO;
                    team_Cell.lbl_finalScore.hidden=NO;
                    team_Cell.lbl_EditComment.hidden=NO;
                    team_Cell.txtview_EditComments.hidden=NO;
                    [team_Cell.txtview_EditComments setEditable:NO];
                    team_Cell.txtview_EditComments.backgroundColor=[UIColor whiteColor];
                    team_Cell.txtview_EditComments.frame=CGRectMake(780, 45, 240, team_Cell.frame.size.height-10);
                    
                }
                
            }
            
              [txtDict setValue:txtTempAray forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
              [AddBtnDict setObject:addTempAray forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
              [SubBtnDict setObject:subTempAray forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];

            
            
        }
        else
        {
            team_Cell.lbl_Subcateg.text= [keyOrder_build objectAtIndex:indexPath.row];
            
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(150, 80, 200, 25)];
            lbl.text=@"Data Not Available";
            lbl.font=[UIFont fontWithName:@"Enigmatic" size:18];
            lbl.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];

            [[team_Cell contentView]addSubview:lbl];
            
            UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(660, 80, 200, 25)];
            lbl1.text=@"Data Not Available";
            lbl1.font=[UIFont fontWithName:@"Enigmatic" size:18];
            lbl1.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
            
            [[team_Cell contentView]addSubview:lbl1];

        
        }
}
    if(indexPath.section==1)
    {
           team_Cell.lbl_Timestamp.hidden=YES;
        if([[[dict_Summary objectForKey:@"TUMBLING/JUMPS"]objectForKey:@"have_comments"]isEqualToString:@"Yes"])
            
        {
            
            [team_Cell.txtview_EditComments setAccessibilityHint:@"section 1"];
            team_Cell.txtview_EditComments.tag=indexPath.row;
            team_Cell.txtview_EditComments.text=[NSString stringWithFormat:@"%@",[ComntDict_tum objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]];
            
          
         //team_Cell.lbl_Subcateg.text=[[[[dict_Summary objectForKey:@"TUMBLING/JUMPS"]objectForKey:@"comments"]allKeys]objectAtIndex:indexPath.row];
        //NSString *str=[[[[dict_Summary objectForKey:@"TUMBLING/JUMPS"]objectForKey:@"comments"]objectForKey:[[[[dict_Summary objectForKey:@"TUMBLING/JUMPS"]objectForKey:@"comments"]allKeys]objectAtIndex:indexPath.row]] objectForKey:@"comment"];
            
            team_Cell.lbl_Subcateg.text= [keyOrder_tumb objectAtIndex:indexPath.row];
            NSString *str=[[[[dict_Summary objectForKey:@"TUMBLING/JUMPS"]objectForKey:@"comments"]objectForKey:[keyOrder_tumb objectAtIndex:indexPath.row]] objectForKey:@"comment"];
            
        NSArray* foo = [str componentsSeparatedByString: @"|"];
      team_Cell.txtview_Comments.text=[foo componentsJoinedByString:@"\n"];
         
            // edit fun
            
            NSMutableDictionary *tempDict=[[[[dict_Summary objectForKey:@"TUMBLING/JUMPS"]objectForKey:@"comments"]objectForKey:[keyOrder_tumb objectAtIndex:indexPath.row]] mutableCopy];
            
            [tempDict removeObjectForKey:@"comment"];
            
            
            NSMutableDictionary *tempDict_title=[[NSMutableDictionary alloc]init];
            
            tempDict_title=[[screenTypeDict_tum objectForKey:[keyOrder_tumb objectAtIndex:indexPath.row]] mutableCopy];
            
            [tempDict_title removeObjectForKey:@"max_score"];
            
            NSMutableArray *tempAray=[[NSMutableArray alloc]init];
            
            NSArray *ar_title=[[tempDict_title allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
            
            
            
            
            for (int i=0; i<[ar_title count]; i++)
            {
                [tempAray addObject:[tempDict_title objectForKey:[ar_title objectAtIndex:i]]];
                
                UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(193, 55+i*30, 60, 25)];
                
                lbl.text=[NSString stringWithFormat:@"%.1f",[[tempDict objectForKey:[tempAray objectAtIndex:i]] floatValue]];

                lbl.font=[UIFont fontWithName:@"Enigmatic" size:16];
                lbl.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
                
                [[team_Cell contentView]addSubview:lbl];
                
                //NSArray *tempar=[[[dict_Newsumery objectForKey:@"BUILDING SKILLS"]objectForKey:@"comments"]allKeys];
                UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(15, 55+i*30, 150, 25)];
                lbl1.text=[tempAray objectAtIndex:i];
                //lbl1.text=@"Technique";
                 lbl1.textAlignment=NSTextAlignmentCenter;
                lbl1.font=[UIFont fontWithName:@"Enigmatic" size:16];
                lbl1.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
                
                [[team_Cell contentView]addSubview:lbl1];
                ///edit button
                
                UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
                [btn setFrame:CGRectMake(535, 55+i*30, 25, 25)];
                [btn setBackgroundImage:[UIImage imageNamed:@"plus@2x.png"] forState:UIControlStateNormal];
                [btn setTag:indexPath.row];
                [btn addTarget:self action:@selector(addbtnclicked_tum:) forControlEvents:UIControlEventTouchUpInside];
                [addTempAray insertObject:btn atIndex:i];//store
                [[team_Cell contentView]addSubview:btn];
                
                
                UILabel *lbl_editScore=[[UILabel alloc]initWithFrame:CGRectMake(570, 55+i*30, 38, 25)];
                lbl_editScore.text=[[txtValDict_tum objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]objectAtIndex:i];
                
                lbl_editScore.font=[UIFont fontWithName:@"Enigmatic" size:15];
                //lbl_editScore.textColor=[UIColor redColor];
                [[team_Cell contentView]addSubview:lbl_editScore];
                
                UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(565, 55+i*30, 40, 25)];
                img.image=[UIImage imageNamed:@"score-box2.png"];
                [[team_Cell contentView]addSubview:img];
                
                UITextField *lbls=[[UITextField alloc]initWithFrame:CGRectMake(565, 55+i*30, 40, 25)];
                lbls.font=[UIFont fontWithName:@"Enigmatic" size:13];
                //lbls.textColor=[UIColor colorWithRed:200.0/250.0 green:10/250.0 blue:10/250.0 alpha:1.0];
                lbls.tag=indexPath.row;
                lbls.keyboardType=UIKeyboardTypeNumberPad;
                NSString *str3=[[txtValDict_tum objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]objectAtIndex:i];
                
                if ([str3 isEqualToString:@"-0.0"])
                {
                    NSString *str4=[str3 stringByReplacingOccurrencesOfString:@"-" withString:@""];
                    lbls.text=str4;
                    
                }else
                {
                    lbls.text=str3;
                    
                }
                
                lbls.delegate=self;
                [lbls setUserInteractionEnabled:NO];
                [lbls setTextAlignment:NSTextAlignmentCenter];
                [lbls setAccessibilityHint:@"section 1"];
                [[team_Cell contentView]addSubview:lbls];
                [txtTempAray insertObject:lbls atIndex:i];
                
                
                UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
                [btn1 setFrame:CGRectMake(610, 55+i*30, 25, 25)];
                [btn1 setBackgroundImage:[UIImage imageNamed:@"minus@2x.png"] forState:UIControlStateNormal];
                [btn1 setTag:indexPath.row];
                [btn1 addTarget:self action:@selector(subtbtnclicked_tum:) forControlEvents:UIControlEventTouchUpInside];
                [[team_Cell contentView]addSubview:btn1];
                [subTempAray insertObject:btn1 atIndex:i];
                
                UILabel *lbl_finalScore=[[UILabel alloc]initWithFrame:CGRectMake(695, 55+i*30, 60, 25)];
                lbl_finalScore.font=[UIFont fontWithName:@"Enigmatic" size:16];
                //lbl_finalScore.textColor=[UIColor colorWithRed:10.0/250.0 green:150/250.0 blue:10/250.0 alpha:1.0];
                
                NSString *str=[[finalValDict_tum objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]objectAtIndex:i];
                NSString *str1=[str stringByReplacingOccurrencesOfString:@"-" withString:@""];
                
                
                //lbl_finalScore.text=[[finalValDict_tum objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]objectAtIndex:i];
                lbl_finalScore.text=str1;
                [[team_Cell contentView]addSubview:lbl_finalScore];
                
                
                if (Editflag==YES)
                {
                    //Editflag=NO;
                    btn.hidden=NO;
                    btn1.hidden=NO;
                    lbls.hidden=NO;
                    img.hidden=NO;
                    lbl_finalScore.hidden=NO;
                    team_Cell.lbl_HeadingEdit.hidden=NO;
                    team_Cell.lbl_finalScore.hidden=NO;
                    team_Cell.lbl_EditComment.hidden=NO;
                    team_Cell.txtview_EditComments.hidden=NO;
                    team_Cell.txtview_EditComments.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"grey_commentbox.png"]];
                    
                    
                    team_Cell.txtview_EditComments.frame=CGRectMake(780, 45, 240, team_Cell.frame.size.height-10);
                    [team_Cell.txtview_EditComments setEditable:YES];
                    if ([team_Cell.txtview_EditComments.text isEqual:@""]||[team_Cell.txtview_EditComments.text isEqualToString:nil])
                    {
                        
                        team_Cell.txtview_EditComments.text=@"Enter Comment";
                        
                    }
                    
                }
                else
                {
                    //Editflag=YES;
                    btn.hidden=YES;
                    btn1.hidden=YES;
                    lbls.hidden=YES;
                    img.hidden=YES;
                    lbl_finalScore.hidden=NO;
                    team_Cell.lbl_HeadingEdit.hidden=NO;
                    team_Cell.lbl_finalScore.hidden=NO;
                    team_Cell.lbl_EditComment.hidden=NO;
                    team_Cell.txtview_EditComments.hidden=NO;
                    [team_Cell.txtview_EditComments setEditable:NO];
                    team_Cell.txtview_EditComments.backgroundColor=[UIColor whiteColor];
                    team_Cell.txtview_EditComments.frame=CGRectMake(780, 45, 240, team_Cell.frame.size.height-10);

                    
                }
                
            }
            
            
            [txtDict_tum setValue:txtTempAray forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
            [AddBtnDict_tum setObject:addTempAray forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
            [SubBtnDict_tum setObject:subTempAray forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
            
            
            
            
            
            
        }
        else
        {
            team_Cell.lbl_Subcateg.text= [keyOrder_tumb objectAtIndex:indexPath.row];
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(150, 80, 200, 25)];
            lbl.text=@"Data Not Available";
            lbl.font=[UIFont fontWithName:@"Enigmatic" size:18];
            lbl.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
            
            [[team_Cell contentView]addSubview:lbl];
            
            UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(660, 80, 200, 25)];
            lbl1.text=@"Data Not Available";
            lbl1.font=[UIFont fontWithName:@"Enigmatic" size:18];
            lbl1.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
            
            [[team_Cell contentView]addSubview:lbl1];
        }

    }
    if(indexPath.section==2)
    {
           team_Cell.lbl_Timestamp.hidden=YES;
        if([[[dict_Summary objectForKey:@"CHOREOGRAPHY"]objectForKey:@"have_comments"]isEqualToString:@"Yes"])
            
        {
            [team_Cell.txtview_EditComments setAccessibilityHint:@"section 2"];
            team_Cell.txtview_EditComments.tag=indexPath.row;
            team_Cell.txtview_EditComments.text=[NSString stringWithFormat:@"%@",[ComntDict_cho objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]];
            
            
         //
        //team_Cell.lbl_Subcateg.text=     [[[[dict_Summary objectForKey:@"CHOREOGRAPHY"]objectForKey:@"comments"]allKeys]objectAtIndex:indexPath.row];
        
        //NSString *str=[[[[dict_Summary objectForKey:@"CHOREOGRAPHY"]objectForKey:@"comments"]objectForKey:[[[[dict_Summary objectForKey:@"CHOREOGRAPHY"]objectForKey:@"comments"]allKeys]objectAtIndex:indexPath.row]] objectForKey:@"comment"];
            
            team_Cell.lbl_Subcateg.text= [keyOrder_cho objectAtIndex:indexPath.row];
            NSString *str=[[[[dict_Summary objectForKey:@"CHOREOGRAPHY"]objectForKey:@"comments"]objectForKey:[keyOrder_cho objectAtIndex:indexPath.row]] objectForKey:@"comment"];
            
        NSArray* foo = [str componentsSeparatedByString: @"|"];
        team_Cell.txtview_Comments.text=[foo componentsJoinedByString:@"\n"];
            
            // edit fun
            
            
             NSMutableDictionary *tempDict=[[[[dict_Summary objectForKey:@"CHOREOGRAPHY"]objectForKey:@"comments"]objectForKey:[keyOrder_cho objectAtIndex:indexPath.row]] mutableCopy];
            
            [tempDict removeObjectForKey:@"comment"];
            
            NSMutableDictionary *tempDict_title=[[NSMutableDictionary alloc]init];
            
            tempDict_title=[[screenTypeDict_cho objectForKey:[keyOrder_cho objectAtIndex:indexPath.row]] mutableCopy];
            
            [tempDict_title removeObjectForKey:@"max_score"];
            
            NSMutableArray *tempAray=[[NSMutableArray alloc]init];
            
            NSArray *ar_title=[[tempDict_title allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
            
            for (int i=0; i<[ar_title count]; i++)
            {
                [tempAray addObject:[tempDict_title objectForKey:[ar_title objectAtIndex:i]]];
                
                UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(193, 55+i*30, 60, 25)];
                
                lbl.text=[NSString stringWithFormat:@"%.1f",[[tempDict objectForKey:[tempAray objectAtIndex:i]] floatValue]];
                
                lbl.font=[UIFont fontWithName:@"Enigmatic" size:16];
                lbl.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
                
                [[team_Cell contentView]addSubview:lbl];
                
                //NSArray *tempar=[[[dict_Newsumery objectForKey:@"BUILDING SKILLS"]objectForKey:@"comments"]allKeys];
                UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(15, 55+i*30, 150, 25)];
                lbl1.text=[tempAray objectAtIndex:i];
                //lbl1.text=@"Technique";
                 lbl1.textAlignment=NSTextAlignmentCenter;
                lbl1.font=[UIFont fontWithName:@"Enigmatic" size:16];
                lbl1.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
                
                [[team_Cell contentView]addSubview:lbl1];
                ///edit button
                
                UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
                [btn setFrame:CGRectMake(535, 55+i*30, 25, 25)];
                [btn setBackgroundImage:[UIImage imageNamed:@"plus@2x.png"] forState:UIControlStateNormal];
                [btn setTag:indexPath.row];
                [btn addTarget:self action:@selector(addbtnclicked_cho:) forControlEvents:UIControlEventTouchUpInside];
                [addTempAray insertObject:btn atIndex:i];//store
                [[team_Cell contentView]addSubview:btn];
                
                
                UILabel *lbl_editScore=[[UILabel alloc]initWithFrame:CGRectMake(570, 55+i*30, 38, 25)];
                lbl_editScore.text=[[txtValDict_cho  objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]objectAtIndex:i];
                
                lbl_editScore.font=[UIFont fontWithName:@"Enigmatic" size:15];
                //lbl_editScore.textColor=[UIColor redColor];
                [[team_Cell contentView]addSubview:lbl_editScore];
                
                UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(565, 55+i*30, 40, 25)];
                img.image=[UIImage imageNamed:@"score-box2.png"];
                [[team_Cell contentView]addSubview:img];
                
                UITextField *lbls=[[UITextField alloc]initWithFrame:CGRectMake(565, 55+i*30, 40, 25)];
                lbls.font=[UIFont fontWithName:@"Enigmatic" size:13];
                //lbls.textColor=[UIColor colorWithRed:200.0/250.0 green:10/250.0 blue:10/250.0 alpha:1.0];
                lbls.tag=indexPath.row;
                lbls.keyboardType=UIKeyboardTypeNumberPad;
                lbls.text=[[txtValDict_cho  objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]objectAtIndex:i];
                lbls.delegate=self;
                [lbls setUserInteractionEnabled:NO];
                [lbls setTextAlignment:NSTextAlignmentCenter];
                [lbls setAccessibilityHint:@"section 2"];
                [[team_Cell contentView]addSubview:lbls];
                [txtTempAray insertObject:lbls atIndex:i];
                
                
                UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
                [btn1 setFrame:CGRectMake(610, 55+i*30, 25, 25)];
                [btn1 setBackgroundImage:[UIImage imageNamed:@"minus@2x.png"] forState:UIControlStateNormal];
                [btn1 setTag:indexPath.row];
                [btn1 addTarget:self action:@selector(subtbtnclicked_cho:) forControlEvents:UIControlEventTouchUpInside];
                [[team_Cell contentView]addSubview:btn1];
                [subTempAray insertObject:btn1 atIndex:i];
                
                UILabel *lbl_finalScore=[[UILabel alloc]initWithFrame:CGRectMake(695, 55+i*30, 60, 25)];
                lbl_finalScore.font=[UIFont fontWithName:@"Enigmatic" size:16];
                //lbl_finalScore.textColor=[UIColor colorWithRed:10.0/250.0 green:150/250.0 blue:10/250.0 alpha:1.0];
                
                NSString *str=[[finalValDict_cho objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]objectAtIndex:i];
                NSString *str1=[str stringByReplacingOccurrencesOfString:@"-" withString:@""];
                
                //lbl_finalScore.text=[[finalValDict_cho objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]objectAtIndex:i];
                lbl_finalScore.text=str1;
                [[team_Cell contentView]addSubview:lbl_finalScore];
                
                
                if (Editflag==YES)
                {
                    //Editflag=NO;
                    btn.hidden=NO;
                    btn1.hidden=NO;
                    lbls.hidden=NO;
                    img.hidden=NO;
                    lbl_finalScore.hidden=NO;
                    team_Cell.lbl_HeadingEdit.hidden=NO;
                    team_Cell.lbl_finalScore.hidden=NO;
                    team_Cell.lbl_EditComment.hidden=NO;
                    team_Cell.txtview_EditComments.hidden=NO;
                    team_Cell.txtview_EditComments.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"grey_commentbox.png"]];
                    
                    
                    team_Cell.txtview_EditComments.frame=CGRectMake(780, 45, 240, team_Cell.frame.size.height-10);
                    [team_Cell.txtview_EditComments setEditable:YES];
                    
                    if ([team_Cell.txtview_EditComments.text isEqual:@""]||[team_Cell.txtview_EditComments.text isEqualToString:nil])
                    {
                        
                        team_Cell.txtview_EditComments.text=@"Enter Comment";
                        
                    }
                }
                else
                {
                    //Editflag=YES;
                    btn.hidden=YES;
                    btn1.hidden=YES;
                    lbls.hidden=YES;
                    img.hidden=YES;
                    lbl_finalScore.hidden=NO;
                    team_Cell.lbl_HeadingEdit.hidden=NO;
                    team_Cell.lbl_finalScore.hidden=NO;
                    team_Cell.lbl_EditComment.hidden=NO;
                    team_Cell.txtview_EditComments.hidden=NO;
                    [team_Cell.txtview_EditComments setEditable:NO];
                    team_Cell.txtview_EditComments.backgroundColor=[UIColor whiteColor];
                    team_Cell.txtview_EditComments.frame=CGRectMake(780, 45, 240, team_Cell.frame.size.height-10);

                    
                }
                
            }
            

            [txtDict_cho setValue:txtTempAray forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
            [AddBtnDict_cho setObject:addTempAray forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
            [SubBtnDict_cho setObject:subTempAray forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
            
        }
        else
        {
            team_Cell.lbl_Subcateg.text= [keyOrder_cho objectAtIndex:indexPath.row];
        
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(150, 80, 200, 25)];
            lbl.text=@"Data Not Available";
            lbl.font=[UIFont fontWithName:@"Enigmatic" size:18];
            lbl.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
            
            [[team_Cell contentView]addSubview:lbl];
            
            UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(660, 80, 200, 25)];
            lbl1.text=@"Data Not Available";
            lbl1.font=[UIFont fontWithName:@"Enigmatic" size:18];
            lbl1.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
            
            [[team_Cell contentView]addSubview:lbl1];

        
        }
        
    }
    
    if(indexPath.section==3)
    {
        team_Cell.lbl_score.hidden=YES;
        team_Cell.lbl_finalScore.hidden=YES;
        team_Cell.lbl_HeadingEdit.hidden=YES;
        team_Cell.lbl_EditComment.hidden=YES;
        team_Cell.txtview_EditComments.hidden=YES;
        
        
        team_Cell.txtview_Comments.frame=CGRectMake(570, 45, 300, 110);
        team_Cell.lbl_Timestamp.hidden=NO;
        
        
        
        team_Cell.lbl_Comments.frame=CGRectMake(640, 11, 154, 21);
        
        
        
        
        
        //team_Cell.img_Div_Line.frame=CGRectMake(0, 84+(20*[[[ar_TimeStamp objectAtIndex:indexPath.row]objectForKey:@"scores"]count]), 1024, 1) ;
        
        
        
        if([[[dict_Summary objectForKey:@"DEDUCTION/CUMULATIVE"]objectForKey:@"have_comments"]isEqualToString:@"Yes"])
            
        {
            if ([ar_TimeStamp count]==0)
            {
                
            NSDictionary *dict_Comments=[[dict_Summary objectForKey:@"DEDUCTION/CUMULATIVE"]objectForKey:@"comments"];
              
            }
            
            else
            {
                
            NSLog(@"%@",[[ar_TimeStamp objectAtIndex:indexPath.row]objectForKey:@"section"]);
            
            NSDictionary *dict_Comments=[[dict_Summary objectForKey:@"DEDUCTION/CUMULATIVE"]objectForKey:@"comments"];
            
            team_Cell.txtview_Comments.text = [dict_Comments objectForKey:[[ar_TimeStamp objectAtIndex:indexPath.row]objectForKey:@"section"]];
            
            if(team_Cell.txtview_Comments.text.length == 0)
            {
                team_Cell.txtview_Comments.text = @"Data Not Available";
            }
            
//            for(int i=0;i<[[dict_Comments allKeys]count];i++)
//            {
//            
//                if([[[ar_TimeStamp objectAtIndex:indexPath.row]objectForKey:@"section"]isEqualToString:[[dict_Comments allKeys]objectAtIndex:i]])
//                    {
//                        
//                        NSLog(@"%@",[[ar_TimeStamp objectAtIndex:indexPath.row]objectForKey:@"section"]);
//                       
//                        /*
//                         NSString *str=[[[dict_Summary objectForKey:@"DEDUCTION/CUMULATIVE"]objectForKey:@"comments"]objectForKey:[[[[dict_Summary objectForKey:@"DEDUCTION/CUMULATIVE"]objectForKey:@"comments"]allKeys]objectAtIndex:indexPath.row]];
//                        NSArray* foo = [str componentsSeparatedByString: @"|"];*/
//                        
//                        
//                        team_Cell.txtview_Comments.text=[dict_Comments objectForKey:[[dict_Comments allKeys]objectAtIndex:i]];
//                    
//                    }
//                else
//                {
//                    team_Cell.txtview_Comments.text=@"Data Not Available";
//                    
//                    //do nothing
//                }
            }
        }
        
        
        else
        {
            team_Cell.txtview_Comments.text=@"Data Not Available";
            
        
        }
        if ([ar_TimeStamp count]==0||[[[ar_TimeStamp objectAtIndex:indexPath.row] objectForKey:@"scores"] count]==0)

    //    if ([[[ar_TimeStamp objectAtIndex:indexPath.row] objectForKey:@"scores"] count]==0)
        {
            team_Cell.txtview_Comments.text=@"";
            
            team_Cell.lbl_Subcateg.text=[keyOrder_deduct objectAtIndex:indexPath.row];
            
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(150, 80, 200, 25)];
            lbl.text=@"Data Not Available";
            lbl.font=[UIFont fontWithName:@"Enigmatic" size:18];
            lbl.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
            
            [[team_Cell contentView]addSubview:lbl];
            
            UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(660, 80, 200, 25)];
            lbl1.text=@"Data Not Available";
            lbl1.font=[UIFont fontWithName:@"Enigmatic" size:18];
            lbl1.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
            
            [[team_Cell contentView]addSubview:lbl1];
            
        }
        else
        {
            team_Cell.lbl_Subcateg.text=[[ar_TimeStamp objectAtIndex:indexPath.row]objectForKey:@"section"];
            
            if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
            {
                
                
                for(int i=0;i<[[[ar_TimeStamp objectAtIndex:indexPath.row]objectForKey:@"scores"]count];i++)
                {
                    UILabel *lb=[[UILabel alloc]initWithFrame:CGRectMake(5, 50+(i*27), 200, 25)];
                    
                    lb.font=[UIFont fontWithName:@"Enigmatic" size:16];
                    //[lb setBackgroundColor:[UIColor clearColor]];
                    
                    //lbl_Sumry_Team_Name_head.font=[UIFont fontWithName:@"Enigmatic" size:17];
                    lb.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
                    
                    
                    // lb.textColor=[UIColor colorWithRed:250.0/250.0 green:250.0/250.0 blue:250.0/250.0 alpha:1.0];
                    
                    NSArray *ar_Lab=[[ar_TimeStamp objectAtIndex:indexPath.row]objectForKey:@"scores"];
                    
                    [lb setText:[[ar_Lab objectAtIndex:i]objectForKey:@"rating_title"]];
                    lb.textAlignment=NSTextAlignmentCenter;
                    
                    [[team_Cell contentView]addSubview:lb];
                    
                    UILabel *lbs=[[UILabel alloc]initWithFrame:CGRectMake(230, 50+(i*27), 250, 25)];
                    
                    [lbs setTextAlignment:NSTextAlignmentCenter];
                    
                    
                    NSString *sum=[[ar_Lab objectAtIndex:i]objectForKey:@"sum"];
                    NSString *time=[[ar_Lab objectAtIndex:i]objectForKey:@"time"];
                    
                 //   [lbs_finalscore setText:[NSString stringWithFormat:@"%@",sum]];

                    
                    [lbs setText:[NSString stringWithFormat:@"%@  is deducted at  %@",sum,time]];
                    [lbs setBackgroundColor:[UIColor clearColor]];
                    
                    lbs.font=[UIFont fontWithName:@"Enigmatic" size:16];
                    //lbs.textColor=[UIColor colorWithRed:250.0/250.0 green:250.0/250.0 blue:250.0/250.0 alpha:1.0];
                    
                    [[team_Cell contentView]addSubview:lbs];
                    
                    
//                    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
//                    [btn setFrame:CGRectMake(535, 55+i*30, 25, 16)];
//                    [btn setBackgroundImage:[UIImage imageNamed:@"plus@2x.png"] forState:UIControlStateNormal];
//                    [btn setTag:indexPath.row];
//                    [btn addTarget:self action:@selector(addbtnclicked_ded:) forControlEvents:UIControlEventTouchUpInside];
//                    [addTempAray insertObject:btn atIndex:i];//store
//                    [[team_Cell contentView]addSubview:btn];
//                    
//                    
//                    
//                    
//                    UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(565, 55+i*30, 40, 16)];
//                    img.image=[UIImage imageNamed:@"score-box2.png"];
//                    [[team_Cell contentView]addSubview:img];
//                    
//                    
//                    UILabel *lbl_editScore=[[UILabel alloc]initWithFrame:CGRectMake(570, 55+i*30, 35, 16)];
//                    lbl_editScore.text=[[txtValDict_ded objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]] objectAtIndex:i];
//
//                    lbl_editScore.font=[UIFont fontWithName:@"Enigmatic" size:15];
//                    
//                    [[team_Cell contentView]addSubview:lbl_editScore];
//                    
//                    
//                    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
//                    [btn1 setFrame:CGRectMake(610, 55+i*30, 25, 16)];
//                    [btn1 setBackgroundImage:[UIImage imageNamed:@"minus@2x.png"] forState:UIControlStateNormal];
//                    [btn1 setTag:indexPath.row];
//                    [btn1 addTarget:self action:@selector(subtbtnclicked_ded:) forControlEvents:UIControlEventTouchUpInside];
//                    [[team_Cell contentView]addSubview:btn1];
//                    [subTempAray insertObject:btn1 atIndex:i];
//                    
//                    
//                    UILabel *lbl_finalScore=[[UILabel alloc]initWithFrame:CGRectMake(695, 55+i*30, 60, 16)];
//                    lbl_finalScore.font=[UIFont fontWithName:@"Enigmatic" size:16];
//                    //lbl_finalScore.textColor=[UIColor colorWithRed:10.0/250.0 green:150/250.0 blue:10/250.0 alpha:1.0];
//
//                    NSString *str=[[finalValDict_ded objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]objectAtIndex:i];
//                    //    NSString *str1=[str stringByReplacingOccurrencesOfString:@"-" withString:@""];
//                    
//                    //lbl_finalScore.text=[[finalValDict_cho objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]objectAtIndex:i];
//                    lbl_finalScore.text=str;
//                    [[team_Cell contentView]addSubview:lbl_finalScore];
//                    
//                    
//                    
//                    
//                    if (Editflag==YES)
//                    {
//                        //Editflag=NO;
//                        btn.hidden=NO;
//                        btn1.hidden=NO;
//                        //   lbls.hidden=NO;
//                        img.hidden=NO;
//                        //    lbl_finalScore.hidden=NO;
//                        team_Cell.lbl_HeadingEdit.hidden=YES;
//                        team_Cell.lbl_finalScore.hidden=YES;
//                        team_Cell.lbl_EditComment.hidden=YES;
//                        team_Cell.txtview_EditComments.hidden=YES;
//                        //team_Cell.txtview_EditComments.backgroundColor=[UIColor colorWithRed:50/250.0 green:40/250.0 blue:120/250.0 alpha:0.2];
//                        team_Cell.txtview_EditComments.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"grey_commentbox.png"]];
//                        
//                        
//                        team_Cell.txtview_EditComments.frame=CGRectMake(780, 45, 240, team_Cell.frame.size.height-10);
//                        
//                        [team_Cell.txtview_EditComments setEditable:YES];
//                        if ([team_Cell.txtview_EditComments.text isEqual:@""]||[team_Cell.txtview_EditComments.text isEqualToString:nil])
//                        {
//                            
//                            team_Cell.txtview_EditComments.text=@"Enter Comment";
//                            
//                        }
//                        
//                    }
//                    else
//                    {
//                        //Editflag=YES;
//                        btn.hidden=YES;
//                        btn1.hidden=YES;
//                        //  lbls.hidden=YES;
//                        img.hidden=YES;
//                        //    lbl_finalScore.hidden=NO;
//                        team_Cell.lbl_HeadingEdit.hidden=YES;
//                        team_Cell.lbl_finalScore.hidden=YES;
//                        team_Cell.lbl_EditComment.hidden=YES;
//                        team_Cell.txtview_EditComments.hidden=YES;
//                        [team_Cell.txtview_EditComments setEditable:NO];
//                        team_Cell.txtview_EditComments.backgroundColor=[UIColor whiteColor];
//                        team_Cell.txtview_EditComments.frame=CGRectMake(780, 45, 240, team_Cell.frame.size.height-10);
//
//                    }
//                    
//
//                    
//                    
              }
//                
//                [AddBtnDict_ded setObject:addTempAray forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
//                [SubBtnDict_ded setObject:subTempAray forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
                
                //team_Cell.img_Div_Line.frame=CGRectMake(0, 18+([[[ar_TimeStamp objectAtIndex:indexPath.row]objectForKey:@"scores"]count]*30), 1024, 1);
                
                team_Cell.img_Div_Line.frame=CGRectMake(0, 84+(20*[[[ar_TimeStamp objectAtIndex:indexPath.row]objectForKey:@"scores"]count]), 1024, 1);
                //40+(20*[[[ar_TimeStamp objectAtIndex:indexPath.row]objectForKey:@"scores"]count]
                team_Cell.img_Div_Line.hidden=NO;
                // team_Cell.img_Div_Line.frame=CGRectMake(0, 138, 1024, 1);
                
                
            }
            
            else
            {
                team_Cell.lbl_Comments.frame=CGRectMake(616, 11,154 , 21);
                //team_Cell.img_Div_Line.frame=CGRectMake(0, 135, 912, 1);
                team_Cell.img_Div_Line.hidden=YES;
                
                for(int i=0;i<[[[ar_TimeStamp objectAtIndex:indexPath.row]objectForKey:@"scores"]count];i++)
                {
                    UILabel *lb=[[UILabel alloc]initWithFrame:CGRectMake(9, 50+(i*27), 200, 25)];
                    
                    lb.font=[UIFont fontWithName:@"Enigmatic" size:16];
                    //[lb setBackgroundColor:[UIColor clearColor]];
                    
                    //lbl_Sumry_Team_Name_head.font=[UIFont fontWithName:@"Enigmatic" size:17];
                    lb.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
                    
                    
                    // lb.textColor=[UIColor colorWithRed:250.0/250.0 green:250.0/250.0 blue:250.0/250.0 alpha:1.0];
                    
                    NSArray *ar_Lab=[[ar_TimeStamp objectAtIndex:indexPath.row]objectForKey:@"scores"];
                    
                    [lb setText:[[ar_Lab objectAtIndex:i]objectForKey:@"rating_title"]];
                    
                    [[team_Cell contentView]addSubview:lb];
                    
                    UILabel *lbs=[[UILabel alloc]initWithFrame:CGRectMake(234, 50+(i*27), 250, 25)];
                    
                    [lbs setTextAlignment:NSTextAlignmentCenter];
                    
                    
                    NSString *sum=[[ar_Lab objectAtIndex:i]objectForKey:@"sum"];
                    NSString *time=[[ar_Lab objectAtIndex:i]objectForKey:@"time"];
                    
                    [lbs setText:[NSString stringWithFormat:@"%@ is deducted at %@",sum,time]];
                    [lbs setBackgroundColor:[UIColor clearColor]];
                    
                    lbs.font=[UIFont fontWithName:@"Enigmatic" size:16];
                    // lbs.textColor=[UIColor colorWithRed:250.0/250.0 green:250.0/250.0 blue:250.0/250.0 alpha:1.0];
                    
                    [[team_Cell contentView]addSubview:lbs];
                    
                    
                }
                
                
            }

            
        }
       
    }


    
    
    return team_Cell;
    
}
    


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* customView=nil;
    
    if(floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
    {
        customView = [[UIView alloc] initWithFrame:CGRectMake(0,0,1024,30)];
        //[customView setBackgroundColor:[UIColor blueColor]];
        //customView.backgroundColor=[UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:0.8];
        UIImageView *img_viewBack=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,1024,30)];
        img_viewBack.image=[UIImage imageNamed:@"title-bar2.png"];//total-deduction@2x.png//title-bar2.png
        [customView addSubview:img_viewBack];
        UILabel *lbl_Categ = [[UILabel alloc] initWithFrame:CGRectZero];
        //lbl_Categ.backgroundColor =[UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
        lbl_Categ.font = [UIFont fontWithName:@"Enigmatic" size:18];
        lbl_Categ.textAlignment=NSTextAlignmentLeft;
        lbl_Categ.frame = CGRectMake(5,0,300,30);
        //lbl_Categ.text = @"Stunts/Pyramid/Tosses";
        //[lbl_Categ setBackgroundColor:[UIColor clearColor]];
        lbl_Categ.textColor = [UIColor whiteColor];
        
        if(section ==0)
        {
            
        
            
            lbl_Categ.text=@"BUILDING SKILLS";
     // lbl_Categ.backgroundColor =[UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
             // lbl_Categ.textColor=[UIColor colorWithRed:250.0/250.0 green:250.0/250.0 blue:250.0/250.0 alpha:1.0];
            
        }
        else if(section==1)
        {
            lbl_Categ.text=@"TUMBLING/JUMPS";
            
        }
        else if(section==2)
        {
            lbl_Categ.text=@"CHOREOGRAPHY";
            
        }
        else if(section==3)
        {
            lbl_Categ.text=@"DEDUCTION/CUMULATIVE";
            
        }
        
        [customView addSubview:lbl_Categ];
        
    }
    else
    {
        customView = [[UIView alloc] initWithFrame:CGRectMake(0,0,300,30)];
        //[customView setBackgroundColor:[UIColor blueColor]];
        //customView.backgroundColor=[UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
        UILabel *lbl_Categ = [[UILabel alloc] initWithFrame:CGRectZero];
        // lbl_Categ.backgroundColor =[UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
        lbl_Categ.font = [UIFont fontWithName:@"Enigmatic" size:18];
        lbl_Categ.textAlignment=NSTextAlignmentLeft;
        lbl_Categ.frame = CGRectMake(5,5,300,30);
        //lbl_Categ.text = @"Stunts/Pyramid/Tosses";
        [lbl_Categ setBackgroundColor:[UIColor clearColor]];
        // headerLabel.textColor = [UIColor whiteColor];
        
        if(section ==0)
        {
            
            lbl_Categ.text=@"BUILDING SKILLS";
            
        }
        else if(section==1)
        {
            lbl_Categ.text=@"TUMBLING/JUMPS";
            
        }
        else if(section==2)
        {
            lbl_Categ.text=@"CHOREOGRAPHY";
            
        }
        
        else if(section==4)
        {
            lbl_Categ.text=@"DEDUCTION/CUMULATIVE";
            
        }
        
        [customView addSubview:lbl_Categ];
        
    }
    
    
    return customView;


    
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  160.0;
    if(indexPath.section==3)
    {
        NSLog(@"%u",84+(20*[[[ar_TimeStamp objectAtIndex:indexPath.row]objectForKey:@"scores"]count]));
        
        CGFloat height=84+(20*[[[ar_TimeStamp objectAtIndex:indexPath.row]objectForKey:@"scores"]count]);
        
        NSLog(@"%f",height);
        
        return 84+(20*[[[ar_TimeStamp objectAtIndex:indexPath.row]objectForKey:@"scores"]count]);
     
     
        
      //return   [[[ar_TimeStamp objectAtIndex:indexPath.row]objectForKey:@"scores"]count]*40+44;
        //NSLog(@"%u", [[[ar_TimeStamp objectAtIndex:indexPath.row]objectForKey:@"scores"]count]*40+44);
        
       // return  140;//return 90+(20*[[[ar_TimeStamp objectAtIndex:indexPath.row]objectForKey:@"scores"]count]);
    
        
       
    }
    else
        
    {
        return  160.0;

    }

    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}



-(void)webServiceRequestCompleted
{
    
    if (!m_pWebService.m_pSuccessData)
    {
        // [self hideBusyView];
        //NSLog(@"%d",m_pWebService.m_pSuccessData);
        return;
    }else
    {
        ////NSLog(@"%d",m_pWebService.m_pSuccessData);
        
        
        NSString *json_string = [[NSString alloc] initWithData:m_pWebService.m_pHTTPRsp encoding:NSUTF8StringEncoding];
        NSDictionary *results = [json_string JSONValue];
        NSLog(@"Result= %@",results);
        // NSArray *aaa= [json_string JSONValue];
        
        
        if([CheckWebService isEqualToString:@"TeamSummary"])
        {
            [self hideBusyView];
        if([results objectForKey:@"Event_Summary"])
        {
            if([[[results objectForKey:@"Event_Summary"]objectForKey:@"msg"]isEqualToString:@"Successful"])
            {
                
             ar_TimeStamp=[[results objectForKey:@"Event_Summary"]objectForKey:@"time_dictionary"];
                
                
                [lbl_Sumry_Event_Title_Head setText:[[[[[results objectForKey:@"Event_Summary"]objectForKey:@"summary"]objectAtIndex:0] objectAtIndex:0] objectForKey:@"event_name"]];
                [lbl_Sumry_Team_Name setText:[[[[[results objectForKey:@"Event_Summary"]objectForKey:@"summary"]objectAtIndex:0] objectAtIndex:0] objectForKey:@"team_name"]];
                
              //  [lbl_Sumry_Date_Head setText:[[[[results objectForKey:@"Event_Summary"]objectForKey:@"summary"]objectAtIndex:0] objectForKey:@"start_date"]];
                
                Singleton *s=[Singleton getObject];
                [lbl_Sumry_Date_Head setText:[s date_Name]];
                
                dict_Summary=[[[[[results objectForKey:@"Event_Summary"]objectForKey:@"summary"]objectAtIndex:0] objectAtIndex:0] objectForKey:@"categories"];
                
                [lbl_Sumry_Stunts_Score setText:[[dict_Summary objectForKey:@"BUILDING SKILLS"] objectForKey:@"total"]];
                [lbl_Sumry_Tumbling_Score setText:[[dict_Summary objectForKey:@"TUMBLING/JUMPS"] objectForKey:@"total"]];
                [lbl_Sumry_Choreo_Score setText:[[dict_Summary objectForKey:@"CHOREOGRAPHY"] objectForKey:@"total"]];
                [lbl_Sumry_Dance_Score setText:[[dict_Summary objectForKey:@"DANCE"] objectForKey:@"total"]];
                
                [lbl_Sumry_Deduction_Score setText:[[dict_Summary objectForKey:@"DEDUCTION/CUMULATIVE"] objectForKey:@"total"]];
                [lbl_Sumry_Total_Score setText:[dict_Summary objectForKey:@"total"]];
                
                // edit
                
                ComntDict=[[NSMutableDictionary alloc]init];
                txtDict=[[NSMutableDictionary alloc]init];
                AddBtnDict=[[NSMutableDictionary alloc]init];
                SubBtnDict=[[NSMutableDictionary alloc]init];
                finalValDict=[[NSMutableDictionary alloc]init];
                txtValDict=[[NSMutableDictionary alloc]init];
                
                txtDict_tum=[[NSMutableDictionary alloc]init];
                AddBtnDict_tum=[[NSMutableDictionary alloc]init];
                SubBtnDict_tum=[[NSMutableDictionary alloc]init];
                finalValDict_tum=[[NSMutableDictionary alloc]init];
                txtValDict_tum=[[NSMutableDictionary alloc]init];
                ComntDict_tum=[[NSMutableDictionary alloc]init];

                
                txtDict_cho=[[NSMutableDictionary alloc]init];
                AddBtnDict_cho=[[NSMutableDictionary alloc]init];
                SubBtnDict_cho=[[NSMutableDictionary alloc]init];
                finalValDict_cho=[[NSMutableDictionary alloc]init];
                txtValDict_cho=[[NSMutableDictionary alloc]init];
                ComntDict_cho=[[NSMutableDictionary alloc]init];
                
                
                AddBtnDict_ded=[[NSMutableDictionary alloc]init];
                SubBtnDict_ded=[[NSMutableDictionary alloc]init];
                txtValDict_ded=[[NSMutableDictionary alloc]init];
                finalValDict_ded=[[NSMutableDictionary alloc]init];


                for (int i=0; i<[[dict_Summary allKeys]count]; i++)
                {
                    //txtValTempDict=[[NSMutableDictionary alloc]init];
                    //finalValTempDict=[[NSMutableDictionary alloc]init];
                    
                    if([[[dict_Summary objectForKey:@"BUILDING SKILLS"]objectForKey:@"have_comments"]isEqualToString:@"Yes"])
                        
                    {
                        for (int j=0; j<[[[[dict_Summary objectForKey:@"BUILDING SKILLS"]objectForKey:@"comments"]allKeys]count]; j++)
                        {
                            [txtValDict setObject:[[NSMutableArray alloc]initWithObjects:@"",@"",@"", nil] forKey:[NSString stringWithFormat:@"%d",j]];
                            
                            [finalValDict setObject:[[NSMutableArray alloc]initWithObjects:@"",@"",@"", nil] forKey:[NSString stringWithFormat:@"%d",j]];
                            
                             [ComntDict setObject:@"" forKey:[NSString stringWithFormat:@"%d",j]];
                                                   
                            
                        }

                    }
                    
                    if([[[dict_Summary objectForKey:@"TUMBLING/JUMPS"]objectForKey:@"have_comments"]isEqualToString:@"Yes"])
                    {
                        
                        for (int j=0; j<[[[[dict_Summary objectForKey:@"TUMBLING/JUMPS"]objectForKey:@"comments"]allKeys]count]; j++)
                        {
                            
                            
                            [txtValDict_tum setObject:[[NSMutableArray alloc]initWithObjects:@"",@"",@"", nil] forKey:[NSString stringWithFormat:@"%d",j]];
                            
                            [finalValDict_tum setObject:[[NSMutableArray alloc]initWithObjects:@"",@"",@"", nil] forKey:[NSString stringWithFormat:@"%d",j]];
                            
                            [ComntDict_tum setObject:@"" forKey:[NSString stringWithFormat:@"%d",j]];
                            
                            
                            
                        }

                    }
                    
                    if([[[dict_Summary objectForKey:@"CHOREOGRAPHY"]objectForKey:@"have_comments"]isEqualToString:@"Yes"])
                    {
                        for (int j=0; j<[[[[dict_Summary objectForKey:@"CHOREOGRAPHY"]objectForKey:@"comments"]allKeys]count]; j++)
                        {
                            
                            
                            [txtValDict_cho setObject:[[NSMutableArray alloc]initWithObjects:@"",@"",@"", nil] forKey:[NSString stringWithFormat:@"%d",j]];
                            
                            [finalValDict_cho setObject:[[NSMutableArray alloc]initWithObjects:@"",@"",@"", nil] forKey:[NSString stringWithFormat:@"%d",j]];
                            
                            [ComntDict_cho setObject:@"" forKey:[NSString stringWithFormat:@"%d",j]];
                            
                            
                            
                        }
                        
                    }
                    
                    if(![[[dict_Summary objectForKey:@"DEDUCTION/CUMULATIVE"]objectForKey:@"total"]isEqualToString:@"0"])
                    {
                        for (int j=0; j<[ar_TimeStamp count]; j++)
                        {
                            
                            
                            [txtValDict_ded setObject:[[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"", nil] forKey:[NSString stringWithFormat:@"%d",j]];
                            
                            [finalValDict_ded setObject:[[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"", nil] forKey:[NSString stringWithFormat:@"%d",j]];
                            //
                            //                             [ComntDict_cho setObject:@"" forKey:[NSString stringWithFormat:@"%d",j]];
                            
                            
                            
                        }
                        
                    }


                    
                }
                
                //
                
                
                if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
                {
                    
                      team_Tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 213, 1024, 510) style:UITableViewStyleGrouped];
                    
                }
                else
                {
                      team_Tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 213, 1024, 510) style:UITableViewStyleGrouped];
                }
                [team_Tableview setDelegate:self];
                [team_Tableview setDataSource:self];
                //team_Tableview.backgroundColor=[UIColor clearColor];
                [team_Tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
              
                [[self view]addSubview:team_Tableview];
                
                
            }
            else
            {
                NSLog(@"msg unsuccesfull from team summary");
                
            }
        }
        }
        
        else if ([CheckWebService isEqualToString:@"Approve"])
        {
            [self hideBusyView];

            NSDictionary *dicts=[results objectForKey:@"Approval_status"];
            NSString *status=  [dicts objectForKey:@"msg"];
            if([status isEqualToString:@"approve"])
            {
       
               /* NextTeamAlert=[[UIAlertView alloc]initWithTitle:@"Approved" message:@"Please Select Next Team" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [NextTeamAlert show];*/
                [self.navigationController popViewControllerAnimated:YES];
                
               // [self dismissViewControllerAnimated:YES completion:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"CallSlideOut" object:nil];

            }
            else
            {
              /*  NextTeamAlert=[[UIAlertView alloc]initWithTitle:@"Not Approved" message:@"Please Select Next Team" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [NextTeamAlert show];*/
                
              //  AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
                //[delegate CallSlide];
                
                [self.navigationController popViewControllerAnimated:YES];
                
                // [self dismissViewControllerAnimated:YES completion:nil];
               // [self presentViewController:delegate.viewController_leftPane animated:YES completion:NULL];
            
            }
            
            
        }
        
        else if ([CheckWebService isEqualToString:@"SaveEdit_buildingSkills"])
        {
            NSDictionary *savePerformance_Dict=[results objectForKey:@"saveperformance"];
            NSString *resultStr=[savePerformance_Dict objectForKey:@"message"];
            
            if([resultStr isEqualToString:@"Successfully Saved"])
            {
                
                [self saveEditScore_tumb];
               
                
            }
            else
            {
                UIAlertView *savePerformance_AlertNot=[[UIAlertView alloc]initWithTitle:@"" message:@"Not Saved" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [savePerformance_AlertNot show];
            }


        }
        else if ([CheckWebService isEqualToString:@"SaveEdit_Tumbling"])
        {
            NSDictionary *savePerformance_Dict=[results objectForKey:@"saveperformance"];
            NSString *resultStr=[savePerformance_Dict objectForKey:@"message"];
            
            if([resultStr isEqualToString:@"Successfully Saved"])
            {
                
                [self saveEditScore_choreo];
                
            }
            else
            {
                UIAlertView *savePerformance_AlertNot=[[UIAlertView alloc]initWithTitle:@"" message:@"Not Saved" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [savePerformance_AlertNot show];
            }
            
            
        }
        else if ([CheckWebService isEqualToString:@"SaveEdit_Choreoghaphy"])
        {
           

            NSDictionary *savePerformance_Dict=[results objectForKey:@"saveperformance"];
            NSString *resultStr=[savePerformance_Dict objectForKey:@"message"];
            
            if([resultStr isEqualToString:@"Successfully Saved"])
            {
                
                
           //    [self saveEditScore_ded];

                //[self saveEditScore_choreo];
                
                UIAlertView *savePerformance_Alert=[[UIAlertView alloc]initWithTitle:@"Data Saved Successfully" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil, nil];
                [savePerformance_Alert show];
                
            }
            
            else
            {
                UIAlertView *savePerformance_AlertNot=[[UIAlertView alloc]initWithTitle:@"" message:@"Not Saved" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [savePerformance_AlertNot show];
            }
            
        }
        
        
//        else if ([CheckWebService isEqualToString:@"saveEditScore_deduction"])
//        {
//            
//            [self hideBusyView];
//            
//            NSDictionary *savePerformance_Dict=[results objectForKey:@"saveperformance"];
//            NSString *resultStr=[savePerformance_Dict objectForKey:@"message"];
//            
//            if([resultStr isEqualToString:@"Successfully Saved"])
//            {
//                
//                //[self saveEditScore_choreo];
//                
//                UIAlertView *savePerformance_Alert=[[UIAlertView alloc]initWithTitle:@"Data Saved Successfully" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil, nil];
//                [savePerformance_Alert show];
//                
//            }
//            
//            else
//            {
//                UIAlertView *savePerformance_Alert=[[UIAlertView alloc]initWithTitle:@"Not saved" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil, nil];
//                [savePerformance_Alert show];
//            }
//            
//        }

        else if([CheckWebService isEqualToString:@"SaveComments_build"])
        {
            
        }


        
    }
}
-(void)webServiceRequestFail :(NSError *)error
{
    [self hideBusyView];
    // NoInternetConnection=YES;
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status == NotReachable){
    
    UIAlertView *alert2=[[UIAlertView alloc] initWithTitle:@"" message:@"Please check your Wi-Fi or 3G connection and try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert2 show];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btn_Click_NotApprove:(id)sender
{
    Singleton *s=[Singleton getObject];
    
//
    
    [self showBusyView];
    CheckWebService=@"Approve";
    NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
    
    [dct setObject:[s loginUserID] forKey:@"userid"];
    [dct setObject:[s event_ID] forKey:@"event"];
    [dct setObject:[s team_id] forKey:@"team"];
    [dct setObject:@"0" forKey:@"approval_status"];
   
    //[tf_level setText:[s level_Name]];
    //[tf_gym setText:[s gym_Name]];
    
    //for level and division
    [dct setObject:[s gym_Name] forKey:@"division"];
    [dct setObject:[s level_Name] forKey:@"level"];
    
    

    
    // [dct setObject:@"Used" forKey:@"type"];
    
    NSString *jsonstring1=[dct JSONRepresentation];
    ////NSLog(@"jsonstring=%@",jsonstring1);
    NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring1];
    ////NSLog(@"Post %@", post1);
    
    NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_approvescore.php",BASEURL];
    m_pWebService			= [[WebService alloc] initWebService:l_pURL];
    m_pWebService.mDelegate		= self;
    [m_pWebService  sendHTTPPost:post1];
    

    
}
-(IBAction)btn_Click_Approve:(id)sender
{
    
    ////joomerang.geniusport.com/cheerinfinity/webservices_prod/getwbs_approvescore.php?json=[{"userid":"79","event":"1","team":"2","approval_status":"approve"}]
    
    
   // joomerang.geniusport.com/cheerinfinity/webservices/getwbs_approvescore.php?json=[{"userid":"79","event":"1","team":"2","approval_status":"approve"}]
    
    Singleton *s=[Singleton getObject];
    [self showBusyView];
    CheckWebService=@"Approve";
    NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
    
    [dct setObject:[s loginUserID] forKey:@"userid"];
    [dct setObject:[s event_ID] forKey:@"event"];
    [dct setObject:[s team_id] forKey:@"team"];
    [dct setObject:@"1" forKey:@"approval_status"];
    
    //for leve and division
    [dct setObject:[s gym_Name] forKey:@"division"];
    [dct setObject:[s level_Name] forKey:@"level"];
    
    

    // [dct setObject:@"Used" forKey:@"type"];
    
    NSString *jsonstring1=[dct JSONRepresentation];
    ////NSLog(@"jsonstring=%@",jsonstring1);
    NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring1];
    ////NSLog(@"Post %@", post1);
    
    NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_approvescore.php",BASEURL];
    m_pWebService			= [[WebService alloc] initWebService:l_pURL];
    m_pWebService.mDelegate		= self;
    [m_pWebService  sendHTTPPost:post1];
   
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(alertView==NextTeamAlert)
    {
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
        [delegate.viewController_leftPane showLeftPanelAnimated:YES];
        
    }
    
    [self hideBusyView];

}



-(void)addbtnclicked:(UIButton *)sender
{
    NSMutableDictionary *tempDict=[[NSMutableDictionary alloc]init];
    tempDict=[[[[dict_Summary objectForKey:@"BUILDING SKILLS"]objectForKey:@"comments"]objectForKey:[keyOrder_build objectAtIndex:sender.tag]] mutableCopy];
    
    [tempDict removeObjectForKey:@"comment"];
    
    NSMutableDictionary *tempDict_title=[[NSMutableDictionary alloc]init];
    
    tempDict_title=[[screenTypeDict_build objectForKey:[keyOrder_build objectAtIndex:sender.tag]] mutableCopy];
    
    [tempDict_title removeObjectForKey:@"max_score"];
    
    NSMutableArray *tempAray=[[NSMutableArray alloc]init];
    
    NSArray *ar_title=[[tempDict_title allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    for (int i=0; i<[ar_title count]; i++)
    {
        [tempAray addObject:[tempDict_title objectForKey:[ar_title objectAtIndex:i]]];
    }
    
        for (int k=0; k<[[AddBtnDict allKeys] count];k++)
        {
            if (sender==[[AddBtnDict  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]] objectAtIndex:k])
            {
                float val=[[tempDict objectForKey:[tempAray objectAtIndex:k]] floatValue];
                float finaltemval=[[[finalValDict objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]objectAtIndex:k] floatValue];
                
              float maxval=[[[[screenTypeDict_build objectForKey:[keyOrder_build objectAtIndex:sender.tag]] objectForKey:@"max_score"] objectAtIndex:k] floatValue];
                NSString   *str=[[finalValDict objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]objectAtIndex:k];
                NSString   *str1=[str stringByReplacingOccurrencesOfString:@"-" withString:@""];
                

                
                float diffval=maxval-val;
                
                if ([str1 isEqualToString:@""] && val==maxval )
                {
                    
                }else
                    if (val>=maxval || finaltemval>=maxval)
                    {
                        if (finaltemval < maxval)
                        {
                            float tempVal =0;
                            tempVal= [[[txtValDict  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]objectAtIndex:k] floatValue];
                            
                            if (maxval<=1)
                            {
                                
                                tempVal+=0.1;
                                NSLog(@"%f",tempVal);
                                
                                
                                lbl_Sumry_Stunts_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Stunts_Score.text floatValue]+0.1];
                                lbl_Sumry_Total_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Total_Score.text floatValue]+0.1];
                                
                                
                            }
                            else if ((diffval<0.0 && finaltemval==0)|| (maxval-finaltemval)<0.0)
                            {
                                tempVal+=0.1;
                                lbl_Sumry_Stunts_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Stunts_Score.text floatValue]+0.1];
                                lbl_Sumry_Total_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Total_Score.text floatValue]+0.1];
                                
                            }
                            else
                            {
                                tempVal+=0.5;
                                lbl_Sumry_Stunts_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Stunts_Score.text floatValue]+0.5];
                                lbl_Sumry_Total_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Total_Score.text floatValue]+0.5];
                                
                            }
                            
                            
                            
                            [[txtValDict  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]removeObjectAtIndex:k];
                            [[txtValDict  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal] atIndex:k];
                            
                            
                            [[finalValDict objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]removeObjectAtIndex:k];
                            [[finalValDict objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal+val] atIndex:k];
                            
                            lbl_Sumry_Total_Score.textColor=[UIColor blackColor];
                            lbl_Sumry_Stunts_Score.textColor=[UIColor blackColor];
                        }
                        
                        
                    }
                    else
                    {
                        float tempVal= [[[txtValDict  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]objectAtIndex:k] floatValue];
                        if (maxval<=1)
                        {
                            
                            tempVal+=0.1;
                            NSLog(@"%f",tempVal);
                            
                            
                            
                            
                            lbl_Sumry_Stunts_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Stunts_Score.text floatValue]+0.1];
                            lbl_Sumry_Total_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Total_Score.text floatValue]+0.1];
                            
                            
                        }
                        else if ((diffval<0.5 && finaltemval==0)|| (maxval-finaltemval)<0.5)
                        {
                            tempVal+=0.1;
                            lbl_Sumry_Stunts_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Stunts_Score.text floatValue]+0.1];
                            lbl_Sumry_Total_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Total_Score.text floatValue]+0.1];
                            
                        }
                        else
                        {
                            tempVal+=0.5;
                            lbl_Sumry_Stunts_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Stunts_Score.text floatValue]+0.5];
                            lbl_Sumry_Total_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Total_Score.text floatValue]+0.5];
                            
                        }
                        
                        [[txtValDict  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]removeObjectAtIndex:k];
                        [[txtValDict  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal] atIndex:k];
                        
                        
                        [[finalValDict objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]removeObjectAtIndex:k];
                        [[finalValDict objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal+val] atIndex:k];
                        
                        lbl_Sumry_Total_Score.textColor=[UIColor blackColor];
                        lbl_Sumry_Stunts_Score.textColor=[UIColor blackColor];
                        
                        
                    }
                break;
                
                
            }
            
        }
    
    
    [team_Tableview reloadData];
    
    
}
-(void)subtbtnclicked:(UIButton *)sender
{
    
    NSMutableDictionary *tempDict=[[NSMutableDictionary alloc]init];
    tempDict=[[[[dict_Summary objectForKey:@"BUILDING SKILLS"]objectForKey:@"comments"]objectForKey:[keyOrder_build objectAtIndex:sender.tag]] mutableCopy];
    
    [tempDict removeObjectForKey:@"comment"];
    
    NSMutableDictionary *tempDict_title=[[NSMutableDictionary alloc]init];
    
    tempDict_title=[[screenTypeDict_build objectForKey:[keyOrder_build objectAtIndex:sender.tag]] mutableCopy];
    
    [tempDict_title removeObjectForKey:@"max_score"];
    
    NSMutableArray *tempAray=[[NSMutableArray alloc]init];
    
    NSArray *ar_title=[[tempDict_title allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    for (int i=0; i<[ar_title count]; i++)
    {
        [tempAray addObject:[tempDict_title objectForKey:[ar_title objectAtIndex:i]]];
    }
    
    for (int k=0; k<[[SubBtnDict allKeys] count];k++)
    {
        if (sender==[[SubBtnDict  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]] objectAtIndex:k])
        {
            float val=[[tempDict objectForKey:[tempAray objectAtIndex:k]] floatValue];
            
            
            //float finaltemval=[[[finalValDict objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]objectAtIndex:k] floatValue];
            
            float maxval=[[[[screenTypeDict_build objectForKey:[keyOrder_build objectAtIndex:sender.tag]] objectForKey:@"max_score"] objectAtIndex:k] floatValue];
             float tempVal= [[[txtValDict  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]objectAtIndex:k] floatValue];
            
            float diffval=val+tempVal;
            
            if (maxval<=1)
            {
                tempVal-=0.1;
                
                
            }
            else if (diffval<0.5)
            {
                tempVal-=0.1;
                
                
            }
            else
            {
                tempVal-=0.5;
                
                
            }
            
            if (diffval<=0.0)
            {
                
            }
            else
            {
               
                
                if (maxval<=1)
                {
                    //tempVal-=0.1;
                    lbl_Sumry_Stunts_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Stunts_Score.text floatValue]-0.1];
                    lbl_Sumry_Total_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Total_Score.text floatValue]-0.1];
                    
                }
                
                else if (diffval<0.5)
                {
                    //tempVal-=0.5;
                    lbl_Sumry_Stunts_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Stunts_Score.text floatValue]-0.1];
                    lbl_Sumry_Total_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Total_Score.text floatValue]-0.1];
                }
                else
                {
                    lbl_Sumry_Stunts_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Stunts_Score.text floatValue]-0.5];
                    lbl_Sumry_Total_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Total_Score.text floatValue]-0.5];

                    
                }
                
                [[txtValDict  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]removeObjectAtIndex:k];
                [[txtValDict  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal] atIndex:k];
                
                
                [[finalValDict objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]removeObjectAtIndex:k];
                [[finalValDict objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal+val] atIndex:k];
                
                
                lbl_Sumry_Total_Score.textColor=[UIColor blackColor];
                lbl_Sumry_Stunts_Score.textColor=[UIColor blackColor];
                
                
            }
            break;
            
            
        }
        
    }
    
    
    [team_Tableview reloadData];
    
}



-(void)addbtnclicked_tum:(UIButton *)sender
{
    
    
    NSMutableDictionary *tempDict=[[NSMutableDictionary alloc]init];
    tempDict=[[[[dict_Summary objectForKey:@"TUMBLING/JUMPS"]objectForKey:@"comments"]objectForKey:[keyOrder_tumb objectAtIndex:sender.tag]] mutableCopy];
    
    [tempDict removeObjectForKey:@"comment"];
    
    NSMutableDictionary *tempDict_title=[[NSMutableDictionary alloc]init];
    
    tempDict_title=[[screenTypeDict_tum objectForKey:[keyOrder_tumb objectAtIndex:sender.tag]] mutableCopy];
    
    [tempDict_title removeObjectForKey:@"max_score"];
    
    NSMutableArray *tempAray=[[NSMutableArray alloc]init];
    
    NSArray *ar_title=[[tempDict_title allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    for (int i=0; i<[ar_title count]; i++)
    {
        [tempAray addObject:[tempDict_title objectForKey:[ar_title objectAtIndex:i]]];
    }
    
    for (int k=0; k<[[AddBtnDict_tum allKeys] count];k++)
    {
        if (sender==[[AddBtnDict_tum  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]] objectAtIndex:k])
        {
            float val=[[tempDict objectForKey:[tempAray objectAtIndex:k]] floatValue];
            float finaltemval=[[[finalValDict_tum objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]objectAtIndex:k] floatValue];
            
            float maxval=[[[[screenTypeDict_tum objectForKey:[keyOrder_tumb objectAtIndex:sender.tag]] objectForKey:@"max_score"] objectAtIndex:k] floatValue];
            
            float diffval=maxval-val;
            NSString *str=[[finalValDict_tum objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]objectAtIndex:k];
            NSString *str1=[str stringByReplacingOccurrencesOfString:@"-" withString:@""];
            

            if ([str1 isEqualToString:@""]&& val==maxval)
            {
                
            }
            else
                
                if (val>=maxval||finaltemval>=maxval)
                {
                    if (finaltemval < maxval )
                    {
                        float tempVal= [[[txtValDict_tum  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]objectAtIndex:k] floatValue];
                        if (maxval<=1)
                        {
                            
                            tempVal+=0.1;
                            lbl_Sumry_Tumbling_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Tumbling_Score.text floatValue]+0.1];
                            lbl_Sumry_Total_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Total_Score.text floatValue]+0.1];
                            
                            
                        }
                        else if ((diffval<0.0 && finaltemval==0)|| (maxval-finaltemval)<0.0)
                        {
                            tempVal+=0.1;
                            lbl_Sumry_Tumbling_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Tumbling_Score.text floatValue]+0.1];
                            lbl_Sumry_Total_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Total_Score.text floatValue]+0.1];
                            
                        }
                        else
                        {
                            tempVal+=0.5;
                            lbl_Sumry_Tumbling_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Tumbling_Score.text floatValue]+0.5];
                            lbl_Sumry_Total_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Total_Score.text floatValue]+0.5];
                            
                        }
                        
                        
                        
                        [[txtValDict_tum  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]removeObjectAtIndex:k];
                        [[txtValDict_tum  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal] atIndex:k];
                        
                        
                        [[finalValDict_tum objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]removeObjectAtIndex:k];
                        [[finalValDict_tum objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal+val] atIndex:k];
                        
                        lbl_Sumry_Total_Score.textColor=[UIColor blackColor];
                        lbl_Sumry_Tumbling_Score.textColor=[UIColor blackColor];
                    }
                    
                }
                else
                {
                    float tempVal= [[[txtValDict_tum  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]objectAtIndex:k] floatValue];
                    if (maxval<=1)
                    {
                        tempVal+=0.1;
                        lbl_Sumry_Tumbling_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Tumbling_Score.text floatValue]+0.1];
                        lbl_Sumry_Total_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Total_Score.text floatValue]+0.1];
                        
                        
                    }
                    else if ((diffval<0.5 && finaltemval==0)|| (maxval-finaltemval)<0.5)
                    {
                        tempVal+=0.1;
                        lbl_Sumry_Tumbling_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Tumbling_Score.text floatValue]+0.1];
                        lbl_Sumry_Total_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Total_Score.text floatValue]+0.1];
                        
                    }
                    else
                    {
                        tempVal+=0.5;
                        lbl_Sumry_Tumbling_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Tumbling_Score.text floatValue]+0.5];
                        lbl_Sumry_Total_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Total_Score.text floatValue]+0.5];
                        
                    }
                    
                    [[txtValDict_tum  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]removeObjectAtIndex:k];
                    [[txtValDict_tum  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal] atIndex:k];
                    
                    
                    [[finalValDict_tum objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]removeObjectAtIndex:k];
                    [[finalValDict_tum objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal+val] atIndex:k];
                    
                    lbl_Sumry_Total_Score.textColor=[UIColor blackColor];
                    lbl_Sumry_Tumbling_Score.textColor=[UIColor blackColor];
                    
                    
                }
            
            break;
            
            
        }
        
    }
    
    [team_Tableview reloadData];
    
}
-(void)subtbtnclicked_tum:(UIButton *)sender
{
    NSMutableDictionary *tempDict=[[NSMutableDictionary alloc]init];
    tempDict=[[[[dict_Summary objectForKey:@"TUMBLING/JUMPS"]objectForKey:@"comments"]objectForKey:[keyOrder_tumb objectAtIndex:sender.tag]] mutableCopy];
    
    [tempDict removeObjectForKey:@"comment"];
    
    NSMutableDictionary *tempDict_title=[[NSMutableDictionary alloc]init];
    
    tempDict_title=[[screenTypeDict_tum objectForKey:[keyOrder_tumb objectAtIndex:sender.tag]] mutableCopy];
    
    [tempDict_title removeObjectForKey:@"max_score"];
    
    NSMutableArray *tempAray=[[NSMutableArray alloc]init];
    
    NSArray *ar_title=[[tempDict_title allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    for (int i=0; i<[ar_title count]; i++)
    {
        [tempAray addObject:[tempDict_title objectForKey:[ar_title objectAtIndex:i]]];
    }
    
    for (int k=0; k<[[SubBtnDict_tum allKeys] count];k++)
    {
        if (sender==[[SubBtnDict_tum  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]] objectAtIndex:k])
        {
            float val=[[tempDict objectForKey:[tempAray objectAtIndex:k]] floatValue];
            //float finaltemval=[[[finalValDict objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]objectAtIndex:k] floatValue];
            
            float maxval=[[[[screenTypeDict_tum objectForKey:[keyOrder_tumb objectAtIndex:sender.tag]] objectForKey:@"max_score"] objectAtIndex:k] floatValue];
            float tempVal= [[[txtValDict_tum  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]objectAtIndex:k] floatValue];
            
            float diffval=val+tempVal;
            
            if (maxval<=1)
            {
                tempVal-=0.1;
                
                
            }
            else if (diffval<0.5)
            {
                tempVal-=0.1;
                
                
            }
            else
            {
                tempVal-=0.5;
                
                
            }
            
            if (diffval<=0.0)
            {
                
            }
            else
            {
                
                
                if (maxval<=1)
                {
                    //tempVal-=0.1;
                    lbl_Sumry_Tumbling_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Tumbling_Score.text floatValue]-0.1];
                    lbl_Sumry_Total_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Total_Score.text floatValue]-0.1];
                    
                }
                
                else if (diffval<0.5)
                {
                    //tempVal-=0.5;
                    lbl_Sumry_Tumbling_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Tumbling_Score.text floatValue]-0.1];
                    lbl_Sumry_Total_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Total_Score.text floatValue]-0.1];
                }
                else
                {
                    lbl_Sumry_Tumbling_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Tumbling_Score.text floatValue]-0.5];
                    lbl_Sumry_Total_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Total_Score.text floatValue]-0.5];
                    
                    
                }
                
                [[txtValDict_tum  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]removeObjectAtIndex:k];
                [[txtValDict_tum  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal] atIndex:k];
                
                
                [[finalValDict_tum objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]removeObjectAtIndex:k];
                [[finalValDict_tum objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal+val] atIndex:k];
                
                
                lbl_Sumry_Total_Score.textColor=[UIColor blackColor];
                lbl_Sumry_Tumbling_Score.textColor=[UIColor blackColor];
                
                
            }
            break;
            
            
        }
        
    }
    
    
    [team_Tableview reloadData];
    
}


-(void)addbtnclicked_cho:(UIButton *)sender
{
    
    
    NSMutableDictionary *tempDict=[[NSMutableDictionary alloc]init];
    tempDict=[[[[dict_Summary objectForKey:@"CHOREOGRAPHY"]objectForKey:@"comments"]objectForKey:[keyOrder_cho objectAtIndex:sender.tag]] mutableCopy];
    
    [tempDict removeObjectForKey:@"comment"];
    
    NSMutableDictionary *tempDict_title=[[NSMutableDictionary alloc]init];
    
    tempDict_title=[[screenTypeDict_cho objectForKey:[keyOrder_cho objectAtIndex:sender.tag]] mutableCopy];
    
    [tempDict_title removeObjectForKey:@"max_score"];
    
    NSMutableArray *tempAray=[[NSMutableArray alloc]init];
    
    NSArray *ar_title=[[tempDict_title allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    for (int i=0; i<[ar_title count]; i++)
    {
        [tempAray addObject:[tempDict_title objectForKey:[ar_title objectAtIndex:i]]];
    }
    
    for (int k=0; k<[[AddBtnDict_cho allKeys] count];k++)
    {
        if (sender==[[AddBtnDict_cho  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]] objectAtIndex:k])
        {
            float val=[[tempDict objectForKey:[tempAray objectAtIndex:k]] floatValue];
            float finaltemval=[[[finalValDict_cho objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]objectAtIndex:k] floatValue];
            
            float maxval=[[[[screenTypeDict_cho objectForKey:[keyOrder_cho objectAtIndex:sender.tag]] objectForKey:@"max_score"] objectAtIndex:k] floatValue];
            NSString *str=[[finalValDict_cho objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]objectAtIndex:k];
            NSString *str1=[str stringByReplacingOccurrencesOfString:@"-" withString:@""];

            float diffval=maxval-val;
            
            if ([str1 isEqualToString:@""]&& val==maxval)
            {
                
            }else
                if (val>=maxval||finaltemval>=maxval)
                {
                    if (finaltemval < maxval )
                    {
                        float tempVal= [[[txtValDict_cho  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]objectAtIndex:k] floatValue];
                        if (maxval<=1)
                        {
                            
                            tempVal+=0.1;
                            lbl_Sumry_Choreo_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Choreo_Score.text floatValue]+0.1];
                            lbl_Sumry_Total_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Total_Score.text floatValue]+0.1];
                            
                            
                        }
                        else if ((diffval<0.0 && finaltemval==0)|| (maxval-finaltemval)<0.0)
                        {
                            tempVal+=0.1;
                            lbl_Sumry_Choreo_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Choreo_Score.text floatValue]+0.1];
                            lbl_Sumry_Total_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Total_Score.text floatValue]+0.1];
                            
                        }
                        else
                        {
                            tempVal+=0.5;
                            lbl_Sumry_Choreo_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Choreo_Score.text floatValue]+0.5];
                            lbl_Sumry_Total_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Total_Score.text floatValue]+0.5];
                            
                        }
                        
                        
                        
                        [[txtValDict_cho  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]removeObjectAtIndex:k];
                        [[txtValDict_cho  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal] atIndex:k];
                        
                        
                        [[finalValDict_cho objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]removeObjectAtIndex:k];
                        [[finalValDict_cho objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal+val] atIndex:k];
                        
                        lbl_Sumry_Total_Score.textColor=[UIColor blackColor];
                        lbl_Sumry_Choreo_Score.textColor=[UIColor blackColor];
                    }
                    
                }
                else
                {
                    float tempVal= [[[txtValDict_cho  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]objectAtIndex:k] floatValue];
                    if (maxval<=1)
                    {
                        tempVal+=0.1;
                        lbl_Sumry_Choreo_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Choreo_Score.text floatValue]+0.1];
                        lbl_Sumry_Total_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Total_Score.text floatValue]+0.1];
                        
                        
                    }
                    else if ((diffval<0.5 && finaltemval==0)|| (maxval-finaltemval)<0.5)
                    {
                        tempVal+=0.1;
                        lbl_Sumry_Choreo_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Choreo_Score.text floatValue]+0.1];
                        lbl_Sumry_Total_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Total_Score.text floatValue]+0.1];
                        
                    }
                    else
                    {
                        tempVal+=0.5;
                        lbl_Sumry_Choreo_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Choreo_Score.text floatValue]+0.5];
                        lbl_Sumry_Total_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Total_Score.text floatValue]+0.5];
                        
                    }
                    
                    [[txtValDict_cho  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]removeObjectAtIndex:k];
                    [[txtValDict_cho  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal] atIndex:k];
                    
                    
                    [[finalValDict_cho objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]removeObjectAtIndex:k];
                    [[finalValDict_cho objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal+val] atIndex:k];
                    
                    lbl_Sumry_Total_Score.textColor=[UIColor blackColor];
                    lbl_Sumry_Choreo_Score.textColor=[UIColor blackColor];
                    
                    
                }
            break;
            
            
        }
        
    }
    
    
    [team_Tableview reloadData];
    
}
-(void)subtbtnclicked_cho:(UIButton *)sender
{
    NSMutableDictionary *tempDict=[[NSMutableDictionary alloc]init];
    tempDict=[[[[dict_Summary objectForKey:@"CHOREOGRAPHY"]objectForKey:@"comments"]objectForKey:[keyOrder_cho objectAtIndex:sender.tag]] mutableCopy];
    
    [tempDict removeObjectForKey:@"comment"];
    
    NSMutableDictionary *tempDict_title=[[NSMutableDictionary alloc]init];
    
    tempDict_title=[[screenTypeDict_cho objectForKey:[keyOrder_cho objectAtIndex:sender.tag]] mutableCopy];
    
    [tempDict_title removeObjectForKey:@"max_score"];
    
    NSMutableArray *tempAray=[[NSMutableArray alloc]init];
    
    NSArray *ar_title=[[tempDict_title allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    for (int i=0; i<[ar_title count]; i++)
    {
        [tempAray addObject:[tempDict_title objectForKey:[ar_title objectAtIndex:i]]];
    }
    
    for (int k=0; k<[[SubBtnDict_cho allKeys] count];k++)
    {
        if (sender==[[SubBtnDict_cho  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]] objectAtIndex:k])
        {
            float val=[[tempDict objectForKey:[tempAray objectAtIndex:k]] floatValue];
            //float finaltemval=[[[finalValDict objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]objectAtIndex:k] floatValue];
            
            float maxval=[[[[screenTypeDict_cho objectForKey:[keyOrder_cho objectAtIndex:sender.tag]] objectForKey:@"max_score"] objectAtIndex:k] floatValue];
            float tempVal= [[[txtValDict_cho  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]objectAtIndex:k] floatValue];
            
            float diffval=val+tempVal;
            
            if (maxval<=1)
            {
                tempVal-=0.1;
                
                
            }
            else if (diffval<0.5)
            {
                tempVal-=0.1;
                
                
            }
            else
            {
                tempVal-=0.5;
                
                
            }
            
            if (diffval<=0.0)
            {
                
            }
            else
            {
                
                
                if (maxval<=1)
                {
                    //tempVal-=0.1;
                    lbl_Sumry_Choreo_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Choreo_Score.text floatValue]-0.1];
                    lbl_Sumry_Total_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Total_Score.text floatValue]-0.1];
                    
                }
                
                else if (diffval<0.5)
                {
                    //tempVal-=0.5;
                    lbl_Sumry_Choreo_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Choreo_Score.text floatValue]-0.1];
                    lbl_Sumry_Total_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Total_Score.text floatValue]-0.1];
                }
                else
                {
                    lbl_Sumry_Choreo_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Choreo_Score.text floatValue]-0.5];
                    lbl_Sumry_Total_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Total_Score.text floatValue]-0.5];
                    
                    
                }
                
                [[txtValDict_cho  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]removeObjectAtIndex:k];
                [[txtValDict_cho  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal] atIndex:k];
                
                
                [[finalValDict_cho objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]removeObjectAtIndex:k];
                [[finalValDict_cho objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal+val] atIndex:k];
                
                
                lbl_Sumry_Total_Score.textColor=[UIColor blackColor];
                lbl_Sumry_Choreo_Score.textColor=[UIColor blackColor];
                
                
            }
            break;
            
            
        }
        
    }
    
    
    [team_Tableview reloadData];
    
}


-(void)addbtnclicked_ded:(UIButton *)sender
{
    
    NSArray *tempDict = [AddBtnDict_ded  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
    for (int k=0; k<[tempDict count];k++)
    {
        if (sender==[tempDict objectAtIndex:k])
        {
            float val = [[[[[ar_TimeStamp objectAtIndex:sender.tag] objectForKey:@"scores"]objectAtIndex:k]objectForKey:@"sum"] floatValue];
            
            float tempVal= [[[txtValDict_ded  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]objectAtIndex:k] floatValue];
            
            tempVal+=0.5;
            
            
            
            lbl_Sumry_Deduction_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Deduction_Score.text floatValue]+0.5];
            lbl_Sumry_Total_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Total_Score.text floatValue]+0.5];
            
            
            [[txtValDict_ded  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]removeObjectAtIndex:k];
            [[txtValDict_ded  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal] atIndex:k];
            
            
            [[finalValDict_ded objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]removeObjectAtIndex:k];
            [[finalValDict_ded objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal+val] atIndex:k];
            
            
            lbl_Sumry_Total_Score.textColor=[UIColor blackColor];
            lbl_Sumry_Choreo_Score.textColor=[UIColor blackColor];
            
            
            
        }
        
    }
    
    
    [team_Tableview reloadData];
    
    
}


-(void)subtbtnclicked_ded:(UIButton *)sender
{
    
    NSArray *tempDict = [SubBtnDict_ded  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
    for (int k=0; k<[tempDict count];k++)
    {
        if (sender==[tempDict objectAtIndex:k])
        {
            float val = [[[[[ar_TimeStamp objectAtIndex:sender.tag] objectForKey:@"scores"]objectAtIndex:k]objectForKey:@"sum"] floatValue];
            
            float tempVal= [[[txtValDict_ded  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]objectAtIndex:k] floatValue];
            
            tempVal-=0.5;
            
            
            
            lbl_Sumry_Deduction_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Deduction_Score.text floatValue]-0.5];
            lbl_Sumry_Total_Score.text=[NSString stringWithFormat:@"%.1f",[lbl_Sumry_Total_Score.text floatValue]-0.5];
            
            lbs_finalscore.textColor=[UIColor purpleColor];
            lbs_finalscore.backgroundColor=[UIColor redColor];
            
            
            [[txtValDict_ded  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]removeObjectAtIndex:k];
            [[txtValDict_ded  objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal] atIndex:k];
            
            
            [[finalValDict_ded objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]removeObjectAtIndex:k];
            [[finalValDict_ded objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal+val] atIndex:k];
            
            
            lbl_Sumry_Total_Score.textColor=[UIColor blackColor];
            lbl_Sumry_Deduction_Score.textColor=[UIColor blackColor];
            
            
            
        }
        
    }
    
    
    [team_Tableview reloadData];
    
    NSLog(@"%@",finalValDict_ded);
    
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    
    NSString *hint=[textField accessibilityHint];

    if ([hint isEqualToString:@"section 0"])
    {
        NSMutableDictionary *tempDict=[[NSMutableDictionary alloc]init];
        tempDict=[[[[dict_Summary objectForKey:@"BUILDING SKILLS"]objectForKey:@"comments"]objectForKey:[keyOrder_build objectAtIndex:textField.tag]] mutableCopy];
        
        [tempDict removeObjectForKey:@"comment"];
        
        NSMutableDictionary *tempDict_title=[[NSMutableDictionary alloc]init];
        
        tempDict_title=[[screenTypeDict_build objectForKey:[keyOrder_build objectAtIndex:textField.tag]] mutableCopy];
        
        [tempDict_title removeObjectForKey:@"max_score"];
        
        NSMutableArray *tempAray=[[NSMutableArray alloc]init];
        
        NSArray *ar_title=[[tempDict_title allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        
        for (int i=0; i<[ar_title count]; i++)
        {
            [tempAray addObject:[tempDict_title objectForKey:[ar_title objectAtIndex:i]]];
        }
        
        
        for(int i=0;i<[[txtDict objectForKey:[NSString stringWithFormat:@"%d",textField.tag]]count];i++)
            
        {
            
            if ( [[txtDict objectForKey:[NSString stringWithFormat:@"%d",textField.tag]]objectAtIndex:i] == textField)
                
            {
                float Givenval=[[tempDict objectForKey:[tempAray objectAtIndex:i]] floatValue];

                //dynamic validatio for all
               //NSArray *Ar_validate=[screenTypeDict_build objectForKey:[NSString stringWithFormat:@"%d",textField.tag]];
                
                float maxval=[[[[screenTypeDict_build objectForKey:[keyOrder_build objectAtIndex:textField.tag]] objectForKey:@"max_score"] objectAtIndex:i] floatValue];

                
                //[divLableDict setObject:[[[results objectForKey:@"perforamces"] objectForKey:[sortedAry objectAtIndex:i]] objectForKey:@"max_score"] forKey:[NSNumber numberWithInt:i]];
                
                //NSLog(@"Validation array:%@",Ar_validate);
                
                NSCharacterSet *nonNumberSet= [[NSCharacterSet characterSetWithCharactersInString:@"-0123456789."] invertedSet];
                //NSLog(@"%@ Validate val:%d",[sortedAry objectAtIndex:textField.tag],[[Ar_validate objectAtIndex:i] intValue]);
                float val=maxval-Givenval;//[[Ar_validate objectAtIndex:i] intValue];
                
                NSString *valstr=[NSString stringWithFormat:@"%.1f",val];
                NSArray *valAray=[valstr componentsSeparatedByString:@"."];
                NSString *strcar;
                NSString *str1=@"-.";
                
                for (int i=0; i<=(val*10); i++)
                {
                    
                    NSString *str=[NSString stringWithFormat:@"%.1d",i];
                    strcar=[str1 stringByAppendingString:str];
                    str1=strcar;
                }
                NSCharacterSet *nonNumberSet1= [[NSCharacterSet characterSetWithCharactersInString:strcar] invertedSet];
                
                NSString *strcar1;
                NSString *str11=@"-.";
                for (int i=0; i<=maxval; i++)
                {
                    
                    NSString *str=[NSString stringWithFormat:@"%.1d",i];
                    strcar1=[str11 stringByAppendingString:str];
                    str11=strcar1;
                }
                NSCharacterSet *nonNumberSet2= [[NSCharacterSet characterSetWithCharactersInString:strcar1] invertedSet];
                
                
                
                NSString *strcarnew;
                NSString *strnew=@"-.";
                for (int i=0; i<=[[valAray objectAtIndex:1] intValue]; i++)
                {
                    
                    NSString *str=[NSString stringWithFormat:@"%.1d",i];
                    strcarnew=[strnew stringByAppendingString:str];
                    strnew=strcarnew;
                }
                NSCharacterSet *nonNumberSet3= [[NSCharacterSet characterSetWithCharactersInString:strcarnew] invertedSet];


                NSString *subStr_neg;
                
                if (!(textField.text==nil||[textField.text isEqualToString:@""]))
                {
                   subStr_neg=[textField.text substringWithRange:NSMakeRange(0, 1)];
                }
                

                if([string isEqualToString:@"-"]||[subStr_neg isEqualToString:@"-"])
                {
                    
                    if (range.location>=4)
                    {
                        return NO;
                    }
                    if([string isEqualToString:@""])
                        
                    {
                        
                        return YES;
                        
                    }
                    if (range.location==0)
                    {
                        if ([string isEqualToString:@"."])
                            
                        {
                            
                            return NO;
                            
                        }
                        else if ([string isEqualToString:@"-"])
                        {
                            return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                            
                        }
                        else
                        {
                            if ([string floatValue]>val)
                                
                            {
                                
                                return NO;
                                
                            }
                            else return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                            
                        }
                        
                    }
                    else if (range.location==1)
                    {
                        
                        if ([string isEqualToString:@"."])
                            
                        {
                            
                            
                            return NO;
                            
                        }
                        
                        else if ([string isEqualToString:@"-"])
                        {
                            return NO;
                            
                        }
                        else return ([string stringByTrimmingCharactersInSet:nonNumberSet2].length>0);
                            
                        
                        
                        
                        
                    }
                    
                    else if (range.location==2)
                    {
                       
                        if ([string isEqualToString:@"."])
                            
                        {
                            
                            NSString *subStr=[textField.text substringWithRange:NSMakeRange(1, 1)];
                            
                            if([subStr floatValue]==maxval)
                                
                            {
                                
                                return NO;
                                
                            }
                            
                            else
                            {
                                
                                //return  NO;
                                return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                                
                            }
                            return NO;
                            
                        }
                        
                        
                        else if ([string isEqualToString:@"-"])
                        {
                            return NO;
                            
                        }
                        
                       
                        
                    }
                    else if (range.location==3)
                    {
                        if ([string isEqualToString:@"-"])
                        {
                            return NO;
                            
                        }
                        else if ([string isEqualToString:@"."])
                        {
                            return NO;
                            
                        }
                        else
                        {
                            if ([[textField.text substringWithRange:NSMakeRange(1, 1)] floatValue]==maxval)
                            {
                                return NO;
                                
                            }
                            else
                            {
                                if ([[textField.text substringWithRange:NSMakeRange(0, 1)] floatValue]==val)
                                {
                                    return NO;
                                    
                                }
                                
//                                    if (maxval==1)
//                                    {
//                                        return ([string stringByTrimmingCharactersInSet:nonNumberSet1].length>0);
//                                    }
//                                    
//                                    else
                                        return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                                    
                                
                                
                                
                                
                            }
                            
                            
                            
                        }

                        

                        
                    }
                    
                    
                    
                    
                    
                    return NO;

                    
                }
                else
                {
                    if(range.location>=3)
                        
                    {
                        return NO;
                        
                    }
                    if([string isEqualToString:@""])
                        
                    {
                        
                        return YES;
                        
                    }
                    if (range.location==0)
                        
                    {
                        
                        if ([string isEqualToString:@"."])
                            
                        {
                            
                            return NO;
                            
                        }
                        else if ([string isEqualToString:@"-"])
                        {
                            return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                            
                        }
                        
                        else
                        {
                            
                            if ([string intValue]>val)
                                
                            {
                                
                                return NO;
                                
                            }
                            
                            else
                                
                            {
                                
                                if ([string floatValue]==val)
                                    
                                {
                                    
                                    return YES;
                                    
                                }
                                
                                else
                                    return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                                
                                
                                
                            }
                            
                            
                            
                        }
                        
                        
                        
                    }
                    
                    else if (range.location==1)
                        
                    {
                        
                        if ([string isEqualToString:@"."])
                            
                        {
                            
                            NSString *subStr=[textField.text substringWithRange:NSMakeRange(0, 1)];
                            
                            if([subStr floatValue]==val)
                                
                            {
                                
                                return NO;
                                
                            }
               
                            else
                            {
                                
                                //return  NO;
                                return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                                
                            }
                            return NO;
                            
                        }
                        
                        else if ([string isEqualToString:@"-"])
                        {
                            return NO;
                            
                        }
                        else //if (val>=9)
                            
                        {
                            
                            if ([string intValue]>=val)
                                
                            {
                                
                                return NO;
                                
                            }
                            
                            else
                                
                            {
                                
                                NSString *subStr=[textField.text substringWithRange:NSMakeRange(0, 1)];
                                
                                if ([subStr isEqualToString:@"1"])
                                    
                                {
                                    //NSCharacterSet *nonNumberSet1 = [[NSCharacterSet characterSetWithCharactersInString:@"0"] invertedSet];
                                    
                                    // return YES;
                                    
                                    //return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                                    
                                }
                                
                                
                                
                                return NO;
                                //return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                                
                                
                                
                            }
                            
                            return NO;
                            //return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                            
                        }
                        
                        
                        
                    }
                    
                    else if (range.location==2)
                        
                    {
                        
                        if ([string isEqualToString:@"."])
                            
                        {
                            
                            return NO;
                            
                        }
                       
                        else
                        {
                            if ([[textField.text substringWithRange:NSMakeRange(0, 1)] floatValue]==val)
                            {
                                return NO;
                                
                            }
                            else
                            {
                                NSString *subStr=[textField.text substringWithRange:NSMakeRange(1, 1)];
                                
                                if ([subStr isEqualToString:@"."])
                                    
                                {
                                    if (maxval==1)
                                    {
                                        return ([string stringByTrimmingCharactersInSet:nonNumberSet1].length>0);
                                    }
                                    
                                    else if ([[textField.text substringWithRange:NSMakeRange(0, 1)] intValue]==[[valAray objectAtIndex:0] intValue])
                                    {
                                        return ([string stringByTrimmingCharactersInSet:nonNumberSet3].length>0);
                                        
                                    }
                                      else  return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                                    
                                }
                                
                                else
                                    
                                {
                                    
                                    return NO;
                                    
                                }
                                return NO;

                            }
               
                            
                            
                        }
                        
                        
                        
                    }
                    
                    return NO;
                    
                }
 
                
               
                
                // dynamic validation
                
                
                
            }
            
        }
        
    }
    else if ([hint isEqualToString:@"section 1"])
    {
        
        NSMutableDictionary *tempDict=[[NSMutableDictionary alloc]init];
        tempDict=[[[[dict_Summary objectForKey:@"TUMBLING/JUMPS"]objectForKey:@"comments"]objectForKey:[keyOrder_tumb objectAtIndex:textField.tag]] mutableCopy];
        
        [tempDict removeObjectForKey:@"comment"];
        
        NSMutableDictionary *tempDict_title=[[NSMutableDictionary alloc]init];
        
        tempDict_title=[[screenTypeDict_tum objectForKey:[keyOrder_tumb objectAtIndex:textField.tag]] mutableCopy];
        
        [tempDict_title removeObjectForKey:@"max_score"];
        
        NSMutableArray *tempAray=[[NSMutableArray alloc]init];
        
        NSArray *ar_title=[[tempDict_title allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        
        for (int i=0; i<[ar_title count]; i++)
        {
            [tempAray addObject:[tempDict_title objectForKey:[ar_title objectAtIndex:i]]];
        }
        
        
        for(int i=0;i<[[txtDict_tum objectForKey:[NSString stringWithFormat:@"%d",textField.tag]]count];i++)
            
        {
            
            if ( [[txtDict_tum objectForKey:[NSString stringWithFormat:@"%d",textField.tag]]objectAtIndex:i] == textField)
                
            {
                float Givenval=[[tempDict objectForKey:[tempAray objectAtIndex:i]] floatValue];
                
                //dynamic validatio for all
                //NSArray *Ar_validate=[screenTypeDict_build objectForKey:[NSString stringWithFormat:@"%d",textField.tag]];
                
                float maxval=[[[[screenTypeDict_tum objectForKey:[keyOrder_tumb objectAtIndex:textField.tag]] objectForKey:@"max_score"] objectAtIndex:i] floatValue];
                
                
                //[divLableDict setObject:[[[results objectForKey:@"perforamces"] objectForKey:[sortedAry objectAtIndex:i]] objectForKey:@"max_score"] forKey:[NSNumber numberWithInt:i]];
                
                //NSLog(@"Validation array:%@",Ar_validate);
                
                NSCharacterSet *nonNumberSet= [[NSCharacterSet characterSetWithCharactersInString:@"-0123456789."] invertedSet];
                //NSLog(@"%@ Validate val:%d",[sortedAry objectAtIndex:textField.tag],[[Ar_validate objectAtIndex:i] intValue]);
                float val=maxval-Givenval;//[[Ar_validate objectAtIndex:i] intValue];
                NSString *strcar;
                NSString *str1=@"-.";
                
                
                for (int i=0; i<=(val*10); i++)
                {
                    
                    NSString *str=[NSString stringWithFormat:@"%.1d",i];
                    strcar=[str1 stringByAppendingString:str];
                    str1=strcar;
                }
                NSCharacterSet *nonNumberSet1= [[NSCharacterSet characterSetWithCharactersInString:strcar] invertedSet];
                
                
                
                NSString *strcar1;
                NSString *str11=@"-.";
                for (int i=0; i<=maxval; i++)
                {
                    
                    NSString *str=[NSString stringWithFormat:@"%.1d",i];
                    strcar1=[str11 stringByAppendingString:str];
                    str11=strcar1;
                }
                NSCharacterSet *nonNumberSet2= [[NSCharacterSet characterSetWithCharactersInString:strcar1] invertedSet];
                
                NSString *subStr_neg;
                
                if (!(textField.text==nil||[textField.text isEqualToString:@""]))
                {
                    subStr_neg=[textField.text substringWithRange:NSMakeRange(0, 1)];
                }
                
                
                if([string isEqualToString:@"-"]||[subStr_neg isEqualToString:@"-"])
                {
                    
                    if (range.location>=4)
                    {
                        return NO;
                    }
                    if([string isEqualToString:@""])
                        
                    {
                        
                        return YES;
                        
                    }
                    if (range.location==0)
                    {
                        if ([string isEqualToString:@"."])
                            
                        {
                            
                            return NO;
                            
                        }
                        else if ([string isEqualToString:@"-"])
                        {
                            return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                            
                        }
                        else
                        {
                            if ([string intValue]>val)
                                
                            {
                                
                                return NO;
                                
                            }
                            else return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                            
                        }
                        
                    }
                    else if (range.location==1)
                    {
                        
                        if ([string isEqualToString:@"."])
                            
                        {
                            
                            
                            return NO;
                            
                        }
                        
                        else if ([string isEqualToString:@"-"])
                        {
                            return NO;
                            
                        }
                        else return ([string stringByTrimmingCharactersInSet:nonNumberSet2].length>0);
                        
                        
                        
                        
                        
                    }
                    
                    else if (range.location==2)
                    {
                        
                        if ([string isEqualToString:@"."])
                            
                        {
                            
                            NSString *subStr=[textField.text substringWithRange:NSMakeRange(0, 1)];
                            
                            if([subStr isEqualToString:[NSString stringWithFormat:@"%f",val]])
                                
                            {
                                
                                return NO;
                                
                            }
                            
                            else
                            {
                                
                                //return  NO;
                                return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                                
                            }
                            
                        }
                        
                        
                        else if ([string isEqualToString:@"-"])
                        {
                            return NO;
                            
                        }
                        
                        
                        
                    }
                    else if (range.location==3)
                    {
                        if ([string isEqualToString:@"-"])
                        {
                            return NO;
                            
                        }
                        else if ([string isEqualToString:@"."])
                        {
                            return NO;
                            
                        }
                        else
                        {
                            if ([[textField.text substringWithRange:NSMakeRange(1, 1)] floatValue]==maxval)
                            {
                                return NO;
                                
                            }
                            else
                            {
                                if ([[textField.text substringWithRange:NSMakeRange(0, 1)] floatValue]==val)
                                {
                                    return NO;
                                    
                                }
                                
                                return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                                
                                
                                
                                
                                
                            }
                            
                            
                            
                        }
                        
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                    return NO;
                    
                    
                }
                else
                {
                    if(range.location>=3)
                        
                    {
                        return NO;
                        
                    }
                    if([string isEqualToString:@""])
                        
                    {
                        
                        return YES;
                        
                    }
                    if (range.location==0)
                        
                    {
                        
                        if ([string isEqualToString:@"."])
                            
                        {
                            
                            return NO;
                            
                        }
                        else if ([string isEqualToString:@"-"])
                        {
                            return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                            
                        }
                        
                        else
                        {
                            
                            if ([string intValue]>val)
                                
                            {
                                
                                return NO;
                                
                            }
                            
                            else
                                
                            {
                                
                                if ([string isEqualToString:[NSString stringWithFormat:@"%f",val]])
                                    
                                {
                                    
                                    return YES;
                                    
                                }
                                
                                else
                                    return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                                
                                
                                
                            }
                            
                            
                            
                        }
                        
                        
                        
                    }
                    
                    else if (range.location==1)
                        
                    {
                        
                        if ([string isEqualToString:@"."])
                            
                        {
                            
                            NSString *subStr=[textField.text substringWithRange:NSMakeRange(0, 1)];
                            
                            if([subStr isEqualToString:[NSString stringWithFormat:@"%f",val]])
                                
                            {
                                
                                return NO;
                                
                            }
                            
                            else
                            {
                                
                                //return  NO;
                                return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                                
                            }
                            
                        }
                        
                        else if ([string isEqualToString:@"-"])
                        {
                            return NO;
                            
                        }
                        else //if (val>=9)
                            
                        {
                            
                            if ([string intValue]>=val)
                                
                            {
                                
                                return NO;
                                
                            }
                            
                            else
                                
                            {
                                
                                NSString *subStr=[textField.text substringWithRange:NSMakeRange(0, 1)];
                                
                                if ([subStr isEqualToString:@"1"])
                                    
                                {
                                    //NSCharacterSet *nonNumberSet1 = [[NSCharacterSet characterSetWithCharactersInString:@"0"] invertedSet];
                                    
                                    // return YES;
                                    
                                    //return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                                    
                                }
                                
                                
                                
                                return NO;
                                //return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                                
                                
                                
                            }
                            
                            return NO;
                            //return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                            
                        }
                        
                        
                        
                    }
                    
                    else if (range.location==2)
                        
                    {
                        
                        if ([string isEqualToString:@"."])
                            
                        {
                            
                            return NO;
                            
                        }
                        
                        else
                        {
                            if ([[textField.text substringWithRange:NSMakeRange(0, 1)] floatValue]==val)
                            {
                                return NO;
                                
                            }
                            else
                            {
                                NSString *subStr=[textField.text substringWithRange:NSMakeRange(1, 1)];
                                
                                if ([subStr isEqualToString:@"."])
                                    
                                {
                                    if (maxval==1)
                                    {
                                        return ([string stringByTrimmingCharactersInSet:nonNumberSet1].length>0);
                                    }
                                    
                                    else
                                        return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                                    
                                }
                                
                                else
                                    
                                {
                                    
                                    return NO;
                                    
                                }
                                
                            }
                            
                            
                            
                        }
                        
                        
                        
                    }
                    
                    return NO;
                    
                }
                
                
                
                
                // dynamic validation
                
                
                
            }
            
        }

        
        
        
        
    }
    else if ([hint isEqualToString:@"section 2"])
    {
        
        NSMutableDictionary *tempDict=[[NSMutableDictionary alloc]init];
        tempDict=[[[[dict_Summary objectForKey:@"CHOREOGRAPHY"]objectForKey:@"comments"]objectForKey:[keyOrder_cho objectAtIndex:textField.tag]] mutableCopy];
        
        [tempDict removeObjectForKey:@"comment"];
        
        NSMutableDictionary *tempDict_title=[[NSMutableDictionary alloc]init];
        
        tempDict_title=[[screenTypeDict_cho objectForKey:[keyOrder_cho objectAtIndex:textField.tag]] mutableCopy];
        
        [tempDict_title removeObjectForKey:@"max_score"];
        
        NSMutableArray *tempAray=[[NSMutableArray alloc]init];
        
        NSArray *ar_title=[[tempDict_title allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        
        for (int i=0; i<[ar_title count]; i++)
        {
            [tempAray addObject:[tempDict_title objectForKey:[ar_title objectAtIndex:i]]];
        }
        
        
        for(int i=0;i<[[txtDict_cho objectForKey:[NSString stringWithFormat:@"%d",textField.tag]]count];i++)
            
        {
            
            if ( [[txtDict_cho objectForKey:[NSString stringWithFormat:@"%d",textField.tag]]objectAtIndex:i] == textField)
                
            {
                float Givenval=[[tempDict objectForKey:[tempAray objectAtIndex:i]] floatValue];
                
                //dynamic validatio for all
                //NSArray *Ar_validate=[screenTypeDict_build objectForKey:[NSString stringWithFormat:@"%d",textField.tag]];
                
                float maxval=[[[[screenTypeDict_cho objectForKey:[keyOrder_cho objectAtIndex:textField.tag]] objectForKey:@"max_score"] objectAtIndex:i] floatValue];
                
                
                //[divLableDict setObject:[[[results objectForKey:@"perforamces"] objectForKey:[sortedAry objectAtIndex:i]] objectForKey:@"max_score"] forKey:[NSNumber numberWithInt:i]];
                
                //NSLog(@"Validation array:%@",Ar_validate);
                
                NSCharacterSet *nonNumberSet= [[NSCharacterSet characterSetWithCharactersInString:@"-0123456789."] invertedSet];
                //NSLog(@"%@ Validate val:%d",[sortedAry objectAtIndex:textField.tag],[[Ar_validate objectAtIndex:i] intValue]);
                float val=maxval-Givenval;//[[Ar_validate objectAtIndex:i] intValue];
                NSString *strcar;
                NSString *str1=@"-.";
                
                
                for (int i=0; i<=(val*10); i++)
                {
                    
                    NSString *str=[NSString stringWithFormat:@"%.1d",i];
                    strcar=[str1 stringByAppendingString:str];
                    str1=strcar;
                }
                NSCharacterSet *nonNumberSet1= [[NSCharacterSet characterSetWithCharactersInString:strcar] invertedSet];
                
                
                
                NSString *strcar1;
                NSString *str11=@"-.";
                for (int i=0; i<=maxval; i++)
                {
                    
                    NSString *str=[NSString stringWithFormat:@"%.1d",i];
                    strcar1=[str11 stringByAppendingString:str];
                    str11=strcar1;
                }
                NSCharacterSet *nonNumberSet2= [[NSCharacterSet characterSetWithCharactersInString:strcar1] invertedSet];
                
                NSString *subStr_neg;
                
                if (!(textField.text==nil||[textField.text isEqualToString:@""]))
                {
                    subStr_neg=[textField.text substringWithRange:NSMakeRange(0, 1)];
                }
                
                
                if([string isEqualToString:@"-"]||[subStr_neg isEqualToString:@"-"])
                {
                    
                    if (range.location>=4)
                    {
                        return NO;
                    }
                    if([string isEqualToString:@""])
                        
                    {
                        
                        return YES;
                        
                    }
                    if (range.location==0)
                    {
                        if ([string isEqualToString:@"."])
                            
                        {
                            
                            return NO;
                            
                        }
                        else if ([string isEqualToString:@"-"])
                        {
                            return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                            
                        }
                        else
                        {
                            if ([string intValue]>val)
                                
                            {
                                
                                return NO;
                                
                            }
                            else return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                            
                        }
                        
                    }
                    else if (range.location==1)
                    {
                        
                        if ([string isEqualToString:@"."])
                            
                        {
                            
                            
                            return NO;
                            
                        }
                        
                        else if ([string isEqualToString:@"-"])
                        {
                            return NO;
                            
                        }
                        else return ([string stringByTrimmingCharactersInSet:nonNumberSet2].length>0);
                        
                        
                        
                        
                        
                    }
                    
                    else if (range.location==2)
                    {
                        
                        if ([string isEqualToString:@"."])
                            
                        {
                            
                            NSString *subStr=[textField.text substringWithRange:NSMakeRange(0, 1)];
                            
                            if([subStr isEqualToString:[NSString stringWithFormat:@"%f",val]])
                                
                            {
                                
                                return NO;
                                
                            }
                            
                            else
                            {
                                
                                //return  NO;
                                return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                                
                            }
                            
                        }
                        
                        
                        else if ([string isEqualToString:@"-"])
                        {
                            return NO;
                            
                        }
                        
                        
                        
                    }
                    else if (range.location==3)
                    {
                        if ([string isEqualToString:@"-"])
                        {
                            return NO;
                            
                        }
                        else if ([string isEqualToString:@"."])
                        {
                            return NO;
                            
                        }
                        else
                        {
                            if ([[textField.text substringWithRange:NSMakeRange(1, 1)] floatValue]==maxval)
                            {
                                return NO;
                                
                            }
                            else
                            {
                                if ([[textField.text substringWithRange:NSMakeRange(0, 1)] floatValue]==val)
                                {
                                    return NO;
                                    
                                }
                                
                                return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                                
                                
                                
                                
                                
                            }
                            
                            
                            
                        }
                        
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                    return NO;
                    
                    
                }
                else
                {
                    if(range.location>=3)
                        
                    {
                        return NO;
                        
                    }
                    if([string isEqualToString:@""])
                        
                    {
                        
                        return YES;
                        
                    }
                    if (range.location==0)
                        
                    {
                        
                        if ([string isEqualToString:@"."])
                            
                        {
                            
                            return NO;
                            
                        }
                        else if ([string isEqualToString:@"-"])
                        {
                            return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                            
                        }
                        
                        else
                        {
                            
                            if ([string intValue]>val)
                                
                            {
                                
                                return NO;
                                
                            }
                            
                            else
                                
                            {
                                
                                if ([string isEqualToString:[NSString stringWithFormat:@"%f",val]])
                                    
                                {
                                    
                                    return YES;
                                    
                                }
                                
                                else
                                    return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                                
                                
                                
                            }
                            
                            
                            
                        }
                        
                        
                        
                    }
                    
                    else if (range.location==1)
                        
                    {
                        
                        if ([string isEqualToString:@"."])
                            
                        {
                            
                            NSString *subStr=[textField.text substringWithRange:NSMakeRange(0, 1)];
                            
                            if([subStr isEqualToString:[NSString stringWithFormat:@"%f",val]])
                                
                            {
                                
                                return NO;
                                
                            }
                            
                            else
                            {
                                
                                //return  NO;
                                return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                                
                            }
                            
                        }
                        
                        else if ([string isEqualToString:@"-"])
                        {
                            return NO;
                            
                        }
                        else //if (val>=9)
                            
                        {
                            
                            if ([string intValue]>=val)
                                
                            {
                                
                                return NO;
                                
                            }
                            
                            else
                                
                            {
                                
                                NSString *subStr=[textField.text substringWithRange:NSMakeRange(0, 1)];
                                
                                if ([subStr isEqualToString:@"1"])
                                    
                                {
                                    //NSCharacterSet *nonNumberSet1 = [[NSCharacterSet characterSetWithCharactersInString:@"0"] invertedSet];
                                    
                                    // return YES;
                                    
                                    //return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                                    
                                }
                                
                                
                                
                                return NO;
                                //return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                                
                                
                                
                            }
                            
                            return NO;
                            //return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                            
                        }
                        
                        
                        
                    }
                    
                    else if (range.location==2)
                        
                    {
                        
                        if ([string isEqualToString:@"."])
                            
                        {
                            
                            return NO;
                            
                        }
                        
                        else
                        {
                            if ([[textField.text substringWithRange:NSMakeRange(0, 1)] floatValue]==val)
                            {
                                return NO;
                                
                            }
                            else
                            {
                                NSString *subStr=[textField.text substringWithRange:NSMakeRange(1, 1)];
                                
                                if ([subStr isEqualToString:@"."])
                                    
                                {
                                    if (maxval==1)
                                    {
                                        return ([string stringByTrimmingCharactersInSet:nonNumberSet1].length>0);
                                    }
                                    
                                    else
                                        return ([string stringByTrimmingCharactersInSet:nonNumberSet].length>0);
                                    
                                }
                                
                                else
                                    
                                {
                                    
                                    return NO;
                                    
                                }
                                
                            }
                            
                            
                            
                        }
                        
                        
                        
                    }
                    
                    return NO;
                    
                }
                
                
                
                
                // dynamic validation
                
                
                
            }
            
        }

        
        
        
        
    }


    
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    NSCharacterSet *nonNumberSet= [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERS1parentEmailID] invertedSet];

    if([text isEqualToString:@""])
    {
        return YES;
 
    }
    if(range.location>=250)
    {
        return NO;
    }
    else
    {
        return ([text stringByTrimmingCharactersInSet:nonNumberSet].length>0);
    }
    return NO;

}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString *hint=[textField accessibilityHint];
    
    if ([hint isEqualToString:@"section 0"])
    {
        NSMutableDictionary *tempDict=[[NSMutableDictionary alloc]init];
        tempDict=[[[[dict_Summary objectForKey:@"BUILDING SKILLS"]objectForKey:@"comments"]objectForKey:[keyOrder_build objectAtIndex:textField.tag]] mutableCopy];
        
        [tempDict removeObjectForKey:@"comment"];
        
        NSMutableDictionary *tempDict_title=[[NSMutableDictionary alloc]init];
        
        tempDict_title=[[screenTypeDict_build objectForKey:[keyOrder_build objectAtIndex:textField.tag]] mutableCopy];
        
        [tempDict_title removeObjectForKey:@"max_score"];
        
        NSMutableArray *tempAray=[[NSMutableArray alloc]init];
        
        NSArray *ar_title=[[tempDict_title allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        
        for (int i=0; i<[ar_title count]; i++)
        {
            [tempAray addObject:[tempDict_title objectForKey:[ar_title objectAtIndex:i]]];
        }
        
        for (int k=0; k<[[txtDict allKeys] count];k++)
        {
            if (textField==[[txtDict  objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]] objectAtIndex:k])
            {
                
                float val=[[tempDict objectForKey:[tempAray objectAtIndex:k]] floatValue];
                //float finaltemval=[[[finalValDict objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]objectAtIndex:k] floatValue];
                
                //float maxval=[[[[screenTypeDict_build objectForKey:[keyOrder_build objectAtIndex:textField.tag]] objectForKey:@"max_score"] objectAtIndex:k] floatValue];
                
                /*if (val>=maxval||finaltemval>=maxval||val<=-maxval||finaltemval<=-maxval)
                {
                    if (finaltemval < maxval && finaltemval!=0)
                    {
                        float tempVal= [[[[txtDict  objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]objectAtIndex:k] text] floatValue];
                        
                        [[txtValDict  objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]removeObjectAtIndex:k];
                        [[txtValDict  objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal] atIndex:k];
                        
                        
                        
                        [[finalValDict objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]removeObjectAtIndex:k];
                        [[finalValDict objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal+val] atIndex:k];
                        
                    }

                    
                }
                else
                {*/
                   
                    float tempVal= [[[[txtDict  objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]objectAtIndex:k] text] floatValue];
                    
                    [[txtValDict  objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]removeObjectAtIndex:k];
                    [[txtValDict  objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal] atIndex:k];
                    
                    
                    
                    [[finalValDict objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]removeObjectAtIndex:k];
                    [[finalValDict objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal+val] atIndex:k];
                    
                   
                    
                //}
                
                 break;
                
            }
            
        }
    }
    else if ([hint isEqualToString:@"section 1"])
    {
        NSMutableDictionary *tempDict=[[NSMutableDictionary alloc]init];
        tempDict=[[[[dict_Summary objectForKey:@"TUMBLING/JUMPS"]objectForKey:@"comments"]objectForKey:[keyOrder_tumb objectAtIndex:textField.tag]] mutableCopy];
        
        [tempDict removeObjectForKey:@"comment"];
        
        NSMutableDictionary *tempDict_title=[[NSMutableDictionary alloc]init];
        
        tempDict_title=[[screenTypeDict_tum objectForKey:[keyOrder_tumb objectAtIndex:textField.tag]] mutableCopy];
        
        [tempDict_title removeObjectForKey:@"max_score"];
        
        NSMutableArray *tempAray=[[NSMutableArray alloc]init];
        
        NSArray *ar_title=[[tempDict_title allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        
        for (int i=0; i<[ar_title count]; i++)
        {
            [tempAray addObject:[tempDict_title objectForKey:[ar_title objectAtIndex:i]]];
        }
        
        
        for (int k=0; k<[[txtDict_tum allKeys] count];k++)
        {
            if (textField==[[txtDict_tum  objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]] objectAtIndex:k])
            {
                
                float val=[[tempDict objectForKey:[tempAray objectAtIndex:k]] floatValue];
                //float finaltemval=[[[finalValDict_tum objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]objectAtIndex:k] floatValue];
                
                //float maxval=[[[[screenTypeDict_tum objectForKey:[keyOrder_tumb objectAtIndex:textField.tag]] objectForKey:@"max_score"] objectAtIndex:k] floatValue];
                
                /*if (val>=maxval||finaltemval>=maxval||val<=-maxval||finaltemval<=-maxval)
                {
                    
                    if (finaltemval < maxval && finaltemval!=0)
                    {
                        float tempVal= [[[[txtDict_tum  objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]objectAtIndex:k] text] floatValue];
                        
                        [[txtValDict_tum  objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]removeObjectAtIndex:k];
                        [[txtValDict_tum  objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal] atIndex:k];
                        
                        
                        [[finalValDict_tum objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]removeObjectAtIndex:k];
                        [[finalValDict_tum objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal+val] atIndex:k];
                        
                    }

                    
                }
                else
                {*/
                    
                    float tempVal= [[[[txtDict_tum  objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]objectAtIndex:k] text] floatValue];
                    
                    [[txtValDict_tum  objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]removeObjectAtIndex:k];
                    [[txtValDict_tum  objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal] atIndex:k];
                    
                    
                    [[finalValDict_tum objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]removeObjectAtIndex:k];
                    [[finalValDict_tum objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal+val] atIndex:k];
                    
                   
                    
                //}
                
                 break;
                
                
            }
            
        }
    }
    else if ([hint isEqualToString:@"section 2"])
    {
        NSMutableDictionary *tempDict=[[NSMutableDictionary alloc]init];
    tempDict=[[[[dict_Summary objectForKey:@"CHOREOGRAPHY"]objectForKey:@"comments"]objectForKey:[keyOrder_cho objectAtIndex:textField.tag]] mutableCopy];
        
        [tempDict removeObjectForKey:@"comment"];
        
        NSMutableDictionary *tempDict_title=[[NSMutableDictionary alloc]init];
        
        tempDict_title=[[screenTypeDict_cho objectForKey:[keyOrder_cho objectAtIndex:textField.tag]] mutableCopy];
        
        [tempDict_title removeObjectForKey:@"max_score"];
        
        NSMutableArray *tempAray=[[NSMutableArray alloc]init];
        
        NSArray *ar_title=[[tempDict_title allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        
        for (int i=0; i<[ar_title count]; i++)
        {
            [tempAray addObject:[tempDict_title objectForKey:[ar_title objectAtIndex:i]]];
        }
        
        
        for (int k=0; k<[[txtDict_cho allKeys] count];k++)
        {
            if (textField==[[txtDict_cho  objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]] objectAtIndex:k])
            {
                
                float val=[[tempDict objectForKey:[tempAray objectAtIndex:k]] floatValue];
                //float finaltemval=[[[finalValDict_cho objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]objectAtIndex:k] floatValue];
                
                //float maxval=[[[[screenTypeDict_cho objectForKey:[keyOrder_cho objectAtIndex:textField.tag]] objectForKey:@"max_score"] objectAtIndex:k] floatValue];
                
                /*if (val>=maxval||finaltemval>=maxval||val<=-maxval||finaltemval<=-maxval)
                {
                    if (finaltemval < maxval && finaltemval!=0)
                    {
                        
                        float tempVal= [[[[txtDict_cho  objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]objectAtIndex:k] text] floatValue];
                        
                        [[txtValDict_cho  objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]removeObjectAtIndex:k];
                        [[txtValDict_cho  objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal] atIndex:k];
                        
                        
                        [[finalValDict_cho objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]removeObjectAtIndex:k];
                        [[finalValDict_cho objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal+val] atIndex:k];
                        
                        
                    }

                    
                    
                }
                else
                {*/
                   
                    float tempVal= [[[[txtDict_cho  objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]objectAtIndex:k] text] floatValue];
                    
                    [[txtValDict_cho  objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]removeObjectAtIndex:k];
                    [[txtValDict_cho  objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal] atIndex:k];
                    
                    
                    [[finalValDict_cho objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]removeObjectAtIndex:k];
                    [[finalValDict_cho objectForKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]]insertObject:[NSString stringWithFormat:@"%.1f",tempVal+val] atIndex:k];
                    
                    
                    
                //}
                
                break;
                
            }
            
        }
    }
    
    [team_Tableview reloadData];
    
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
        CGPoint pointInTable = [textField.superview convertPoint:textField.frame.origin toView:team_Tableview];
        CGPoint contentOffset = team_Tableview.contentOffset;
        
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
        {
            contentOffset.y = (pointInTable.y - textField.inputAccessoryView.frame.size.height)-30;
        }
        else
        {
            contentOffset.y = (pointInTable.y - textField.inputAccessoryView.frame.size.height)-25;
        }
        
        NSLog(@"contentOffset is: %@", NSStringFromCGPoint(contentOffset));
        
        [team_Tableview setContentOffset:contentOffset animated:YES];
        
    return YES;
    
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
   
        CGPoint pointInTable = [textView.superview convertPoint:textView.frame.origin toView:team_Tableview];
        CGPoint contentOffset = team_Tableview.contentOffset;
        
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
        {
            contentOffset.y = (pointInTable.y - textView.inputAccessoryView.frame.size.height)-30;
        }
        else
        {
            contentOffset.y = (pointInTable.y - textView.inputAccessoryView.frame.size.height)-30;
        }
        
        NSLog(@"contentOffset is: %@", NSStringFromCGPoint(contentOffset));
        
        [team_Tableview setContentOffset:contentOffset animated:YES];
    
    if ([textView.text isEqualToString:@"Enter Comment"])
    {
        textView.text=@"";
    }
    
    return YES;
    
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([[textView accessibilityHint]isEqualToString:@"section 0"])
    {
        if ([[textView text]isEqualToString:@""])
        {
            
        }
        else
        {
            comment1=YES;

        [ComntDict removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)textView.tag]];
        [ComntDict setObject:[textView text] forKey:[NSString stringWithFormat:@"%ld",(long)textView.tag]];
        
        
            // http://joomerang.geniusport.com/cheerinfinity/webservices/getwbs_savecomment.php?json=[{"commented_by":"1","team_id":"1","perf_id":"1","title":"STUNTS","comment_desc":"Motions/Dance%20Variety"}]
            //http://54.191.2.63/spiritcentral_uat/webservices_dev/
            
            Singleton *s=[Singleton getObject];
        
        
                Singleton *s_Obj=[Singleton getObject];
                NSLog(@"LoginUserID=%@",[s_Obj loginUserID]);
                
                //[self showBusyView];
                CheckWebService=@"SaveComments_build";
                Singleton *st=[Singleton getObject];
                NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
                [dct setObject:[st event_ID] forKey:@"event_id"];
                
                //for level and division
                [dct setObject:[s division_id] forKey:@"division"];
                [dct setObject:[s level_id_new] forKey:@"level"];
        
                [dct setObject:[s_Obj loginUserID] forKey:@"commented_by"];
        
                [dct setObject:[s team_id] forKey:@"team_id"];
        
        
                [dct setObject:@"1" forKey:@"perf_id"];
                
                //[dct setObject:[s screenID] forKey:@"perf_id"];
                
                
                [dct setObject:[keyOrder_build objectAtIndex:textView.tag] forKey:@"title"];
        
        if ([textView text]==nil||[textView.text isEqualToString:@""])
        {
            [dct setObject:@" " forKey:@"comment_desc"];
        }
          else [dct setObject:textView.text forKey:@"comment_desc"];
              
                NSLog(@"Comment_dct==%@",dct);
                
                NSString *jsonstring1=[dct JSONRepresentation];
                
                //NSString *jsonstring_encoding = [NSString stringWithFormat:@"%@",[jsonstring1 urlEncodeUsingEncoding:NSUTF8StringEncoding]];
                                                 
                NSLog(@"jsonstring_encoding=%@",jsonstring1);
                
                
                NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring1];
                
                NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_savecomment.php",BASEURL];
                m_pWebService			= [[WebService alloc] initWebService:l_pURL];
                m_pWebService.mDelegate		= self;
                [m_pWebService  sendHTTPPost:post1];
        }
        
        
        
        
    }
    else if ([[textView accessibilityHint]isEqualToString:@"section 1"])
    {
        if ([[textView text]isEqualToString:@""])
        {
            
        }
        else
        {
            comment1=YES;
        [ComntDict_tum removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)textView.tag]];
        [ComntDict_tum setObject:[textView text] forKey:[NSString stringWithFormat:@"%ld",(long)textView.tag]];
        
        Singleton *s=[Singleton getObject];
        
        
        Singleton *s_Obj=[Singleton getObject];
        NSLog(@"LoginUserID=%@",[s_Obj loginUserID]);
        
        //[self showBusyView];
        CheckWebService=@"SaveComments_tum";
        Singleton *st=[Singleton getObject];
        NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
        [dct setObject:[st event_ID] forKey:@"event_id"];
        
        //for level and division
        [dct setObject:[s division_id] forKey:@"division"];
        [dct setObject:[s level_id_new] forKey:@"level"];
        
        
        
        [dct setObject:[s_Obj loginUserID] forKey:@"commented_by"];
        
        [dct setObject:[s team_id] forKey:@"team_id"];
        
        
        [dct setObject:@"2" forKey:@"perf_id"];
        
        //[dct setObject:[s screenID] forKey:@"perf_id"];
        
        
        [dct setObject:[keyOrder_tumb objectAtIndex:textView.tag] forKey:@"title"];
        
        [dct setObject:textView.text forKey:@"comment_desc"];
        NSLog(@"Comment_dct==%@",dct);
        
        NSString *jsonstring1=[dct JSONRepresentation];
        
        //NSString *jsonstring_encoding = [NSString stringWithFormat:@"%@",[jsonstring1 urlEncodeUsingEncoding:NSUTF8StringEncoding]];
        
        NSLog(@"jsonstring_encoding=%@",jsonstring1);
        
        
        NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring1];
        
        NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_savecomment.php",BASEURL];
        m_pWebService			= [[WebService alloc] initWebService:l_pURL];
        m_pWebService.mDelegate		= self;
        [m_pWebService  sendHTTPPost:post1];
        
        }
    }
    else if ([[textView accessibilityHint]isEqualToString:@"section 2"])
    {
        if ([[textView text]isEqualToString:@""])
        {
            
        }
        else
        {
            comment1=YES;
        [ComntDict_cho removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)textView.tag]];
        [ComntDict_cho setObject:[textView text] forKey:[NSString stringWithFormat:@"%ld",(long)textView.tag]];
        
        
        Singleton *s=[Singleton getObject];
        
        
        Singleton *s_Obj=[Singleton getObject];
        NSLog(@"LoginUserID=%@",[s_Obj loginUserID]);
        
        //[self showBusyView];
        CheckWebService=@"SaveComments_cho";
        Singleton *st=[Singleton getObject];
        NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
        [dct setObject:[st event_ID] forKey:@"event_id"];
        
        //for level and division
        [dct setObject:[s division_id] forKey:@"division"];
        [dct setObject:[s level_id_new] forKey:@"level"];
        
        
        
        [dct setObject:[s_Obj loginUserID] forKey:@"commented_by"];
        
        [dct setObject:[s team_id] forKey:@"team_id"];
        
        
        [dct setObject:@"3" forKey:@"perf_id"];
        
        //[dct setObject:[s screenID] forKey:@"perf_id"];
        
        
        [dct setObject:[keyOrder_cho objectAtIndex:textView.tag] forKey:@"title"];
        
        [dct setObject:textView.text forKey:@"comment_desc"];
        NSLog(@"Comment_dct==%@",dct);
        
        NSString *jsonstring1=[dct JSONRepresentation];
        
        //NSString *jsonstring_encoding = [NSString stringWithFormat:@"%@",[jsonstring1 urlEncodeUsingEncoding:NSUTF8StringEncoding]];
        
        NSLog(@"jsonstring_encoding=%@",jsonstring1);
        
        
        NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring1];
        
        NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_savecomment.php",BASEURL];
        m_pWebService			= [[WebService alloc] initWebService:l_pURL];
        m_pWebService.mDelegate		= self;
        [m_pWebService  sendHTTPPost:post1];
        
        }
        
    }
    if ([textView.text isEqualToString:@""]||[textView.text isEqualToString:nil])
    {
        
        textView.text=@"Enter Comment";
        
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if (![[touch view] isKindOfClass:[UITextField class]]||[[touch view] isKindOfClass:[UITextView class]])
    {
        [self.view endEditing:YES];
        [self.view resignFirstResponder];
        
    }
    
    [self.view endEditing:YES];
    [self.view resignFirstResponder];
    
    [super touchesBegan:touches withEvent:event];
}

- (void) myKeyboardWillHideHandler:(NSNotification *)notification
{
    //[textField resignFirstResponder];
    [self.view endEditing:YES];
    [team_Tableview setContentOffset:CGPointZero animated:YES];
    
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


@end
