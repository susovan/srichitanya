//
//  LeftPaneViewController1.m
//  Cheer&Dance
//
//  Created by Madhava Reddy on 3/7/14.
//  Copyright (c) 2014 Adeptpros. All rights reserved.
//

#import "LeftPaneViewController1.h"
#import "LeftPanelCell.h"
#import "Singleton.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import "JASidePanelController.h"
#import "Defines.h"

@interface LeftPaneViewController1 ()
{
    NSString *CheckWebService;
    NSArray *ar_TeamList;
    NSMutableArray *array_List;
    
    NSIndexPath *myPath;
    
    NSMutableArray *ar_secTeam;
    NSMutableArray *ar_secTeam_level;
    NSMutableArray *ar_secTeam_div;
    NSMutableDictionary *Dict_session;
    NSArray *sortArray;
}

@property (strong, nonatomic) NSDictionary *teamMainDict;
@property (strong, nonatomic) NSMutableDictionary *teamDict;

@end

@implementation LeftPaneViewController1

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

- (void)viewDidLoad
{

    [super viewDidLoad];
    
    Singleton *s=[Singleton getObject];
    //CopylistofTeams=[[NSMutableArray alloc]initWithArray:[s ar_Team_Names]];
    
    
    
    
    [self showBusyView];
    CheckWebService=@"TeamList_WebService";
    
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
  
}
-(void)myClick
{
    Singleton *s=[Singleton getObject];
   myPath= [NSIndexPath indexPathForRow:[s.selected_index intValue] inSection:[s.selected_section intValue]];
    
    [leftTable reloadData];
    
  //  [leftTable scrollToRowAtIndexPath:myPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    //[leftTable scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:s.selected_index inSection:s.selected_section] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
  //  [leftTable reloadData];
    //Singleton *s=[Singleton getObject];
    
    //UITableViewCell *cell=[leftTable cellForRowAtIndexPath:s.selected_index];
    
     //cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    //cell.backgroundColor= [UIColor colorWithRed:20.0f/255 green:10.0f/255 blue:255.0f/255 alpha:0.09];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
     //  [leftTable removeFromSuperview];
   
    NSLog(@"%@",[[self view]subviews]);
    
    leftpane_heading.font=[UIFont fontWithName:@"Enigmatic" size:24];
   // [leftTable reloadData];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(myClick) name:@"leftPan" object:nil];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,40)];
    // customView.backgroundColor=[UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor =[UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
    headerLabel.font = [UIFont fontWithName:@"Enigmatic" size:18];
    headerLabel.textAlignment=NSTextAlignmentCenter;
    headerLabel.frame = CGRectMake(0,0,310,30);
    //NSLog(@"%@"  ,[event_dicts objectForKey:@"sessions"]);
 //   headerLabel.text = [sortArray objectAtIndex:section];
     NSArray *sortearray=[[self.teamDict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    headerLabel.text = [NSString stringWithFormat:@"Session-%@",[sortearray objectAtIndex:section]];
    headerLabel.textColor = [UIColor whiteColor];
    [customView addSubview:headerLabel];
    return customView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return 3;
 //   return [sortArray count];
    
    return [[self.teamDict allKeys] count];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   //  return [[Dict_session objectForKey:[sortArray objectAtIndex:section]] count];
    
    return [[self.teamDict objectForKey:[[[self.teamDict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *Identifier=@"Cell";
    LeftPanelCell *cell =(LeftPanelCell *) [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    if(cell == nil)
    {
        NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"LeftPanelCell" owner:self options:nil];
        cell=[topLevelObjects objectAtIndex:0];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    //cell.teamTitle.text=[CopylistofTeams objectAtIndex:indexPath.row];//[[s ar_Team_Names] objectAtIndex:indexPath.row];
    
 //   cell.teamTitle.text=[[[Dict_session objectForKey:[sortArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] objectForKey:@"team_name"];
    
    
    cell.teamTitle.text = [[[self.teamDict objectForKey:[[[self.teamDict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] objectForKey:@"team_name"] ;
    
    
    cell.teamTitle.textColor=[UIColor colorWithRed:10.0/250.0 green:40.0/250.0 blue:100.0/250.0 alpha:1.0];
    cell.teamTitle.font=[UIFont fontWithName:@"Enigmatic" size:22];
    cell.teamTitle.backgroundColor=[UIColor clearColor];
    cell.backgroundColor=[UIColor clearColor];
    
    //cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    if ([search.text length]==0)
    {
        Singleton *s=[Singleton getObject];
        if (([[s selected_index] integerValue]==indexPath.row)&&([[s selected_section] integerValue]==indexPath.section))
        {
            //cell.teamTitle.text=[[[Dict_session objectForKey:[sortArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] objectForKey:@"team_name"];
            //cell.selectionStyle=UITableViewCellSelectionStyleGray;
            
            cell.backgroundColor=[UIColor lightGrayColor];
            cell.teamTitle.textColor=[UIColor whiteColor];
            
            //cell.backgroundColor= [UIColor colorWithRed:211.0f/255 green:211.0f/255 blue:211.0f/255 alpha:1];
        }
        else
        {
            //cell.teamTitle.text = [[[self.teamDict objectForKey:[sortArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] objectForKey:@"team_name"] ;
            
        }

        
    }
    else
    {
        
    }
    
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
    myPath=indexPath;
    row_selected=(int)indexPath.row;
   
    
    
    Singleton *s=[Singleton getObject];
    
    
    
    NSLog(@"TeamName=%@",[CopylistofTeams objectAtIndex:indexPath.row]);
    
    
    
    NSLog(@"left selection :%@",s.leftpan_selecteTeam);
    
    

//        [s setTeam_id:[[[Dict_session objectForKey:[sortArray objectAtIndex:indexPath.section]]objectAtIndex:indexPath.row]objectForKey:@"team_id"]];
//        NSLog(@"TeamID=%@",[s team_id]);
//        
//        [s setLevel_Name:[[[Dict_session objectForKey:[sortArray objectAtIndex:indexPath.section]]objectAtIndex:indexPath.row]objectForKey:@"team_level"]];
//        [s setGym_Name:[[[Dict_session objectForKey:[sortArray objectAtIndex:indexPath.section]]objectAtIndex:indexPath.row]objectForKey:@"division"]];
//        NSLog(@"Level:%@",[s level_Name]);
//        NSLog(@"Division :%@",[s gym_Name]);
//        
//        [s setSelected_index:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
//        
//        [s setLeftpan_selecteTeam:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
//        [s setSelected_section:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
    
    
    NSArray *tempArray = [self.teamDict objectForKey:[[[self.teamDict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]];
    
    //NSArray *tempArray2 = [self.teamMainDict objectForKey:[[[self.teamMainDict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]];
    
    int section = 0;
    int row=0;
    
    for (NSString *key in [[self.teamMainDict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)])
    {
        BOOL found = NO;
        for (NSString *key1 in [[self.teamDict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)])
        {
            if ([key isEqualToString:key1])
            {
                section = [[[self.teamMainDict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] indexOfObject:key];
                
                for (NSDictionary *dict in [self.teamMainDict objectForKey:key])
                {
                    if ([dict isEqual:[tempArray objectAtIndex:indexPath.row]])
                    {
                        row = [[self.teamMainDict objectForKey:key] indexOfObject:dict];
                        found = YES;
                        break;
                    }
                }
                
                break;
            }
        }
        if (found)
            break;
    }
    
    [s setTeam_id:[[tempArray objectAtIndex:indexPath.row] objectForKey:@"team_id"]];
    
    [s setLevel_Name:[[tempArray objectAtIndex:indexPath.row] objectForKey:@"team_level"]];

    [s setGym_Name:[[tempArray objectAtIndex:indexPath.row] objectForKey:@"division"]];
    
    [s setLevel_id_new:[[tempArray objectAtIndex:indexPath.row] objectForKey:@"level_id"]];
    [s setDivision_id:[[tempArray objectAtIndex:indexPath.row] objectForKey:@"division_id"]];

    
    
    NSLog(@"TeamID=%@",[s team_id]);
    NSLog(@"Level:%@",[s level_Name]);
    NSLog(@"Division :%@",[s gym_Name]);
    
    [s setSelected_index:[NSString stringWithFormat:@"%ld",(long)row]];
    [s setLeftpan_selecteTeam:[NSString stringWithFormat:@"%ld",(long)row]];
    [s setSelected_section:[NSString stringWithFormat:@"%ld",(long)section]];
        
    [search resignFirstResponder];
    [self searchBar:search textDidChange:@""];
    [search setText:@""];
    
    
    
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
    {
        
        //    ViewController *vievController_iphoneObj=[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
        appdelegate.viewController_leftPane.centerPanel=[[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil]];
        [appdelegate.viewController_leftPane showLeftPanelAnimated:YES];
        
        
    }
    else
    {
        
        //ViewController *vievController_iphoneObj=[[ViewController alloc] initWithNibName:@"ViewController_ios6" bundle:nil];
        appdelegate.viewController_leftPane.centerPanel=[[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] initWithNibName:@"ViewController_ios6" bundle:nil]];
        [appdelegate.viewController_leftPane showLeftPanelAnimated:YES];
        
    }
}
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
  
//    if ([searchText length]==0)
//    {
//        [CopylistofTeams removeAllObjects];
//        
//        [CopylistofTeams addObjectsFromArray:array_List];
//        
//    }else
//    {
//        [CopylistofTeams removeAllObjects];
//        
//        for (NSString * string in array_List)
//        {
//            NSRange r=[string rangeOfString:searchText options:NSCaseInsensitiveSearch];
//            if (r.location!=NSNotFound)
//            {
//                [CopylistofTeams addObject:string];
//            
//            }
//        }
//    }
    
    
//    NSArray *ar_key=[Dict_session allKeys];
//    
//    sortArray= [ar_key sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

    
    if ([searchText length]==0)
    {
         self.teamDict = [NSMutableDictionary dictionaryWithDictionary:self.teamMainDict];
    }
    else
    {
        for (NSString *key in [[self.teamMainDict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)])
        {
            NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"SELF.team_name contains[c] %@",searchText];
            
            NSMutableArray *arr = [NSMutableArray arrayWithArray:[[self.teamMainDict objectForKey:key] filteredArrayUsingPredicate:filterPredicate]];
            [self.teamDict removeObjectForKey:key];
            
            if (arr.count>0)
            {
                [self.teamDict setObject:arr forKey:key];
            }
        }
    }
    
    [leftTable reloadData];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [search resignFirstResponder];
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
        
        if([CheckWebService isEqualToString:@"TeamList_WebService"])
        {
            Team_dicts=[results objectForKey:@"Search_Result"];
            
            NSString *checkStr=[Team_dicts objectForKey:@"msg"];
            
            if([checkStr isEqualToString:@"Successful"])
            {
                
                self.teamMainDict = [NSDictionary dictionaryWithDictionary:[[results objectForKey:@"Search_Result"] objectForKey:@"sessions"]];
                
                self.teamDict = [NSMutableDictionary dictionaryWithDictionary:self.teamMainDict];
                
                Dict_session=[[NSMutableDictionary alloc]init];
                Dict_session=[[Team_dicts objectForKey:@"sessions"] mutableCopy];
                NSArray *ar_key=[Dict_session allKeys];
                
                sortArray= [ar_key sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
                
                
                //ar_TeamList= [Team_dicts objectForKey:@"result"];
                array_List=[[NSMutableArray alloc]init];
                ar_secTeam=[[NSMutableArray alloc]init];
                ar_secTeam_level=[[NSMutableArray alloc]init];
                ar_secTeam_div=[[NSMutableArray alloc]init];
                
                int l=0;
                
                for (int i=0; i<[sortArray count]; i++)
                {
                    //[ar_secTeam addObject:[Dict_session objectForKey:[sortArray objectAtIndex:i]]];
                    
                    NSArray *temp=[Dict_session objectForKey:[sortArray objectAtIndex:i]];
                    
                    for (int k=0; k<temp.count; k++)
                    {
                        //[array_List addObject:[[temp objectAtIndex:k] objectForKey:@"team_name"]];
                        //[ar_secTeam addObject:[[temp objectAtIndex:k] objectForKey:@"team_id"]];
                        
                        //[ar_secTeam_level addObject:[[temp objectAtIndex:k] objectForKey:@"team_level"]];
                        //[ar_secTeam_div addObject:[[temp objectAtIndex:k] objectForKey:@"division"]];
                        
                        [array_List insertObject:[[temp objectAtIndex:k] objectForKey:@"team_name"] atIndex:l];
                        [ar_secTeam insertObject:[[temp objectAtIndex:k] objectForKey:@"team_id"] atIndex:l];
                        [ar_secTeam_level insertObject:[[temp objectAtIndex:k] objectForKey:@"team_level"] atIndex:l];
                        [ar_secTeam_div insertObject:[[temp objectAtIndex:k] objectForKey:@"division"] atIndex:l];
                        
                        l++;
                        
                    }
                    
                    
                }
                
                CopylistofTeams=[[NSMutableArray alloc]initWithArray:array_List];
                
                //CopylistofTeams=[[NSMutableArray alloc]initWithArray:ar_TeamList];
                
                if(floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
                {
                    // leftTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 1024, 704) style:UITableViewStylePlain];
                    leftTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 108, 320, 660) style:UITableViewStylePlain];
                    
                }
                else
                {
                    //leftTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 1024, 686) style:UITableViewStylePlain];
                    leftTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 108, 320, 686) style:UITableViewStylePlain];
                }
                
                leftTable.backgroundColor=[UIColor clearColor];
                leftTable.separatorStyle=UITableViewCellSelectionStyleNone;
                [self.view addSubview:leftTable];
                leftTable.dataSource=self;
                leftTable.delegate=self;
                
                
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


@end
