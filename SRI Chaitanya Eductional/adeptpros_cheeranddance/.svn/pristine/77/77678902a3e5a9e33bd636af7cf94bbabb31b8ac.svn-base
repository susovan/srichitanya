


//
//  SearchViewController.m
//  Cheer&Dance
//
//  Created by Madhava Reddy on 2/19/14.
//  Copyright (c) 2014 Adeptpros. All rights reserved.
//

#import "SearchViewController.h"
#import "ViewController.h"
#import "LoginViewController.h"
#import "JSON.h"
#import "Defines.h"
#import "AppDelegate.h"
#import "Singleton.h"
#import "JASidePanelController.h"
#import "ScheduleScreenViewController.h"

@interface SearchViewController ()

{
    NSDictionary *event_dicts;
    NSArray *sortedSession;
      NSDictionary *dict;

}

@end

@implementation SearchViewController

@synthesize aPopover,popView,view_SearchView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
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

-(IBAction)clearBtn_Clicked:(id)sender
{
    txt_Event.text=nil;
    txt_City.text=nil;
    txt_Location.text=nil;
    txt_Gym.text=nil;
    txt_Level.text=nil;
    txt_Team.text=nil;
}

-(void)dropDownMethod
{
 
// http://joomerang.geniusport.com/cheerinfinity/webservices/getwbs_loadsearch.php?json=[{"type":"","userid":"","event":"","city":"","date":"","gym":"","level":"","team":""}]
    
    //http://54.191.2.63/spiritcentral/webservices_dev/getwbs_loadsearch_malli.php?json=[{"userid":"1340","event":"181","date":"12-01-2014","session":"1","level":"","division":""}]

    
    [self showBusyView];
    
    CheckWebService=@"SearchDropdown_WebService";
    NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
    Singleton *s=[Singleton getObject];
    
   // [dct setObject:@"load" forKey:@"type"];
    
    [dct setObject:[s loginUserID] forKey:@"userid"];
    
    if(txt_Event.text.length==0 )
    {
        [dct setObject:@"" forKey:@"event"];
    }
    
    else
    {
        
        [dct setObject:IDS_Event forKey:@"event"];
    }
    
    if(txt_City.text.length==0 )
    {
        [dct setObject:@"" forKey:@"date"];
    }
    else
    {
       // [dct setObject:IDS_City forKey:@"city"];
        [dct setObject:[txt_City text] forKey:@"date"];
    }
    
    if(txt_Location.text.length==0 )
    {
        [dct setObject:@"" forKey:@"session"];
    }
    else
    {
        
        //[dct setObject:IDS_Date forKey:@"date"];
        
        NSString *str =txt_Location.text;
        NSString *str2=[str stringByReplacingOccurrencesOfString:@"Session-" withString:@""];
        
        
        [dct setObject:str2 forKey:@"session"];
    }
    
    if(txt_Team.text.length==0 )
    {
        [dct setObject:@"" forKey:@"team"];
    }
    else
    {
        
        [dct setObject:IDS_Team forKey:@"team"];
    }
    
    if(txt_Gym.text.length==0 )
    {
        [dct setObject:@"" forKey:@"level"];
    }
    else
    {
        
        [dct setObject:IDS_Gym forKey:@"level"];
    }
    
    if(txt_Level.text.length==0 )
    {
        [dct setObject:@"" forKey:@"division"];
    }
    else
    {
        
        [dct setObject:IDS_Level forKey:@"division"];
    }
    
    
    NSString *jsonstring1=[dct JSONRepresentation];
    NSLog(@"jsonstring=%@",jsonstring1);
    NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring1];
    ////NSLog(@"Post %@", post1);
    //change here loadsearch1.php to loadsearch.php
    NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_loadsearch_malli.php",BASEURL];//getwbs_loadsearch.php
    m_pWebService			= [[WebService alloc] initWebService:l_pURL];
    m_pWebService.mDelegate		= self;
    [m_pWebService  sendHTTPPost:post1];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    accessScreenArray=[[NSMutableArray alloc]init];
    accessScreenArray1=[[NSMutableArray alloc]init];

    //font
    [btn_Search.titleLabel setFont:[UIFont fontWithName:@"Enigmatic" size:20]];
    [btn_Clear.titleLabel setFont:[UIFont fontWithName:@"Enigmatic" size:20]];
    txt_Event.font=[UIFont fontWithName:@"Enigmatic" size:18];
    txt_City.font=[UIFont fontWithName:@"Enigmatic" size:18];
    txt_Date.font=[UIFont fontWithName:@"Enigmatic" size:18];
    txt_Team.font=[UIFont fontWithName:@"Enigmatic" size:18];
    txt_Location.font=[UIFont fontWithName:@"Enigmatic" size:18];
    txt_Level.font=[UIFont fontWithName:@"Enigmatic" size:18];
    txt_Gym.font=[UIFont fontWithName:@"Enigmatic" size:18];
    lbl_search_heading.font=[UIFont fontWithName:@"Enigmatic" size:26];
    
    // Search Popup
    
    //lbl_Event_Title.font=[UIFont fontWithName:@"Enigmatic" size:24];

    //color
    
     txt_Event.textColor=[UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:1.0];
     txt_City.textColor=[UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:1.0];
     txt_Date.textColor=[UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:1.0];
     txt_Team.textColor=[UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:1.0];
     txt_Location.textColor=[UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:1.0];
     txt_Level.textColor=[UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:1.0];
     txt_Gym.textColor=[UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:1.0];
     lbl_search_heading.textColor=[UIColor colorWithRed:250/250 green:250/250 blue:250/250 alpha:1.0];
    
    
    btn_Search.titleLabel.textColor=[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
    {
        
    }
    else
    {
       // navi_img.frame=CGRectMake(0, -20, 1024, 64);
       // lbl_search_heading.frame=CGRectMake(369, 19, 287, 36);
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
}
-(void)searchBigWebService
{
    
   // joomerang.geniusport.com/cheerinfinity/webservices/getwbs_searchresult1.php?json=[{"userid":"449","event":"1","city":"Pansacola","date":"2014-03-20","gym":"","level":"","team":""}]
    
    [self showBusyView];
    CheckWebService=@"SearchBig_WebService";
    NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];

    Singleton *s=[Singleton getObject];
    
    // [dct setObject:@"result" forKey:@"type"];
    [dct setObject:[s loginUserID] forKey:@"userid"];
    
    if(txt_Event.text.length==0 )
    {
        [dct setObject:@"" forKey:@"event"];
    }
    else
    {
        
        [dct setObject:IDS_Event forKey:@"event"];
        
    }
    
    if(txt_City.text.length==0 )
    {
        [dct setObject:@"" forKey:@"city"];
    }
    else
    {
        
//[dct setObject:IDS_City forKey:@"city"];
        [dct setObject:[txt_City text] forKey:@"city"];
        
    }
    if(txt_Location.text.length==0 )
    {
        [dct setObject:@"" forKey:@"date"];
    }
    else
    {
        
       // [dct setObject:IDS_Date forKey:@"date"];
         [dct setObject:txt_Location.text forKey:@"date"];
    }
    if(txt_Team.text.length==0 )
    {
        [dct setObject:@"" forKey:@"team"];
    }
    else
    {
        
        [dct setObject:IDS_Team forKey:@"team"];
    }
    if(txt_Gym.text.length==0 )
    {
        [dct setObject:@"" forKey:@"gym"];
    }
    else
    {
        
        [dct setObject:IDS_Gym forKey:@"gym"];
    }
    
    if(txt_Level.text.length==0 )
    {
        [dct setObject:@"" forKey:@"level"];
    }
    else
    {
        
        [dct setObject:IDS_Level forKey:@"level"];
    }
    

    
    NSString *jsonstring1=[dct JSONRepresentation];
    NSLog(@"jsonstring_search=%@",jsonstring1);
    NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring1];
    ////NSLog(@"Post %@", post1);
    
    NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_searchresult.php",BASEURL];
    m_pWebService			= [[WebService alloc] initWebService:l_pURL];
    m_pWebService.mDelegate		= self;
    [m_pWebService  sendHTTPPost:post1];
    

}
-(IBAction)btn_Search:(id)sender
{
    if([[txt_Event text]isEqualToString:@""] || [txt_Event text]==nil )
    {
        UIAlertView *vew=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Select The Event" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [vew show];
        
    }
    else if ([[txt_City text]isEqualToString:@""] || [txt_City text]==nil)
    {
        
        UIAlertView *vew=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Select The Date" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [vew show];

    
    }
//    else if ([[txt_Location text]isEqualToString:@""] ||[txt_Location text]==nil)
//    {
//        UIAlertView *vew=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Select The Session" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [vew show];
//
//    
//    }
    else// if([[txt_Team text]isEqualToString:@""] || [txt_Team text]==nil)
    {
        Singleton *s=[Singleton getObject];
        [s setTeam_id:nil];
        
        [lbl_Event_Title setText:[txt_Event text]];
        
        // send the screen ID to singletone
        
//        if ([accessScreenArray count]>=1)
//        {
//            [s setScreenID:[accessScreenArray objectAtIndex:0]];
//        }
//        else
        [s setScreenID:[accessScreenArray objectAtIndex:accessScreenArray.count-1]];
        
        
         [s setCheckleftpanelID:@"100"];
        
        // search result api call for checking data found or not
        
        
        [self showBusyView];
        CheckWebService=@"SearchBig_WebService_new";
        NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
        
        // [dct setObject:@"result" forKey:@"type"];
        [dct setObject:[s loginUserID] forKey:@"userid"];
        
        if([s event_Name1].length==0)
        {
            [dct setObject:@"" forKey:@"event"];
        }
        else
        {
            
            [dct setObject:[s event_ID1] forKey:@"event"];
        }
        
        if([s city_Name1].length==0 )
        {
            [dct setObject:@"" forKey:@"session"];
        }
        else
        {
            //[dct setObject:IDS_City forKey:@"city"];
            [dct setObject:[s city_Name1] forKey:@"session"];
            
        }
        if([s date_Name1].length==0 )
        {
            [dct setObject:@"" forKey:@"date"];
        }
        else
        {
            // [dct setObject:IDS_Date forKey:@"date"];
            [dct setObject:[s date_Name1] forKey:@"date"];
        }
        if([s team_Name1].length==0 )
        {
            [dct setObject:@"" forKey:@"team"];
        }
        else
        {
            [dct setObject:[s team_id1] forKey:@"team"];
        }
        if([s gym_Name1].length==0 )
        {
            [dct setObject:@"" forKey:@"level"];
        }
        else
        {
            [dct setObject:[s gym_id1] forKey:@"level"];
        }
        
        if([s level_Name1].length==0 )
        {
            [dct setObject:@"" forKey:@"division"];
        }
        else
        {
            [dct setObject:[s level_id1] forKey:@"division"];
        }
        
        NSString *jsonstring1=[dct JSONRepresentation];
        NSLog(@"jsonstring_search=%@",jsonstring1);
        NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring1];
        ////NSLog(@"Post %@", post1);
        
        NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_searchresult_malli.php",BASEURL];//getwbs_searchresult
        m_pWebService			= [[WebService alloc] initWebService:l_pURL];
        m_pWebService.mDelegate		= self;
        [m_pWebService  sendHTTPPost:post1];
        
        //////////
        
       // [self searchBigWebService];
        
    }
    /*
    else
    {
        Singleton *s=[Singleton getObject];
        [s setScreenID:@"1"];
         [s setCheckleftpanelID:@"100"];
        
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        [delegate CallSlide];
        [self presentViewController:delegate.viewController_leftPane animated:YES completion:NULL];
        
//        ViewController *obj=[[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
//        [self presentViewController:obj animated:YES completion:nil];
    }
*/
    
}
- (IBAction)btn_clicked_For_Search:(UIButton *)sender
{
    Singleton *s=[Singleton getObject];
    
    if([sender tag]==0)
    {
        if(!txt_Event.text.length==0)
        {
            
            txt_Event.text=nil;
        }
        
        txt_City.text=nil;
        txt_Location.text=nil;
        txt_Gym.text=nil;
        txt_Level.text=nil;
        
        [s setDate_Name1:@""];
        [s setDate_Name:@""];
        
        [s setCity_Name1:@""];
        [s setCity_Name:@""];
        
        [s setGym_Name:@""];
        [s setGym_Name1:@""];
        [s setGym_id1:@""];
        [s setGym_id:@""];
        
        [s setLevel_id1:@""];
        [s setLevel_id:@""];
        [s setLevel_Name1:@""];
        [s setLevel_Name:@""];
        
    }
    if([sender tag]==1)
    {
        
        if(!txt_City.text.length==0)
        {
            
            txt_City.text=nil;
        }
        //txt_City.text=nil;
        txt_Location.text=nil;
        txt_Gym.text=nil;
        txt_Level.text=nil;
        //[s setDate_Name1:@""];
        //[s setDate_Name:@""];
        
        [s setCity_Name1:@""];
        [s setCity_Name:@""];
        
        [s setGym_Name:@""];
        [s setGym_Name1:@""];
        [s setGym_id1:@""];
        [s setGym_id:@""];
        
        [s setLevel_id1:@""];
        [s setLevel_id:@""];
        [s setLevel_Name1:@""];
        [s setLevel_Name:@""];
        

    }
    
    
    if([sender tag]==2)
    {
        if(!txt_Location.text.length==0)
        {
            
            txt_Location.text=nil;
        }
        //txt_City.text=nil;
        //txt_Location.text=nil;
        txt_Gym.text=nil;
        txt_Level.text=nil;
        
        [s setGym_Name:@""];
        [s setGym_Name1:@""];
        [s setGym_id1:@""];
        [s setGym_id:@""];
        
        [s setLevel_id1:@""];
        [s setLevel_id:@""];
        [s setLevel_Name1:@""];
        [s setLevel_Name:@""];

    }
    if([sender tag]==3)
    {
        if(!txt_Team.text.length==0)
        {
            
            txt_Team.text=nil;
        }
        //txt_City.text=nil;
        //txt_Location.text=nil;
        //txt_Gym.text=nil;
        //txt_Level.text=nil;
    }

    
    if([sender tag]==4)
    {
        if(!txt_Gym.text.length==0)
        {
            
            txt_Gym.text=nil;
        }
        txt_Level.text=nil;
        
        [s setLevel_id1:@""];
        [s setLevel_id:@""];
        [s setLevel_Name1:@""];
        [s setLevel_Name:@""];
        
    }
    if([sender tag]==5)
    {
        if(!txt_Level.text.length==0)
        {
            
            txt_Level.text=nil;
        }
    }
   
    
    switch( [sender tag])
    {
            
        case 0:
        {
            [self dropDownMethod];
            
            Tag_dropdown=(int)[sender tag];
            [pickview removeFromSuperview];
            // [categPicker removeFromSuperview];
            pickview =[[UIPickerView alloc]initWithFrame:CGRectMake(0,44, 350 , 250)];
            // pickview.backgroundColor=[UIColor clearColor];
            [picker_uiview addSubview:pickview];
            
            
            
            pickview.tag=[sender tag];
            [pickview setShowsSelectionIndicator:YES];
            
            
                    break;
            
        }
            
        case 1:
        {
            if([[txt_Event text]isEqualToString:@""] || [txt_Event text]==nil )
            {
                UIAlertView *vew=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Select The Event" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [vew show];
                
            }
            else
            {
            
            [self dropDownMethod];
            
            Tag_dropdown=(int)[sender tag];
            [pickview removeFromSuperview];
            // [categPicker removeFromSuperview];
            pickview =[[UIPickerView alloc]initWithFrame:CGRectMake(0,44, 350 , 250)];
            // pickview.backgroundColor=[UIColor clearColor];
            [picker_uiview addSubview:pickview];

            
            pickview.tag=[sender tag];
            [pickview setShowsSelectionIndicator:YES];
            
           
            }
          
            
            break;
        }
        case 2:
        {
            if([[txt_Event text]isEqualToString:@""] || [txt_Event text]==nil )
            {
                UIAlertView *vew=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Select The Event" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [vew show];
                
            }else if ([[txt_City text]isEqualToString:@""] || [txt_City text]==nil)
            {
                
                UIAlertView *vew=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Select The Date" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [vew show];
                
                
            }
           
            else
            {
            [self dropDownMethod];
            
            Tag_dropdown=(int)[sender tag];
            [pickview removeFromSuperview];
            // [categPicker removeFromSuperview];
            pickview =[[UIPickerView alloc]initWithFrame:CGRectMake(0,44, 350 , 250)];
            // pickview.backgroundColor=[UIColor clearColor];
            [picker_uiview addSubview:pickview];

            
            pickview.tag=[sender tag];
            [pickview setShowsSelectionIndicator:YES];
            
            }
            
           
            
            break;
        }

            
        case 3:
        {
        
            if([[txt_Event text]isEqualToString:@""] || [txt_Event text]==nil )
            {
                UIAlertView *vew=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Select The Event" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [vew show];
                
            }else if ([[txt_City text]isEqualToString:@""] || [txt_City text]==nil)
            {
                
                UIAlertView *vew=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Select The Date" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [vew show];
                
                
            }
//            else if ([[txt_Location text]isEqualToString:@""] ||[txt_Location text]==nil)
//            {
//                UIAlertView *vew=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Select The Session" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//                [vew show];
//                
//                
//            }

            else
            {
                [self dropDownMethod];
                
                Tag_dropdown=(int)[sender tag];
                [pickview removeFromSuperview];
                // [categPicker removeFromSuperview];
                pickview =[[UIPickerView alloc]initWithFrame:CGRectMake(0,44, 350 , 250)];
                // pickview.backgroundColor=[UIColor clearColor];
                [picker_uiview addSubview:pickview];
                
                
            pickview.tag=[sender tag];
            [pickview setShowsSelectionIndicator:YES];
            
            }
            
            break;
        }
        case 4:
        {
            if([[txt_Event text]isEqualToString:@""] || [txt_Event text]==nil )
            {
                UIAlertView *vew=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Select The Event" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [vew show];
                
            }else if ([[txt_City text]isEqualToString:@""] || [txt_City text]==nil)
            {
                
                UIAlertView *vew=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Select The Date" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [vew show];
                
                
            }
//            else if ([[txt_Location text]isEqualToString:@""] ||[txt_Location text]==nil)
//            {
//                UIAlertView *vew=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Select The Session" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//                [vew show];
//                
//                
//            }

            else
            {
                
                if ([[txt_Location text]isEqualToString:@""] ||[txt_Location text]==nil)
                {
                    UIAlertView *vew=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Select The Session" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [vew show];
                    
                    
                }
                else
                {
                    [self dropDownMethod];
                    
                    Tag_dropdown=(int)[sender tag];
                    [pickview removeFromSuperview];
                    // [categPicker removeFromSuperview];
                    pickview =[[UIPickerView alloc]initWithFrame:CGRectMake(0,44, 350 , 250)];
                    // pickview.backgroundColor=[UIColor clearColor];
                    [picker_uiview addSubview:pickview];
                    
                    
                    pickview.tag=[sender tag];
                    [pickview setShowsSelectionIndicator:YES];
                    
                }
                
            
            }
            
                      break;
        }
        case 5:
        {
        if([[txt_Event text]isEqualToString:@""] || [txt_Event text]==nil )
        {
            UIAlertView *vew=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Select The Event" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [vew show];
            
        }
        else if ([[txt_City text]isEqualToString:@""] || [txt_City text]==nil)
        {
            
            UIAlertView *vew=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Select The Date" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [vew show];
            
            
        }
//        else if ([[txt_Location text]isEqualToString:@""] ||[txt_Location text]==nil)
//        {
//            UIAlertView *vew=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Select The Session" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//            [vew show];
//            
//            
//        }

            else
            {
                
                if ([[txt_Location text]isEqualToString:@""] ||[txt_Location text]==nil)
                {
                    UIAlertView *vew=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Select The Session" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [vew show];
                    
                    
                }
                
                else
                {
                    [self dropDownMethod];
                    
                    Tag_dropdown=(int)[sender tag];
                    [pickview removeFromSuperview];
                    // [categPicker removeFromSuperview];
                    pickview =[[UIPickerView alloc]initWithFrame:CGRectMake(0,44, 350 , 250)];
                    // pickview.backgroundColor=[UIColor clearColor];
                    [picker_uiview addSubview:pickview];
                    
                    
                    pickview.tag=[sender tag];
                    [pickview setShowsSelectionIndicator:YES];
                    
                }
                
           
                
            }
           
            
                        break;
        }
    }
        
    
    
}

