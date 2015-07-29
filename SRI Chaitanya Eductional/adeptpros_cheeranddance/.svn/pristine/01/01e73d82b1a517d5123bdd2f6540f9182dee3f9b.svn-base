

//
//  ScheduleScreenViewController.m
//  Cheer&Dance
//
//  Created by Madhava Reddy on 4/5/14.
//  Copyright (c) 2014 Adeptpros. All rights reserved.
//

#import "ScheduleScreenViewController.h"
#import "AppDelegate.h"
#import "Singleton.h"
#import "JSON.h"
#import "Defines.h"
#import "JASidePanelController.h"
#import "SearchViewController.h"
#import "ViewController.h"

@interface ScheduleScreenViewController ()
{
    NSDictionary *event_dicts;
    NSArray *sortedSession;
    
}
@end


@implementation ScheduleScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    lbl_Event_Title.font=[UIFont fontWithName:@"Enigmatic" size:24];
    lbl_dateHeading.font=[UIFont fontWithName:@"Enigmatic" size:18];
    
    lbl_team.font=[UIFont fontWithName:@"Enigmatic" size:18];
    lbl_city.font=[UIFont fontWithName:@"Enigmatic" size:18];
    lbl_level.font=[UIFont fontWithName:@"Enigmatic" size:18];
    lbl_perform.font=[UIFont fontWithName:@"Enigmatic" size:18];
    lbl_warmup.font=[UIFont fontWithName:@"Enigmatic" size:18];
    lbl_floor.font=[UIFont fontWithName:@"Enigmatic" size:18];


    
    Singleton *st=[Singleton getObject];
    lbl_dateHeading.text=[NSString stringWithFormat:@"%@",[st date_Name]];
    
    
    [self searchBigWebService];
    
}
-(void)searchBigWebService
{
    //joomerang.geniusport.com/cheerinfinity/webservices_prod/getwbs_searchresult.php?json=[{"team":"","level":"","userid":"41","city":"Pensacola","date":"05-08-2014","event":"8","gym":""}]
    
    // joomerang.geniusport.com/cheerinfinity/webservices/getwbs_searchresult1.php?json=[{"userid":"449","event":"1","city":"Pansacola","date":"2014-03-20","gym":"","level":"","team":""}]
    
    
    [self showBusyView];
    CheckWebService=@"SearchBig_WebService";
    NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
    
    Singleton *s=[Singleton getObject];
    
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
        
        if([CheckWebService isEqualToString:@"SearchBig_WebService"])
        {
            Singleton *s=[Singleton getObject];
            
            event_dicts=[results objectForKey:@"Search_Result"];
            
            NSString *checkStr=[event_dicts objectForKey:@"msg"];
            
            if([checkStr isEqualToString:@"Successful"])
            {
                
                //Singleton *s=[Singleton getObject];
                
                
        //[s setDict_ScheduleScreen:[NSDictionary dictionaryWithDictionary:event_dicts]];
                
                //setting event title
                lbl_Event_Title.text=[event_dicts objectForKey:@"event_name"];
                
                NSDictionary *dict=[event_dicts objectForKey:@"sessions"];
                //[s setDict_session:[event_dicts objectForKey:@"sessions"]];
                
                 [s setDict_schNextTeam:[event_dicts objectForKey:@"sessions"]];
                
                NSArray *unSortedSession=[dict allKeys];
                
                sortedSession=[unSortedSession  sortedArrayUsingSelector:@selector(compare:)];
                
                if(floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
                {
                    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 99, 1024, 567) style:UITableViewStylePlain];
                    
                }
                else
                {
                    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 99, 1024, 547) style:UITableViewStylePlain];
                    
                }
                
                
                [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                myTableView.dataSource=self;
                myTableView.delegate=self;
                myTableView.backgroundColor=[UIColor clearColor];
                [[self view]addSubview:myTableView];
                
                
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
                NSLog(@"ar_teams_Count=%lu",(unsigned long)[ar_teams count]);
                
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
    
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0,0,984,150)];
    
     customView.backgroundColor=[UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    //headerLabel.backgroundColor =[UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
    headerLabel.font = [UIFont fontWithName:@"Enigmatic" size:18];
    headerLabel.textAlignment=NSTextAlignmentCenter;
  //  headerLabel.frame = CGRectMake(500,0,120,30);
    headerLabel.frame = CGRectMake(0,0,1024,30);

    NSLog(@"Session- %@"  ,[event_dicts objectForKey:@"sessions"]);
    headerLabel.text = [NSString stringWithFormat:@"Session-%@",[sortedSession objectAtIndex:section]];
    headerLabel.textColor = [UIColor whiteColor];
    [customView addSubview:headerLabel];
    
    
  //  UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0,0,300,150)];
    // customView.backgroundColor=[UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
  //  UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
   // headerLabel.backgroundColor =[UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
 //   headerLabel.font = [UIFont fontWithName:@"Enigmatic" size:18];
  //  headerLabel.textAlignment=NSTextAlignmentCenter;
 //   headerLabel.frame = CGRectMake(0,0,984,30);
  //  NSLog(@"%@"  ,[event_dicts objectForKey:@"sessions"]);
  //  headerLabel.text = [NSString stringWithFormat:@"Session-%@",[sortedSession objectAtIndex:section]];
  //  headerLabel.textColor = [UIColor whiteColor];
  //  [customView addSubview:headerLabel];

    
//    UILabel *headerLabel1 = [[UILabel alloc] initWithFrame:CGRectZero];
//    headerLabel1.backgroundColor =[UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
//    headerLabel1.font = [UIFont fontWithName:@"Enigmatic" size:18];
//    headerLabel1.textAlignment=NSTextAlignmentCenter;
//    headerLabel1.frame = CGRectMake(207,0,133,30);
//    headerLabel1.text =  @"City/State";
//    headerLabel1.textColor = [UIColor whiteColor];
//    [customView addSubview:headerLabel1];
//    
//    UILabel *headerLabel2 = [[UILabel alloc] initWithFrame:CGRectZero];
//    headerLabel2.backgroundColor = [UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
//    headerLabel2.font = [UIFont fontWithName:@"Enigmatic" size:18];
//    headerLabel2.textAlignment=NSTextAlignmentCenter;
//    headerLabel2.frame = CGRectMake(349,0,333,30);
//    headerLabel2.text =  @"Division";
//    headerLabel2.textColor = [UIColor whiteColor];
//    [customView addSubview:headerLabel2];
//    
//    UILabel *headerLabel3 = [[UILabel alloc] initWithFrame:CGRectZero];
//    headerLabel3.backgroundColor = [UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
//    headerLabel3.font = [UIFont fontWithName:@"Enigmatic" size:18];
//    headerLabel3.textAlignment=NSTextAlignmentCenter;
//    headerLabel3.frame = CGRectMake(690,0,95,30);
//    headerLabel3.text =  @"WarmUp";
//    headerLabel3.textColor = [UIColor whiteColor];
//    [customView addSubview:headerLabel3];
//    
//    
//    UILabel *headerLabel4 = [[UILabel alloc] initWithFrame:CGRectZero];
//    headerLabel4.backgroundColor =[UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
//    headerLabel4.font = [UIFont fontWithName:@"Enigmatic" size:18];
//    headerLabel4.textAlignment=NSTextAlignmentCenter;
//    headerLabel4.frame = CGRectMake(794,0,95,30);
//    headerLabel4.text =  @"Perform";
//    headerLabel4.textColor = [UIColor whiteColor];
//    [customView addSubview:headerLabel4];
//    
//    UILabel *headerLabel5 = [[UILabel alloc] initWithFrame:CGRectZero];
//    headerLabel5.backgroundColor = [UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
//    headerLabel5.font = [UIFont fontWithName:@"Enigmatic" size:18];
//    headerLabel5.textAlignment=NSTextAlignmentCenter;
//    headerLabel5.frame = CGRectMake(900,0,85,30);
//    headerLabel5.text =  @"Floor";
//    headerLabel5.textColor = [UIColor whiteColor];
//    [customView addSubview:headerLabel5];
    
    return customView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
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
    
    NSDictionary *dict=[event_dicts objectForKey:@"sessions"];
    
    cell.lbl_Team_Name.text=[[[dict objectForKey:[sortedSession objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectForKey:@"team_name"];
    
    cell.lbl_City_Name.text=[[[dict objectForKey:[sortedSession objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectForKey:@"location"];

    
//    NSString *str111=[[[dict objectForKey:[sortedSession objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectForKey:@"location"];
//    
//    NSArray *qwe=[str111 componentsSeparatedByString:@","];
//    
//    NSString *asd = [qwe componentsJoinedByString:@", "];
//    
//    cell.lbl_City_Name.text=asd;
    
    
    cell.lbl_Divison_Name.text=[[[dict objectForKey:[sortedSession objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectForKey:@"division"];
    cell.lbl_WarmUp_Time.text=[[[dict objectForKey:[sortedSession objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectForKey:@"warmup_time"];
    cell.lbl_Perform_Time.text=[[[dict objectForKey:[sortedSession objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectForKey:@"perform_time"];
    cell.lbl_Floor_Name.text=[[[dict objectForKey:[sortedSession objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectForKey:@"panel_num"];
    
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
    
    /*Singleton *s=[Singleton getObject];
    
    if ([[s selected_index] integerValue]==indexPath.row)
    {
        //cell.selectionStyle=UITableViewCellSelectionStyleGray;
        //cell.backgroundColor=[UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:0.02];
        cell.backgroundColor= [UIColor colorWithRed:20.0f/255 green:10.0f/255 blue:255.0f/255 alpha:0.09];
        
        
    }
    else
    {
        //cell.selectionStyle=UITableViewCellSelectionStyleBlue;
        //cell.backgroundColor=[UIColor redColor];
        
    }*/
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
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
    Singleton *s=[Singleton getObject];
    
    NSDictionary *dict=[event_dicts objectForKey:@"sessions"];
    
    [s setTeam_Name:[[[dict objectForKey:[sortedSession objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectForKey:@"team_name"]];
    
    [s setTeam_id:[[[dict objectForKey:[sortedSession objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectForKey:@"team_id"]];
    
    [s setGym_Name:[[[dict objectForKey:[sortedSession objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectForKey:@"division"]];
    
    [s setLevel_Name:[[[dict objectForKey:[sortedSession objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectForKey:@"team_level"]];
        
     [s setLevel_id_new:[[[dict objectForKey:[sortedSession objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectForKey:@"level_id"]];
        
    [s setDivision_id:[[[dict objectForKey:[sortedSession objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectForKey:@"division_id"]];
        
    
    [s setSelected_index:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    
    [s setLeftpan_selecteTeam:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    [s setSelected_section:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
    
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [delegate CallSlide];
    [self presentViewController:delegate.viewController_leftPane animated:YES completion:NULL];
    
    
    ///////
    
    /*[self showBusyView];
    CheckWebService=@"TeamList_WebService";
    NSMutableDictionary  *dct=[[NSMutableDictionary alloc] init];
    
    [dct setObject:[s loginUserID] forKey:@"userid"];
    [dct setObject:[event_dicts objectForKey:@"event_id"] forKey:@"eventid"];
    
    [dct setObject:[event_dicts objectForKey:@"event_date"] forKey:@"eventdate"];
    [dct setObject:@"" forKey:@"eventcity"];
    [dct setObject:[[[dict objectForKey:[sortedSession objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectForKey:@"gym_id"] forKey:@"gym"];
    
    
    s.lb_Gym_id_forTeamList=  [[[dict objectForKey:[sortedSession objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectForKey:@"gym_id"];
    
    NSString *jsonstring1=[dct JSONRepresentation];
    ////NSLog(@"jsonstring=%@",jsonstring1);
    NSString *post1=[NSString stringWithFormat:@"&json=[%@]",jsonstring1];
    ////NSLog(@"Post %@", post1);
    
    NSString *l_pURL	= [NSString stringWithFormat:@"%@getwbs_teamlist.php",BASEURL];
    m_pWebService			= [[WebService alloc] initWebService:l_pURL];
    m_pWebService.mDelegate		= self;
    [m_pWebService  sendHTTPPost:post1];*/
    }
    
}

-(IBAction)btn_BackFromBigSearch:(id)sender
{
    //[self dismissViewControllerAnimated:YES completion:nil];
    
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
    
    Singleton *s=[Singleton getObject];
    
    [s setEvent_Name1:nil];
    [s setEvent_ID1:nil];
    
    
    [s setCity_Name1:nil];
    [s setDate_Name1:nil];
    
    [s setGym_id1:nil];
    [s setGym_Name1:nil];
    
    [s setLevel_id1:nil];
    [s setLevel_Name1:nil];
    
    [s setTeam_id1:nil];
    [s setTeam_Name1:nil];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