-(IBAction)btn_Done_From_pickerView:(id)sender
{
    
       Singleton *s=[Singleton getObject];
    
    int rowselect=(int)[pickview selectedRowInComponent:0];
    
    if (pickview.tag==0)
    {
        if([ar_Events_Names count]==0)
        {
            
            
        }
        else
        {
        
            NSLog(@"%d",rowselect);
        txt_Event.text=[ar_Events_Names objectAtIndex:rowselect];
            
            
            
            for(int i=0;i<[AftersortedAryIDS count];i++)
            {
                if([[[dict objectForKey:@"event"]objectForKey:[AftersortedAryIDS objectAtIndex:i]]isEqualToString:[txt_Event text]])
                {
                    
                    IDS_Event=[AftersortedAryIDS objectAtIndex:i];
                    
                    [s setEvent_Name:[txt_Event text]];
                    [s setEvent_ID:IDS_Event];
                    
                    [s setEvent_Name1:[txt_Event text]];
                    [s setEvent_ID1:[AftersortedAryIDS objectAtIndex:i]];
                    
                }
                
            }
            
        }
    }
    else if (pickview.tag==1)
    {
        
        if([ar_Events_Names count]==0)
        {
            
            
        }
        else
        {
            
        NSLog(@"%d",rowselect);
        txt_City.text=[ar_Events_Names objectAtIndex:rowselect];
            
            
            for(int i=0;i<[AftersortedAryIDS count];i++)
            {
                if([[[dict objectForKey:@"date"]objectForKey:[AftersortedAryIDS objectAtIndex:i]]isEqualToString:[txt_City text]])
                {
                    
                    IDS_Date=[AftersortedAryIDS objectAtIndex:i];
                    
                    [s setDate_Name:[txt_City text]];
                    
                    [s setDate_Name1:[txt_City text]];
                    
                }
                
                
            }
        }
    }
    else if (pickview.tag==2)
    {
        if([ar_Events_Names count]==0)
        {
            
            
        }
        else
        {
        txt_Location.text=[NSString stringWithFormat:@"Session-%@",[ar_Events_Names objectAtIndex:rowselect]];
            
            for(int i=0;i<[AftersortedAryIDS count];i++)
            {
                if([[[dict objectForKey:@"session"]objectForKey:[AftersortedAryIDS objectAtIndex:i]]isEqualToString:[[txt_Location text] stringByReplacingOccurrencesOfString:@"Session-" withString:@""]])
                {
                    
                    IDS_Date=[AftersortedAryIDS objectAtIndex:i];
                    [s setCity_Name1:[[txt_Location text] stringByReplacingOccurrencesOfString:@"Session-" withString:@""]];
                    
                    [s setCity_Name:[[txt_Location text] stringByReplacingOccurrencesOfString:@"Session-" withString:@""]];
                    
                    
                }
                
            }
        }
        
    }
    else if (pickview.tag==3)
    {
        if([ar_Events_Names count]==0)
        {
        
        
        }
        else
        {
            txt_Team.text=[sortedArray objectAtIndex:rowselect];
           
        [s setAr_Team_Names:[[NSMutableArray alloc]initWithArray:sortedArray]];
        [s setAr_Team_ids:[[NSMutableArray alloc]initWithArray:AftersortedAryIDS]];
        NSLog(@"rowselect is==%@",[s ar_Team_ids]);
            
            for(int i=0;i<[AftersortedAryIDS count];i++)
            {
                if([[[dict objectForKey:@"team"]objectForKey:[AftersortedAryIDS objectAtIndex:i]]isEqualToString:[txt_Team text]])
                {
                    
                    IDS_Team=[AftersortedAryIDS objectAtIndex:i];
                    [s setTeam_Name:[txt_Team text]];
                    [s setTeam_id:[ar_Team_sortedId objectAtIndex:i]];
                    
                    [s setTeam_Name1:[txt_Team text]];
                    [s setTeam_id1:[ar_Team_sortedId objectAtIndex:i]];
                    
                }
                
            }
       
        }
        

}
    else if (pickview.tag==4)
    {

        if([ar_Events_Names count]==0)
        {
        }
        else
        {
        txt_Gym.text=[ar_Events_Names objectAtIndex:rowselect];
             IDS_Gym=[AftersortedAryIDS objectAtIndex:rowselect];
            
            for(int i=0;i<[AftersortedAryIDS count];i++)
            {
                if([[[dict objectForKey:@"level"]objectForKey:[AftersortedAryIDS objectAtIndex:i]]isEqualToString:[txt_Gym text]])
                {
                    IDS_Gym=[AftersortedAryIDS objectAtIndex:i];
                    
                    [s setGym_id:[AftersortedAryIDS objectAtIndex:i]];
                    [s setGym_Name:[txt_Gym text]];
                    
                    [s setGym_id1:[AftersortedAryIDS objectAtIndex:i]];
                    [s setGym_Name1:[txt_Gym text]];
                    
                }
                
            }
        }
    }
    else if (pickview.tag==5)
    {
        if([ar_Events_Names count]==0)
        {
            
        }
        else
        {
            
            txt_Level.text=[ar_Events_Names objectAtIndex:rowselect];
            
            for(int i=0;i<[AftersortedAryIDS count];i++)
            {
                if([[[dict objectForKey:@"division"]objectForKey:[AftersortedAryIDS objectAtIndex:i]]isEqualToString:[txt_Level text]])
                {
                    IDS_Level=[AftersortedAryIDS objectAtIndex:i];
                    [s setLevel_id:[AftersortedAryIDS objectAtIndex:i]];
                    [s setLevel_Name:[txt_Level text]];
                    
                    [s setLevel_id1:[AftersortedAryIDS objectAtIndex:i]];
                    [s setLevel_Name1:[txt_Level text]];
                    
                }
                
            }
        }
      
        
    }
    
    [pickview removeFromSuperview];
    [self.aPopover dismissPopoverAnimated:YES];
    [self.popView dismissModalViewControllerAnimated:YES];
    
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    
    switch ([pickerView tag]) {
        case 0:
            return  [ar_Events_Names count];
            break;
            
        case 1:
            return [ar_Events_Names count];
            break;
        case 2:
        {
            return [ar_Events_Names count];
            //NSLog(@"value==%d",[teamArray count]);
            break;
        }
        case 3:
            return [ar_Events_Names count];
            break;
            
        case 4:
            return [ar_Events_Names count];
            break;
            
        case 5:
            return [ar_Events_Names count];
            break;
            
        
    }
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *retval = (id)view;
    if (!retval) {
        retval= [[UILabel alloc] init];//WithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
    }
    retval.textAlignment = UITextAlignmentCenter;
    retval.textColor=[UIColor colorWithRed:56.0/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];
       retval.font=[UIFont fontWithName:@"Enigmatic" size:18];

    //retval.textColor =[UIColor whiteColor];
    switch([pickerView tag])
    {
        case 0:
        {
            retval.textAlignment = UITextAlignmentCenter;
            //retval.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
            retval.text= [ar_Events_Names objectAtIndex:row];
            
            break;
        }
        case 1:
            
        {
            //retval.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
            retval.text= [ar_Events_Names objectAtIndex:row];
            break;
            
        }
        case 2:
        {
           // retval.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
            retval.text= [NSString stringWithFormat:@"Session-%@",[ar_Events_Names objectAtIndex:row]];
            break;
            
        }
        case 3:
        {
            //retval.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
            retval.text= [sortedArray objectAtIndex:row];
            break;
            
        }
        case 4:
        {
            retval.textAlignment = UITextAlignmentCenter;
            //retval.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
            retval.text= [ar_Events_Names objectAtIndex:row];
            
            break;
        }
            
        case 5:
        {
            retval.textAlignment = UITextAlignmentCenter;
            //retval.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
            retval.text= [ar_Events_Names objectAtIndex:row];
            
            break;
        }

    }
    return retval;
}

-(IBAction)logoutBtn_Clicked_frmSearch:(id)sender
{
    logoutAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"Do you want to Logout?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [logoutAlert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView==logoutAlert)
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
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        [self hideBusyView];
        
        NSString *json_string = [[NSString alloc] initWithData:m_pWebService.m_pHTTPRsp encoding:NSUTF8StringEncoding];
        NSDictionary *results = [json_string JSONValue];
        NSLog(@"Result= %@",results);
        // NSArray *aaa= [json_string JSONValue];
        
        
        if([CheckWebService isEqualToString:@"SearchDropdown_WebService"])
        {
            
            
            sortedArray=[[NSMutableArray alloc]init];
            sortedArrayIDS=[[NSMutableArray alloc]init];
            ar_Team_id=[[NSMutableArray alloc]init];
            dict=[results objectForKey:@"Search_Components"];
            
            if([[dict objectForKey:@"msg"]isEqualToString:@"Successful"])
            {
            
            if(Tag_dropdown==0)
            {
                
                NSDictionary *dict_event=[dict objectForKey:@"event"];
                [dict_event enumerateKeysAndObjectsUsingBlock:^(id key,id obj,BOOL *stop){
                    
                    [sortedArray addObject:obj];
                    [sortedArrayIDS addObject:key];
                }];
                
               
                
                
                self.popView = [[UIViewController alloc]init];
                [self.popView.view addSubview:picker_uiview];
                self.aPopover = [[UIPopoverController alloc]initWithContentViewController:self.popView];
                self.aPopover.delegate=self;
                self.aPopover.popoverContentSize=picker_uiview.frame.size;
                [self.aPopover presentPopoverFromRect:btn_Event.frame inView:Scroll_search
                             permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
                

                
            }
            else if(Tag_dropdown==1)
            {
                
                NSDictionary *dict_event=[dict objectForKey:@"date"];
                [dict_event enumerateKeysAndObjectsUsingBlock:^(id key,id obj,BOOL *stop){
                    
                    [sortedArray addObject:obj];
                    [sortedArrayIDS addObject:key];
                }];
                
                 accessScreenArray=[[dict objectForKey:@"judgement_pages"] objectForKey:IDS_Event];
                Singleton *s=[Singleton getObject];
                [s setAccessScreenArray:accessScreenArray];
                
                
               NSString *str=[[dict objectForKey:@"head_judge"] objectForKey:IDS_Event];
                
                [accessScreenArray1 addObject:str];
                 
                [s setAccessScreenArray1:accessScreenArray1];
            
                
                self.popView = [[UIViewController alloc]init];
                [self.popView.view addSubview:picker_uiview];
                self.aPopover = [[UIPopoverController alloc]initWithContentViewController:self.popView];
                self.aPopover.delegate=self;
                self.aPopover.popoverContentSize=picker_uiview.frame.size;
                [self.aPopover presentPopoverFromRect:btn_City.frame inView:Scroll_search
                             permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            }
            else if(Tag_dropdown==2)
            {
                
                NSDictionary *dict_event=[dict objectForKey:@"session"];
                [dict_event enumerateKeysAndObjectsUsingBlock:^(id key,id obj,BOOL *stop){
                    
                    [sortedArray addObject:obj];
                    [sortedArrayIDS addObject:key];
                }];
                
                self.popView = [[UIViewController alloc]init];
                [self.popView.view addSubview:picker_uiview];
                self.aPopover = [[UIPopoverController alloc]initWithContentViewController:self.popView];
                self.aPopover.delegate=self;
                self.aPopover.popoverContentSize=picker_uiview.frame.size;
                [self.aPopover presentPopoverFromRect:btn_Date.frame inView:Scroll_search
                             permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
                
            }
            else if(Tag_dropdown==3)
            {
                NSDictionary *dict_event=[dict objectForKey:@"level"];
                
                
                NSArray *ars=[[dict_event allKeys]sortedArrayUsingComparator:^NSComparisonResult(id obj1,id obj2) {
                if([obj1 integerValue]>[obj2 integerValue])
                {
                    return NSOrderedDescending;
                
                }
                else
                {
                    return NSOrderedAscending;
                }
                }];
                
                for(int i=0;i<[ars count];i++)
                {
                    [sortedArray addObject:[dict_event objectForKey:[ars objectAtIndex:i]]];
                    
                    NSLog(@"%@",sortedArray);
                    
                   [ar_Team_id addObject:[[dict_event allKeys]objectAtIndex:i]];
                   [sortedArrayIDS addObject:[[dict_event allKeys]objectAtIndex:i]];
                                
                }
                
                
                self.popView = [[UIViewController alloc]init];
                [self.popView.view addSubview:picker_uiview];
                self.aPopover = [[UIPopoverController alloc]initWithContentViewController:self.popView];
                self.aPopover.delegate=self;
                self.aPopover.popoverContentSize=picker_uiview.frame.size;
                [self.aPopover presentPopoverFromRect:btn_Team.frame inView:Scroll_search
                             permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
                

                
                
            }
            else if(Tag_dropdown==4)
            {
                
                NSDictionary *dict_event=[dict objectForKey:@"level"];
                [dict_event enumerateKeysAndObjectsUsingBlock:^(id key,id obj,BOOL *stop){
                    
                    [sortedArray addObject:obj];
                    [sortedArrayIDS addObject:key];
                
                }];
                
                self.popView = [[UIViewController alloc]init];
                [self.popView.view addSubview:picker_uiview];
                self.aPopover = [[UIPopoverController alloc]initWithContentViewController:self.popView];
                self.aPopover.delegate=self;
                self.aPopover.popoverContentSize=picker_uiview.frame.size;
                [self.aPopover presentPopoverFromRect:btn_Gym.frame inView:Scroll_search
                             permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
                

                
                
            }
            else if(Tag_dropdown==5)
            {
                
                NSDictionary *dict_event=[dict objectForKey:@"division"];
                [dict_event enumerateKeysAndObjectsUsingBlock:^(id key,id obj,BOOL *stop){
                    
                    [sortedArray addObject:obj];
                    [sortedArrayIDS addObject:key];
                    
                }];
                
                self.popView = [[UIViewController alloc]init];
                [self.popView.view addSubview:picker_uiview];
                self.aPopover = [[UIPopoverController alloc]initWithContentViewController:self.popView];
                self.aPopover.delegate=self;
                self.aPopover.popoverContentSize=picker_uiview.frame.size;
                [self.aPopover presentPopoverFromRect:btn_Level.frame inView:Scroll_search
                             permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
                

                
            }
            ar_Events_Names=[sortedArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
            ar_Team_sortedId= [ar_Team_id sortedArrayUsingComparator:^NSComparisonResult(id obj1,id obj2){
                if([obj1 integerValue]>[obj2 integerValue])
                {
                    return (NSComparisonResult)NSOrderedDescending;
                
                }
                    else if([obj1 integerValue]<[obj2 integerValue])
                    {
                    
                        return (NSComparisonResult)NSOrderedAscending;
                    
                    }
                    else
                    {
                        return (NSComparisonResult)NSOrderedSame;
                    
                    }
                
                }];
                
                AftersortedAryIDS= [sortedArrayIDS sortedArrayUsingComparator:^NSComparisonResult(id obj1,id obj2){
                    if([obj1 integerValue]>[obj2 integerValue])
                    {
                        return (NSComparisonResult)NSOrderedDescending;
                        
                    }
                    else if([obj1 integerValue]<[obj2 integerValue])
                    {
                        
                        return (NSComparisonResult)NSOrderedAscending;
                        
                    }
                    else
                    {
                        return (NSComparisonResult)NSOrderedSame;
                        
                    }
                    
                }];
                
            pickview.dataSource=self;
            pickview.delegate=self;
        }
        
            else
            {
                UIAlertView *vew=[[UIAlertView alloc]initWithTitle:@"" message:@"No Data Found" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [vew show];
            
            }
        }
        
        
        else if([CheckWebService isEqualToString:@"SearchBig_WebService"])
        {
            
          event_dicts=[results objectForKey:@"Search_Result"];
            
            NSString *checkStr=[event_dicts objectForKey:@"msg"];
            
            if([checkStr isEqualToString:@"Successful"])
            {
            
                //setting event title
                lbl_Event_Title.text=[event_dicts objectForKey:@"event_name"];
                
                NSDictionary *dict=[event_dicts objectForKey:@"sessions"];
                
                NSArray *unSortedSession=[dict allKeys];
                
              sortedSession=[unSortedSession  sortedArrayUsingSelector:@selector(compare:)];
                
                if(floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
                {
                 myTableView = [[UITableView alloc]initWithFrame:CGRectMake(20, 88, 984, 567) style:UITableViewStylePlain];
                
                }
                else
                {
                     myTableView = [[UITableView alloc]initWithFrame:CGRectMake(20, 88, 984, 547) style:UITableViewStylePlain];
                
                }
           
               
                [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                myTableView.dataSource=self;
                myTableView.delegate=self;
                 [view_SearchView addSubview:myTableView];
                [[self view]addSubview:view_SearchView];
                               
                NSLog(@"%@==",[[self view]subviews]);
                
            }
            else
            {
                UIAlertView *vew=[[UIAlertView alloc]initWithTitle:@"" message:@"No Data Found" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [vew show];
            }
        }
        
        
        else if([CheckWebService isEqualToString:@"TeamList_WebService"])
        {
            NSDictionary *Team_dicts=[results objectForKey:@"teamlist"];
            
            NSString *checkStr=[Team_dicts objectForKey:@"msg"];
            
            if([checkStr isEqualToString:@"Successfull"])
            {
                ar_teams=[[NSMutableArray alloc]init];
                ar_teams_Names=[[NSMutableArray alloc]init];
                ar_teams_IDs=[[NSMutableArray alloc]init];
                
                ar_teams=[Team_dicts objectForKey:@"result"];
                NSLog(@"ar_teams_Count=%d",[ar_teams count]);
                
                for (int i=0; i<[ar_teams count]; i++) {
                    
                    [ar_teams_Names addObject:[[ar_teams objectAtIndex:i] objectForKey:@"team_name"]];
                    [ar_teams_IDs addObject:[[ar_teams objectAtIndex:i] objectForKey:@"team_id"]];
                    
                }
               
               Singleton *s=[Singleton getObject];
               [s setAr_Team_Names:[[NSMutableArray alloc]initWithArray:ar_teams_Names]];
               [s setAr_Team_ids:[[NSMutableArray alloc]initWithArray:ar_teams_IDs]];
                
                AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
                [delegate CallSlide];
               [self presentViewController:delegate.viewController_leftPane animated:YES completion:NULL];
                
//                ViewController *obj=[[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
//                [self presentViewController:obj animated:YES completion:nil];
            
            }
            else
            {
                UIAlertView *vew=[[UIAlertView alloc]initWithTitle:@"" message:@"No Data Found" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [vew show];
            }
        }
        
        else if ([CheckWebService isEqualToString:@"SearchBig_WebService_new"])
        {
            NSMutableDictionary *dict1=[results objectForKey:@"Search_Result"];
            
            if ([[dict1 objectForKey:@"msg"]isEqualToString:@"Successful"])
            {
                if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
                {
                    
                    ScheduleScreenViewController *obj=[[ScheduleScreenViewController alloc]initWithNibName:@"ScheduleScreenViewController" bundle:nil];
                    [obj setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
                    [self presentViewController:obj animated:YES completion:nil];
                }
                else
                {
                    ScheduleScreenViewController *obj=[[ScheduleScreenViewController alloc]initWithNibName:@"ScheduleScreenViewController_ios6" bundle:nil];
                    [obj setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
                    [self presentViewController:obj animated:YES completion:nil];
                }
                
                
            }
            else
            {
                
                UIAlertView *vew=[[UIAlertView alloc]initWithTitle:@"" message:@"No Data Found" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [vew show];
            }
            
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
    
    if(status == NotReachable)
    {
    UIAlertView *alert2=[[UIAlertView alloc] initWithTitle:@"" message:@"Please check your Wi-Fi or 3G connection and try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert2 show];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSDictionary *dict=[event_dicts objectForKey:@"sessions"];
    return [[dict objectForKey:[sortedSession objectAtIndex:section]] count];
  
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return [sortedSession count];
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
      
    
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0,0,300,150)];
   // customView.backgroundColor=[UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor =[UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
    headerLabel.font = [UIFont fontWithName:@"Enigmatic" size:18];
    headerLabel.textAlignment=NSTextAlignmentCenter;
    headerLabel.frame = CGRectMake(16,0,185,30);
    NSLog(@"%@"  ,[event_dicts objectForKey:@"sessions"]);
    headerLabel.text = [sortedSession objectAtIndex:section];
                          headerLabel.textColor = [UIColor whiteColor];
                        [customView addSubview:headerLabel];
    
    UILabel *headerLabel1 = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel1.backgroundColor =[UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
    headerLabel1.font = [UIFont fontWithName:@"Enigmatic" size:18];
        headerLabel1.textAlignment=NSTextAlignmentCenter;
    headerLabel1.frame = CGRectMake(207,0,133,30);
    headerLabel1.text =  @"City/State";
    headerLabel1.textColor = [UIColor whiteColor];
    [customView addSubview:headerLabel1];
    
    UILabel *headerLabel2 = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel2.backgroundColor = [UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
    headerLabel2.font = [UIFont fontWithName:@"Enigmatic" size:18];
        headerLabel2.textAlignment=NSTextAlignmentCenter;
    headerLabel2.frame = CGRectMake(349,0,333,30);
    headerLabel2.text =  @"Division";
    headerLabel2.textColor = [UIColor whiteColor];
    [customView addSubview:headerLabel2];
    

    UILabel *headerLabel3 = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel3.backgroundColor = [UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
    headerLabel3.font = [UIFont fontWithName:@"Enigmatic" size:18];
        headerLabel3.textAlignment=NSTextAlignmentCenter;
    headerLabel3.frame = CGRectMake(700,0,85,30);
    headerLabel3.text =  @"WarmUp";
    headerLabel3.textColor = [UIColor whiteColor];
    [customView addSubview:headerLabel3];
    

    UILabel *headerLabel4 = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel4.backgroundColor =[UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
    headerLabel4.font = [UIFont fontWithName:@"Enigmatic" size:18];
        headerLabel4.textAlignment=NSTextAlignmentCenter;
    headerLabel4.frame = CGRectMake(794,0,85,30);
    headerLabel4.text =  @"Perform";
    headerLabel4.textColor = [UIColor whiteColor];
    [customView addSubview:headerLabel4];

    UILabel *headerLabel5 = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel5.backgroundColor = [UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
     headerLabel5.font = [UIFont fontWithName:@"Enigmatic" size:18];
        headerLabel5.textAlignment=NSTextAlignmentCenter;
    headerLabel5.frame = CGRectMake(892,0,85,30);
    headerLabel5.text =  @"Floor";
    headerLabel5.textColor = [UIColor whiteColor];
    [customView addSubview:headerLabel5];
    
    return customView;
    

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    static NSString *cellIdentifier=@"Cell";
    SearchCell *cell=[myTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell==nil)
    {
       NSArray *ar=   [[NSBundle mainBundle]loadNibNamed:@"SearchCell" owner:self options:nil];
        
        cell=[ar objectAtIndex:0];
    
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    NSDictionary *dictt=[event_dicts objectForKey:@"sessions"];
    
    cell.lbl_Team_Name.text=[[[dictt objectForKey:[sortedSession objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectForKey:@"team_name"];
    cell.lbl_City_Name.text=[[[dictt objectForKey:[sortedSession objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectForKey:@"location"];
    cell.lbl_Divison_Name.text=[[[dictt objectForKey:[sortedSession objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectForKey:@"division"];
    cell.lbl_WarmUp_Time.text=[[[dictt objectForKey:[sortedSession objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectForKey:@"warmup_time"];
    cell.lbl_Perform_Time.text=[[[dictt objectForKey:[sortedSession objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectForKey:@"perform_time"];
    cell.lbl_Floor_Name.text=[[[dictt objectForKey:[sortedSession objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectForKey:@"panel_num"];
    
    cell.lbl_Team_Name.font=[UIFont fontWithName:@"Enigmatic" size:18];
    cell.lbl_City_Name.font=[UIFont fontWithName:@"Enigmatic" size:18];
    cell.lbl_Divison_Name.font=[UIFont fontWithName:@"Enigmatic" size:18];
    cell.lbl_WarmUp_Time.font=[UIFont fontWithName:@"Enigmatic" size:18];
    cell.lbl_Perform_Time.font=[UIFont fontWithName:@"Enigmatic" size:18];
    cell.lbl_Floor_Name.font=[UIFont fontWithName:@"Enigmatic" size:18];
    
    cell.lbl_Team_Name.textColor=[UIColor colorWithRed:56.0/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];
    cell.lbl_City_Name.textColor=[UIColor colorWithRed:56.0/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];
    cell.lbl_Divison_Name.textColor=[UIColor colorWithRed:56.0/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];
    cell.lbl_WarmUp_Time.textColor=[UIColor colorWithRed:56.0/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];
    cell.lbl_Perform_Time.textColor=[UIColor colorWithRed:56.0/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];
    cell.lbl_Floor_Name.textColor=[UIColor colorWithRed:56.0/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Singleton *s=[Singleton getObject];
      NSDictionary *dictt=[event_dicts objectForKey:@"sessions"];
    [s setTeam_Name:[[[dict objectForKey:[sortedSession objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectForKey:@"team_name"]];
    [s setTeam_id:[[[dictt objectForKey:[sortedSession objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectForKey:@"team_id"]];
    
    [s setGym_Name:[[[dictt objectForKey:[sortedSession objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectForKey:@"division"]];
    [s setLevel_Name:[[[dictt objectForKey:[sortedSession objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectForKey:@"team_level"]];
    

    ///////
    
    /*[self showBusyView];
    CheckWebService=@"TeamList_WebService";
    NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
    
    [dct setObject:[s loginUserID] forKey:@"userid"];
    [dct setObject:[event_dicts objectForKey:@"event_id"] forKey:@"eventid"];

    [dct setObject:[event_dicts objectForKey:@"event_date"] forKey:@"eventdate"];
    [dct setObject:txt_City.text forKey:@"eventcity"];
    [dct setObject:[[[dictt objectForKey:[sortedSession objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectForKey:@"gym_id"] forKey:@"gym"];
  
    
    
    NSString *jsonstring1=[dct JSONRepresentation];
    ////NSLog(@"jsonstring=%@",jsonstring1);
    NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring1];
    ////NSLog(@"Post %@", post1);
    
    NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_teamlist.php",BASEURL];
    m_pWebService			= [[WebService alloc] initWebService:l_pURL];
    m_pWebService.mDelegate		= self;
    [m_pWebService  sendHTTPPost:post1];*/
    
}
-(IBAction)btn_BackFromBigSearch:(id)sender
{

    [view_SearchView removeFromSuperview];

}
@end
