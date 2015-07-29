//
//  RankingEventViewController.m
//  Cheer&Dance
//
//  Created by Madhava Reddy on 3/24/14.
//  Copyright (c) 2014 Adeptpros. All rights reserved.
//

#import "RankingEventViewController.h"
#import "JSON.h"
#import "Singleton.h"
#import "AppDelegate.h"
#import "Defines.h"
#import "RankingCell.h"

@interface RankingEventViewController ()
{
    NSArray *ar_Divions_Drop;
    NSArray *ar_Ranks;
    NSDictionary *dicts;
    NSDictionary *results;
    NSArray *ar_sumary;
    int secNo;
}

@end

@implementation RankingEventViewController
@synthesize popView,aPopover;

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
-(void)viewWillAppear:(BOOL)animated
{
    [reportView removeFromSuperview];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.view addSubview:reportView];
    
    ar_Ranks=[NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
    ar_Divions_Drop=[NSArray arrayWithObjects:@"Tiny",@"Mini",@"Junior",@"Senior" ,@"All",nil];
    
    // Do any additional setup after loading the view from its nib.
    
    // Fonts
    
    btn_Generate_pdf.titleLabel.font=[UIFont fontWithName:@"Enigmatic" size:20];
     btn_Generate_pdf.titleLabel.textColor=[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    rankingEvent_Title.font=[UIFont fontWithName:@"Enigmatic" size:26];
    Lbl_Eventname.font=[UIFont fontWithName:@"Enigmatic" size:24];
    Lbl_date.font=[UIFont fontWithName:@"Enigmatic" size:24];
    Lbl_TeamnameTitle.font=[UIFont fontWithName:@"Enigmatic" size:16];
    Lbl_stuntsTitle.font=[UIFont fontWithName:@"Enigmatic" size:16];
    Lbl_ThumblingTitle.font=[UIFont fontWithName:@"Enigmatic" size:16];
    Lbl_ChoreographyTitle.font=[UIFont fontWithName:@"Enigmatic" size:16];
    Lbl_DeductionTitle.font=[UIFont fontWithName:@"Enigmatic" size:16];
    Lbl_TotalscoreTitle.font=[UIFont fontWithName:@"Enigmatic" size:16];
    Lbl_RankTitle.font=[UIFont fontWithName:@"Enigmatic" size:16];
    Lbl_DANCETitle.font=[UIFont fontWithName:@"Enigmatic" size:16];

    
    txt_Diviosn_Drop.font=[UIFont fontWithName:@"Enigmatic" size:18];
      txt_Diviosn_Drop.textColor=[UIColor colorWithRed:250/250 green:250/250 blue:250/250 alpha:1.0];
    /////////////////
    
   // http://joomerang.geniusport.com/cheerinfinity/webservices/getwbs_eventsummary.php?json=[{"userid":"79","event":"1"}]

    
    
    // http://joomerang.geniusport.com/cheerinfinity/webservices_prod/getwbs_event_ranking.php?json=[{"userid":"41","event":"10"}]
    
    
    Singleton *s=[Singleton getObject];
    
    [self showBusyView];
    CheckWebService=@"TeamSummary";
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
     results = [json_string JSONValue];
        NSLog(@"Result= %@",results);
       
       // dicts=[results objectForKey:@"summary"];
        
        
        
        if([[results objectForKey:@"msg"]isEqualToString:@"Successful"])
        {
            
            event_SummaryAry=[dicts allKeys];
            
            
            ar_sumary=[results objectForKey:@"summary"];
            
            NSLog(@"%@",[[[[ar_sumary objectAtIndex:0]objectForKey:@"level_summary"]objectAtIndex:0]objectForKey:@"final"]);
            
        
            NSLog(@"Count==%lu",(unsigned long)event_SummaryAry.count);
           
            //NSLog(@"event_name=%@",[[event_SummaryAry objectAtIndex:0] objectForKey:@"event_name"]);
            [Lbl_Eventname setText:[results objectForKey:@"event_name"]];
            //[Lbl_date setText:[[event_SummaryAry objectAtIndex:0] objectForKey:@"start_date"]];
            
//            rankingAlert=[[UIAlertView alloc]initWithTitle:@"Not Completed Event, Do you want to continue" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
//            [rankingAlert show];
            
            if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
            {
              
                
                 rankingTable = [[UITableView alloc]initWithFrame:CGRectMake(20, 150, 984, 567) style:UITableViewStylePlain];
            }
            else
            {
                 rankingTable = [[UITableView alloc]initWithFrame:CGRectMake(20, 150, 984, 530) style:UITableViewStylePlain];
            }
           
             [[self view]addSubview:rankingTable];
            [rankingTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            rankingTable.backgroundColor=[UIColor clearColor];
            rankingTable.dataSource=self;
            rankingTable.delegate=self;

        
        }
        
        else
        {
            rankingAlert=[[UIAlertView alloc]initWithTitle:@"None team has been approved" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [rankingAlert show];
            
        }
     
    }
}
-(void)webServiceRequestFail :(NSError *)error
{
    [self hideBusyView];
  //   NoInternetConnection=YES;
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status == NotReachable)
    {
    
     UIAlertView *alert2=[[UIAlertView alloc] initWithTitle:@"" message:@"Please check your Wi-Fi or 3G connection and try again" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
     [alert2 show];
        
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView==rankingAlert) {
        if (buttonIndex==0)
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else if (buttonIndex==1)
        {
            
        }
    }
}
-(IBAction)backFrom_rankingEvent:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
   return [ar_sumary count];
    
    //return [[dicts allKeys]count];
        
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
  
    
   /*
    
    int count=0;
    for(int i=0;i<[[[ar_sumary objectAtIndex:section] objectForKey:@"level_summary"] count];i++)
    {
        
        if([[[[[ar_sumary objectAtIndex:section]objectForKey:@"level_summary"]objectAtIndex:i]objectForKey:@"final"]intValue]==0)
        {
            
           
            
        }

   else
   {
       
       NSLog(@"%@", [[[[ar_sumary objectAtIndex:section] objectForKey:@"level_summary"]objectAtIndex:i]objectForKey:@"final"]);
       count++;
       
   }
    
        
        
    }
    
    NSLog(@"%d",count);
    
    return count;
    */
  return [[[ar_sumary objectAtIndex:section] objectForKey:@"level_summary"] count];
    
    
    //NSArray *ar=[dicts allKeys];
    
 //NSDictionary *dct=  [dicts objectForKey:[ar objectAtIndex:section]];
    //secNo=section;
    
  //return   [[dct allKeys]count];
    
    
     //NSLog(@"event_SummaryAry=%@",event_SummaryAry);
//    int count1;
//    
//    for(id x in event_SummaryAry)
//    {
//        
//        NSLog(@"%d",[[[dicts objectForKey:[NSString stringWithFormat:@"%@",x]]allKeys] count]);
//        count1= [[[dicts objectForKey:x]allKeys] count];
//        
//    }
//    
//    return count1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
        static NSString *Identifier=@"RankingCell";
        RankingCell *cell =(RankingCell *) [tableView dequeueReusableCellWithIdentifier:Identifier];
        
        if(cell == nil)
        {
            NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"RankingCell" owner:self options:nil];
            cell=[topLevelObjects objectAtIndex:0];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    cell.lbl_Day_1_Score.font=[UIFont fontWithName:@"Enigmatic" size:17];
    cell.lbl_Day_2_Score.font=[UIFont fontWithName:@"Enigmatic" size:17];
    cell.lbl_Day_3_Score.font=[UIFont fontWithName:@"Enigmatic" size:17];

    cell.lbl_Final_Score.font=[UIFont fontWithName:@"Enigmatic" size:17];
    cell.lbl_LabelName.font=[UIFont fontWithName:@"Enigmatic" size:17];
    cell.lbl_location.font=[UIFont fontWithName:@"Enigmatic" size:17];
    cell.lbl_Rank.font=[UIFont fontWithName:@"Enigmatic" size:17];
    //cell.rank.font=[UIFont fontWithName:@"Enigmatic" size:17];
    //cell.dance.font=[UIFont fontWithName:@"Enigmatic" size:17];

    
    /*cell.team_names.text=[[event_SummaryAry objectAtIndex:indexPath.row] objectForKey:@"team_name"];
    cell.stunts_score.text=[[event_SummaryAry objectAtIndex:indexPath.row] objectForKey:@"BUILDING SKILLS"];
    cell.thumbling_score.text=[[event_SummaryAry objectAtIndex:indexPath.row] objectForKey:@"TUMBLING/JUMPS"];
    cell.choreogarphy_score.text=[[event_SummaryAry objectAtIndex:indexPath.row] objectForKey:@"CHOREOGRAPHY"];
    cell.deduction_score.text=[[event_SummaryAry objectAtIndex:indexPath.row] objectForKey:@"DEDUCTION/CUMULATIVE"];
    cell.total_score.text=[[event_SummaryAry objectAtIndex:indexPath.row] objectForKey:@"total"];*/
    
    //cell.dance.text=[[event_SummaryAry objectAtIndex:indexPath.row]objectForKey:@"DANCE"];
    
    
    /*NSArray *ar=[dicts allKeys];
    
    NSDictionary *dct=[dicts objectForKey:[ar objectAtIndex:indexPath.row]];
    
    
    
    NSArray *ar1=[dct allKeys];
    cell.lbl_LabelName.text=[ar1 objectAtIndex:indexPath.row];
    
    NSDictionary *dct1=[dct objectForKey:[ar1 objectAtIndex:indexPath.row]];
    
    cell.lbl_Final_Score.text=[[dct1 objectForKey:@"final"] stringValue];
    cell.lbl_location.text=[dct1 objectForKey:@"location"];
    
    NSDictionary *Day_Dict=[dct1 objectForKey:@"days"];
    
    cell.lbl_Day_1_Score.text=[[Day_Dict objectForKey:@"day-1"] stringValue];
    cell.lbl_Day_2_Score.text=[[Day_Dict objectForKey:@"day-2"] stringValue];*/
    
    
    NSLog(@"%@",[[[[ar_sumary objectAtIndex:0]objectForKey:@"level_summary"]objectAtIndex:0]objectForKey:@"final"]);

    
    NSDictionary *Dct1=[ar_sumary objectAtIndex:indexPath.section];
    
    
  
     NSArray *ar1=[Dct1 objectForKey:@"level_summary"];
    
    /*
    NSMutableArray *ar_Check=[[NSMutableArray alloc]init];
    
    [ar_Check addObjectsFromArray:[Dct1 objectForKey:@"level_summary"]];
  //  ar_Check= [Dct1 objectForKey:@"level_summary"];
    
    
    
    if([[[ar_Check objectAtIndex:indexPath.row]objectForKey:@"final"]intValue]==0)
    {
        
        [ar_Check removeObjectAtIndex:indexPath.row];
        
    }

    

    
    
    
    if([[[[[ar_sumary objectAtIndex:indexPath.section]objectForKey:@"level_summary"]objectAtIndex:indexPath.row]objectForKey:@"final"]intValue]==0)
    {
    
      
        
        
    }
    else
    {
   ar1=[Dct1 objectForKey:@"level_summary"];
        
        
    }
    */
    cell.lbl_Final_Score.text=[[[ar1 objectAtIndex:indexPath.row] objectForKey:@"final"] stringValue];
    
    cell.lbl_location.text=[[ar1 objectAtIndex:indexPath.row]objectForKey:@"location"];
    cell.lbl_LabelName.text=[[ar1 objectAtIndex:indexPath.row]objectForKey:@"team_name"];
    
    //cell.lbl_Day_1_Score.text=[[[[ar1 objectAtIndex:indexPath.row] objectForKey:@"days"] objectForKey:@"day-1"]stringValue];
    
    cell.lbl_Day_1_Score.text=[NSString stringWithFormat:@"%@",[[[ar1 objectAtIndex:indexPath.row] objectForKey:@"days"] objectForKey:@"day-1"]];
    
    //cell.lbl_Day_2_Score.text=[[[[ar1 objectAtIndex:indexPath.row] objectForKey:@"days"] objectForKey:@"day-2"]stringValue];
    
    cell.lbl_Day_2_Score.text=[NSString stringWithFormat:@"%@",[[[ar1 objectAtIndex:indexPath.row] objectForKey:@"days"] objectForKey:@"day-2"]];
    
    
    cell.lbl_Day_3_Score.text=[NSString stringWithFormat:@"%@",[[[ar1 objectAtIndex:indexPath.row] objectForKey:@"days"] objectForKey:@"day-3"]];

    
    cell.lbl_Rank.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
    
    
    return cell;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)btn_ClickedForDivisonDrop:(id)sender
{
    [pickview removeFromSuperview];
    // [categPicker removeFromSuperview];
    pickview =[[UIPickerView alloc]initWithFrame:CGRectMake(0,44, 350 , 250)];
    // pickview.backgroundColor=[UIColor clearColor];

    
    self.popView = [[UIViewController alloc]init];
    [self.popView.view addSubview:picker_uiview];
    self.aPopover = [[UIPopoverController alloc]initWithContentViewController:self.popView];
    self.aPopover.delegate=(id)self;
    self.aPopover.popoverContentSize=picker_uiview.frame.size;
    [self.aPopover presentPopoverFromRect:btn_Division.frame inView:self.view
                 permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
    [picker_uiview addSubview:pickview];
    pickview.dataSource=(id)self;
    pickview.delegate=self;
    [pickview setShowsSelectionIndicator:YES];



}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return ar_Divions_Drop.count;

}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    UILabel *retval = (id)view;
    if (!retval)
    {
        retval= [[UILabel alloc] init];   //WithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
    }
    retval.textAlignment = NSTextAlignmentLeft;
    retval.textColor=[UIColor colorWithRed:56.0/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];
    retval.font=[UIFont fontWithName:@"Enigmatic" size:18];

    //retval.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    retval.text= [ar_Divions_Drop objectAtIndex:row];
    
return retval;
    
}

-(IBAction)btn_Done_From_Divison_Picker:(id)sender
{
    int index_Selected=(int)[pickview selectedRowInComponent:0];
    [txt_Diviosn_Drop setText:[ar_Divions_Drop objectAtIndex:index_Selected]];
    [pickview removeFromSuperview];
    [self.aPopover dismissPopoverAnimated:YES];
    [self.popView dismissModalViewControllerAnimated:YES];

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0,10,300,100)];
    
   // customView.backgroundColor=[UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor =[UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
    headerLabel.font = [UIFont fontWithName:@"Enigmatic" size:18];
    headerLabel.textAlignment=NSTextAlignmentCenter;
    headerLabel.frame = CGRectMake(0,0,90,30);
   // NSLog(@"%@"  ,[event_dicts objectForKey:@"sessions"]);
    
    headerLabel.text =@"Day 1";
    headerLabel.textColor = [UIColor whiteColor];
    [customView addSubview:headerLabel];
    
    UILabel *headerLabel1 = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel1.backgroundColor =[UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
    headerLabel1.font = [UIFont fontWithName:@"Enigmatic" size:18];
    headerLabel1.textAlignment=NSTextAlignmentCenter;
    headerLabel1.frame = CGRectMake(100,0,90,30);
    headerLabel1.text =  @"Day 2";
    headerLabel1.textColor = [UIColor whiteColor];
    [customView addSubview:headerLabel1];
    
    
//    UILabel *headerLabel2 = [[UILabel alloc] initWithFrame:CGRectZero];
//    headerLabel2.backgroundColor = [UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
//    headerLabel2.font = [UIFont fontWithName:@"Enigmatic" size:18];
//    headerLabel2.textAlignment=NSTextAlignmentCenter;
//    headerLabel2.frame = CGRectMake(200,0,90,30);
//    headerLabel2.text =  @"Day 3";
//    headerLabel2.textColor = [UIColor whiteColor];
//    [customView addSubview:headerLabel2];
    
    
    UILabel *headerLabel3 = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel3.backgroundColor = [UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
    headerLabel3.font = [UIFont fontWithName:@"Enigmatic" size:18];
    headerLabel3.textAlignment=NSTextAlignmentCenter;
    headerLabel3.frame = CGRectMake(200,0,90,30);
    headerLabel3.text =  @"Final";
    headerLabel3.textColor = [UIColor whiteColor];
    [customView addSubview:headerLabel3];
    
    
    UILabel *headerLabel4 = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel4.backgroundColor = [UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
    headerLabel4.font = [UIFont fontWithName:@"Enigmatic" size:18];
    headerLabel4.textAlignment=NSTextAlignmentCenter;
    headerLabel4.frame = CGRectMake(300,0,90,30);
    headerLabel4.text =  @"Rank";
    headerLabel4.textColor = [UIColor whiteColor];
    [customView addSubview:headerLabel4];
    
    
    UILabel *headerLabel5 = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel5.backgroundColor =[UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
    headerLabel5.font = [UIFont fontWithName:@"Enigmatic" size:18];
    headerLabel5.frame = CGRectMake(400,0,407,30);
    headerLabel5.text =[[ar_sumary objectAtIndex:section]objectForKey:@"level_name"];
    headerLabel5.textColor = [UIColor whiteColor];
    [headerLabel5 setTextAlignment:NSTextAlignmentCenter];
    [customView addSubview:headerLabel5];
    
    
    UILabel *headerLabel6 = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel6.backgroundColor = [UIColor colorWithRed:17.0/255.0 green:47.0/255.0 blue:84.0/255.0 alpha:1.0];
    headerLabel6.font = [UIFont fontWithName:@"Enigmatic" size:18];
    headerLabel6.textAlignment=NSTextAlignmentCenter;
    headerLabel6.frame = CGRectMake(820,0,170,30);
    headerLabel6.text =  @"City/State";
    headerLabel6.textColor = [UIColor whiteColor];
    [customView addSubview:headerLabel6];
 
    
    return customView;
 
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35.0;
}

//-(IBAction)printBtn_Clicked:(id)sender
//{
//    int count_TopLevel=(int)[ar_sumary count];
//    
//    NSMutableArray *arCount=[[NSMutableArray alloc]init];
//    
//    for(int i=0;i<[ar_sumary count];i++)
//    {
//        
//         NSArray *ar_Inner=[[ar_sumary objectAtIndex:i]objectForKey:@"level_summary"];
//        
//        [arCount addObject:[NSNumber numberWithInt:(int)[ar_Inner count]]];
//    }
//    int NumberOfRow=0;
//    for(int j=0;j<[arCount count];j++)
//    {
//        NumberOfRow=NumberOfRow+(int)[[arCount objectAtIndex:j]integerValue];
//    
//    }
//    NSLog(@"number of rows%d",NumberOfRow);
//    int totalCount=count_TopLevel+NumberOfRow+1;//+1 for including header number of lines
//    
//
//    NSString *fileName = @"Result.pdf";
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    
//    NSString *pdfFileName = [documentsDirectory stringByAppendingPathComponent:fileName];
//    
//    
//   // pageSize = CGSizeMake(612, 792);
//    
//    pageSize = CGSizeMake(612, 792);
//    int xx=30;
//    for (int i=0; i<  [ar_sumary count]; i++)
//    {
//            int rank=0;
//        UIImageView *imgView1=[[UIImageView alloc]initWithFrame:CGRectMake(0, xx+5, 790, 30)];
//        [imgView1 setImage:[UIImage imageNamed:@"stunts-pyramids-tosses-bar-heading.png"]];
//        
//        UILabel *lbls=[[UILabel alloc]initWithFrame:CGRectMake(20, xx+10, 70, 30)];
//        lbls.text=@"Day-1";
//        [lbls setBackgroundColor:[UIColor clearColor]];
//        [lbls setTextColor:[UIColor whiteColor]];
//        lbls.font=[UIFont fontWithName:@"Enigmatic" size:16];
//        [lbls setTextAlignment:NSTextAlignmentCenter];
//        
//        
//        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(100, xx+10, 70, 30)];
//        lbl.text=@"Day-2";
//        [lbl setBackgroundColor:[UIColor clearColor]];
//        [lbl setTextColor:[UIColor whiteColor]];
//        [lbl setTextAlignment:NSTextAlignmentCenter];
//        
//        lbl.font=[UIFont fontWithName:@"Enigmatic" size:16];
//        
//        
//        UILabel *lb=[[UILabel alloc]initWithFrame:CGRectMake(180, xx+10, 70, 30)];
//        lb.text=@"Day-3";
//        [lb setBackgroundColor:[UIColor clearColor]];
//        [lb setTextColor:[UIColor whiteColor]];
//        [lb setTextAlignment:NSTextAlignmentCenter];
//        
//        lb.font=[UIFont fontWithName:@"Enigmatic" size:16];
//        
//        UILabel *lbf=[[UILabel alloc]initWithFrame:CGRectMake(260, xx+10, 70, 30)];
//        lbf.text=@"Final";
//        [lbf setBackgroundColor:[UIColor clearColor]];
//        [lbf setTextColor:[UIColor whiteColor]];
//        [lbf setTextAlignment:NSTextAlignmentCenter];
//        
//        lbf.font=[UIFont fontWithName:@"Enigmatic" size:16];
//        
//        
//        UILabel *l=[[UILabel alloc]initWithFrame:CGRectMake(340, xx+10, 70, 30)];
//        l.text=@"Rank";
//        [l setBackgroundColor:[UIColor clearColor]];
//        [l setTextColor:[UIColor whiteColor]];
//        [l setTextAlignment:NSTextAlignmentCenter];
//        
//        l.font=[UIFont fontWithName:@"Enigmatic" size:16];
//        
//        UILabel *la=[[UILabel alloc]initWithFrame:CGRectMake(420, xx+10, 150, 30)];
//        la.text=[[ar_sumary objectAtIndex:i]objectForKey:@"level_name"];
//        [la setBackgroundColor:[UIColor clearColor]];
//        [la setTextColor:[UIColor whiteColor]];
//        [la setTextAlignment:NSTextAlignmentCenter];
//        la.font=[UIFont fontWithName:@"Enigmatic" size:16];
//        
//        UILabel *las=[[UILabel alloc]initWithFrame:CGRectMake(580, xx+10, 250, 30)];
//        las.text=@"City/State";
//        [las setBackgroundColor:[UIColor clearColor]];
//        [las setTextColor:[UIColor whiteColor]];
//        las.font=[UIFont fontWithName:@"Enigmatic" size:16];
//        [las setTextAlignment:NSTextAlignmentCenter];
//
//        //NSArray *arTeam_name_Sorted= [[[dicts objectForKey:[sortedLabel objectAtIndex:i]]allKeys]sortedArrayUsingSelector:@selector(compare:)];
//    
//        
//
//        NSArray *ar_Inner=[[ar_sumary objectAtIndex:i]objectForKey:@"level_summary"];
//        for(int k=0;k<[ar_Inner count];k++)
//        {
//            rank=k;
//            
//
//            UILabel *lbls=[[UILabel alloc]initWithFrame:CGRectMake(20, xx+50, 70, 40)];
//            [lbls setText:[NSString stringWithFormat:@"%@", [[ar_Inner objectAtIndex:k]objectForKey:@"final"]]];
//            [lbls setTextAlignment:NSTextAlignmentCenter];
//
//      
//        
//            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(100, xx+50, 70, 40)];
//            //lbl.text=@"30.20";
//             [lbl setText:[NSString stringWithFormat:@"%@",[[[ar_Inner objectAtIndex:k]objectForKey:@"days"]objectForKey:@"day-1"]]];
//               [lbl setTextAlignment:NSTextAlignmentCenter];
//            [lbl setTextAlignment:NSTextAlignmentCenter];
//
//            
//            UILabel *lb=[[UILabel alloc]initWithFrame:CGRectMake(180, xx+50, 70, 40)];
//            //lb.text=@"45.2";
//            [lb setText:[NSString stringWithFormat:@"%@", [[[ar_Inner objectAtIndex:k]objectForKey:@"days"]objectForKey:@"day-2"]]];
//             [lb setTextAlignment:NSTextAlignmentCenter];
//            [lb setTextAlignment:NSTextAlignmentCenter];
//            
//            UILabel *lbt=[[UILabel alloc]initWithFrame:CGRectMake(180, xx+50, 70, 40)];
//            //lb.text=@"45.2";
//            [lbt setText:[NSString stringWithFormat:@"%@", [[[ar_Inner objectAtIndex:k]objectForKey:@"days"]objectForKey:@"day-3"]]];
//            [lbt setTextAlignment:NSTextAlignmentCenter];
//            [lbt setTextAlignment:NSTextAlignmentCenter];
//
//            
//            UILabel *l=[[UILabel alloc]initWithFrame:CGRectMake(250, xx+50, 70, 40)];
//            rank++;
//           l.text=[NSString stringWithFormat:@"%d",rank];
//             [l setTextAlignment:NSTextAlignmentCenter];
//            [l setTextAlignment:NSTextAlignmentCenter];
//
//            
//            UILabel *la=[[UILabel alloc]initWithFrame:CGRectMake(320, xx+50, 280, 40)];
//           // la.text=@"L4";//team name
//                 [la setText:[NSString stringWithFormat:@"%@", [[ar_Inner objectAtIndex:k]objectForKey:@"team_name"]]];
//            [la setTextAlignment:NSTextAlignmentCenter];
//
//            
//            UILabel *las=[[UILabel alloc]initWithFrame:CGRectMake(550, xx+50, 250, 40)];
//            [las setText:[NSString stringWithFormat:@"%@", [[ar_Inner objectAtIndex:k]objectForKey:@"location"]]];
//            [las setTextAlignment:NSTextAlignmentCenter];
//            
//            lbls.font=[UIFont fontWithName:@"Enigmatic" size:15];
//            lbl.font=[UIFont fontWithName:@"Enigmatic" size:15];
//            lbt.font=[UIFont fontWithName:@"Enigmatic" size:15];
//
//            lb.font=[UIFont fontWithName:@"Enigmatic" size:15];
//            l.font=[UIFont fontWithName:@"Enigmatic" size:15];
//            la.font=[UIFont fontWithName:@"Enigmatic" size:15];
//            las.font=[UIFont fontWithName:@"Enigmatic" size:15];
//            
//            
//            UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, xx+85, 790, 1)];
//            [imgView setImage:[UIImage imageNamed:@"line_divider.png"]];
//            
//            
//            [printscroll addSubview:lb];
//            [printscroll addSubview:lbl];
//            [printscroll addSubview:lbls];
//            [printscroll addSubview:l];
//            [printscroll addSubview:lbt];
//
//            [printscroll addSubview:la];
//            [printscroll addSubview:las];
//            [printscroll addSubview:imgView];
//            xx=xx+40;
//            
//        }
//        [printscroll addSubview:imgView1];
//        [printscroll addSubview:lb];
//        [printscroll addSubview:lbl];
//        [printscroll addSubview:lbf];
//
//        [printscroll addSubview:lbls];
//        [printscroll addSubview:l];
//        [printscroll addSubview:la];
//        [printscroll addSubview:las];
//        xx=xx+40;
//            NSLog(@"xx=%d",xx);
//       
//      }
//   
//    NSLog(@"xx=%d",xx);
//    
//    //this is for first page//title-bar2.png
//    
//    //[img_Event_head setFrame:CGRectMake(0, 0, 1024, 50)];
//    UIImageView *img_head=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1024, 40)];
//    img_head.image=[UIImage imageNamed:@"title-bar2.png"];
//    [printscroll addSubview:img_head];
//    
//    
//    lbl_Event_Name.textColor=[UIColor whiteColor];
//    lbl_Event_Name.text=[results objectForKey:@"event_name"];
//    [lbl_Event_Name setFrame:CGRectMake(190, 2, 400, 40)];
//    lbl_Event_Name.font=[UIFont fontWithName:@"Enigmatic" size:20];
//    [lbl_Event_Name setTextAlignment:NSTextAlignmentCenter];
//    [printscroll addSubview:lbl_Event_Name];
//    
//    printscroll.contentSize=CGSizeMake(240, xx);
//    printscroll.frame=CGRectMake(0, 0, 770, 920);
//    UIGraphicsBeginPDFContextToFile( pdfFileName,printscroll.bounds, nil );
//    CGContextRef pdfContext = UIGraphicsGetCurrentContext();
//    UIGraphicsBeginPDFPage();
//    //change here
//    CGContextTranslateCTM(pdfContext,0.0, 0.0);
//    [printscroll.layer renderInContext:pdfContext];
//    
//    
//    //int totalNumberOfPages=totalCount/23;
//    if(totalCount<23)
//    {
//    
//    }
//    
//    else if(totalCount%23==0)
//    {
//    
//        int totalNumberOfPages=totalCount/23;
//        for(int i=0;i<totalNumberOfPages-1;i++)//for number of pages  from second page
//        {
//            UIGraphicsBeginPDFPage();
//            printscroll.frame=CGRectMake(0, 150, 770, (i+2)*920);//width of scrollview
//            CGContextTranslateCTM(pdfContext, 0.0, -920*(i+1));
//            [printscroll.layer renderInContext:pdfContext];
//            
//        }
//    
//    }
//    else
//    {
//        int totalNumberOfPages=totalCount/23;
//        for(int i=0;i<totalNumberOfPages;i++)//for number of pages  from second page
//        {
//            UIGraphicsBeginPDFPage();
//            printscroll.frame=CGRectMake(0, 150, 770, (i+2)*920);//width of scrollview
//            CGContextTranslateCTM(pdfContext, 0.0, -920*(i+1));
//            [printscroll.layer renderInContext:pdfContext];
//            
//        }
//    
//    }
//    
//    
//    
//    // remove PDF rendering context
//    UIGraphicsEndPDFContext();
//    
//    
//    
//    
//    
//    
//    NSURL *fileURL = [NSURL fileURLWithPath:pdfFileName];
//    // Initialize Document Interaction Controller
//    self.docController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
//    
//    // Configure Document Interaction Controller
//    [self.docController setDelegate:self];
//    
//    // Preview PDF
//    [self.docController presentPreviewAnimated:YES];
//    
//    
//}

-(IBAction)printBtn_Clicked:(id)sender
{
    int count_TopLevel=(int)[ar_sumary count];
    
    NSMutableArray *arCount=[[NSMutableArray alloc]init];
    
    for(int i=0;i<[ar_sumary count];i++)
    {
        
        NSArray *ar_Inner=[[ar_sumary objectAtIndex:i]objectForKey:@"level_summary"];
        
        [arCount addObject:[NSNumber numberWithInt:(int)[ar_Inner count]]];
    }
    
    int NumberOfRow=0;
    for(int j=0;j<[arCount count];j++)
    {
        NumberOfRow=NumberOfRow+(int)[[arCount objectAtIndex:j]integerValue];
        
    }
    
    NSLog(@"number of rows%d",NumberOfRow);
    int totalCount=count_TopLevel+NumberOfRow+1;//+1 for including header number of lines
    
    
    NSString *fileName = @"Result.pdf";
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *pdfFileName = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    
    // pageSize = CGSizeMake(612, 792);
    
    pageSize = CGSizeMake(612, 792);
    int xx=30;
    for (int i=0; i<  [ar_sumary count]; i++)
    {
        int rank=0;
        UIImageView *imgView1=[[UIImageView alloc]initWithFrame:CGRectMake(0, xx+5, 790, 30)];
        [imgView1 setImage:[UIImage imageNamed:@"stunts-pyramids-tosses-bar-heading.png"]];
        
        UILabel *lbls=[[UILabel alloc]initWithFrame:CGRectMake(20, xx+10, 70, 30)];
        lbls.text=@"Day-1";
        [lbls setBackgroundColor:[UIColor clearColor]];
        [lbls setTextColor:[UIColor whiteColor]];
        lbls.font=[UIFont fontWithName:@"Enigmatic" size:16];
        [lbls setTextAlignment:NSTextAlignmentCenter];
        
        
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(100, xx+10, 70, 30)];
        lbl.text=@"Day-2";
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setTextColor:[UIColor whiteColor]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        
        lbl.font=[UIFont fontWithName:@"Enigmatic" size:16];
        
        
        UILabel *lb=[[UILabel alloc]initWithFrame:CGRectMake(180, xx+10, 70, 30)];
        lb.text=@"Day-3";
        [lb setBackgroundColor:[UIColor clearColor]];
        [lb setTextColor:[UIColor whiteColor]];
        [lb setTextAlignment:NSTextAlignmentCenter];
        
        lb.font=[UIFont fontWithName:@"Enigmatic" size:16];
        
        UILabel *lbf=[[UILabel alloc]initWithFrame:CGRectMake(260, xx+10, 70, 30)];
        lbf.text=@"Final";
        [lbf setBackgroundColor:[UIColor clearColor]];
        [lbf setTextColor:[UIColor whiteColor]];
        [lbf setTextAlignment:NSTextAlignmentCenter];
        
        lbf.font=[UIFont fontWithName:@"Enigmatic" size:16];
        
        
        UILabel *l=[[UILabel alloc]initWithFrame:CGRectMake(340, xx+10, 70, 30)];
        l.text=@"Rank";
        [l setBackgroundColor:[UIColor clearColor]];
        [l setTextColor:[UIColor whiteColor]];
        [l setTextAlignment:NSTextAlignmentCenter];
        
        l.font=[UIFont fontWithName:@"Enigmatic" size:16];
        
        UILabel *la=[[UILabel alloc]initWithFrame:CGRectMake(420, xx+10, 150, 30)];
        la.text=[[ar_sumary objectAtIndex:i]objectForKey:@"level_name"];
        [la setBackgroundColor:[UIColor clearColor]];
        [la setTextColor:[UIColor whiteColor]];
        [la setTextAlignment:NSTextAlignmentCenter];
        la.font=[UIFont fontWithName:@"Enigmatic" size:16];
        
        UILabel *las=[[UILabel alloc]initWithFrame:CGRectMake(580, xx+10, 250, 30)];
        las.text=@"City/State";
        [las setBackgroundColor:[UIColor clearColor]];
        [las setTextColor:[UIColor whiteColor]];
        las.font=[UIFont fontWithName:@"Enigmatic" size:16];
        [las setTextAlignment:NSTextAlignmentCenter];
        
        //NSArray *arTeam_name_Sorted= [[[dicts objectForKey:[sortedLabel objectAtIndex:i]]allKeys]sortedArrayUsingSelector:@selector(compare:)];
        
        
        
        NSArray *ar_Inner=[[ar_sumary objectAtIndex:i]objectForKey:@"level_summary"];
        for(int k=0;k<[ar_Inner count];k++)
        {
            rank=k;
            
            
            UILabel *lbls=[[UILabel alloc]initWithFrame:CGRectMake(260, xx+50, 70, 40)];
            [lbls setText:[NSString stringWithFormat:@"%@", [[ar_Inner objectAtIndex:k]objectForKey:@"final"]]];
            [lbls setTextAlignment:NSTextAlignmentCenter];
            
            
            
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(20, xx+50, 70, 40)];
            //lbl.text=@"30.20";
            [lbl setText:[NSString stringWithFormat:@"%@",[[[ar_Inner objectAtIndex:k]objectForKey:@"days"]objectForKey:@"day-1"]]];
            [lbl setTextAlignment:NSTextAlignmentCenter];
            [lbl setTextAlignment:NSTextAlignmentCenter];
            
            
            UILabel *lb=[[UILabel alloc]initWithFrame:CGRectMake(100, xx+50, 70, 40)];
            //lb.text=@"45.2";
            [lb setText:[NSString stringWithFormat:@"%@", [[[ar_Inner objectAtIndex:k]objectForKey:@"days"]objectForKey:@"day-2"]]];
            [lb setTextAlignment:NSTextAlignmentCenter];
            [lb setTextAlignment:NSTextAlignmentCenter];
            
            UILabel *lbt=[[UILabel alloc]initWithFrame:CGRectMake(180, xx+50, 70, 40)];
            //lb.text=@"45.2";
            [lbt setText:[NSString stringWithFormat:@"%@", [[[ar_Inner objectAtIndex:k]objectForKey:@"days"]objectForKey:@"day-3"]]];
            [lbt setTextAlignment:NSTextAlignmentCenter];
            [lbt setTextAlignment:NSTextAlignmentCenter];
            
            
            UILabel *l=[[UILabel alloc]initWithFrame:CGRectMake(340, xx+50, 70, 40)];
            rank++;
            l.text=[NSString stringWithFormat:@"%d",rank];
            [l setTextAlignment:NSTextAlignmentCenter];
            [l setTextAlignment:NSTextAlignmentCenter];
            
            
            UILabel *la=[[UILabel alloc]initWithFrame:CGRectMake(420, xx+50, 150, 40)];
            // la.text=@"L4";//team name
            [la setText:[NSString stringWithFormat:@"%@", [[ar_Inner objectAtIndex:k]objectForKey:@"team_name"]]];
            [la setTextAlignment:NSTextAlignmentCenter];
            
            
            UILabel *las=[[UILabel alloc]initWithFrame:CGRectMake(580, xx+50, 250, 40)];
            [las setText:[NSString stringWithFormat:@"%@", [[ar_Inner objectAtIndex:k]objectForKey:@"location"]]];
            [las setTextAlignment:NSTextAlignmentCenter];
            
            lbls.font=[UIFont fontWithName:@"Enigmatic" size:15];
            lbl.font=[UIFont fontWithName:@"Enigmatic" size:15];
            lbt.font=[UIFont fontWithName:@"Enigmatic" size:15];

            lb.font=[UIFont fontWithName:@"Enigmatic" size:15];
            l.font=[UIFont fontWithName:@"Enigmatic" size:15];
            la.font=[UIFont fontWithName:@"Enigmatic" size:15];
            las.font=[UIFont fontWithName:@"Enigmatic" size:15];
            
            
            UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, xx+85, 790, 1)];
            [imgView setImage:[UIImage imageNamed:@"line_divider.png"]];
            
            
            [printscroll addSubview:lb];
            [printscroll addSubview:lbl];
            [printscroll addSubview:lbls];
            [printscroll addSubview:l];
            [printscroll addSubview:lbt];
            [printscroll addSubview:la];
            [printscroll addSubview:las];
            [printscroll addSubview:imgView];
            xx=xx+40;
            
        }
        [printscroll addSubview:imgView1];
        [printscroll addSubview:lb];
        [printscroll addSubview:lbl];
        [printscroll addSubview:lbls];
        [printscroll addSubview:l];
        [printscroll addSubview:lbf];
        [printscroll addSubview:lb];
        [printscroll addSubview:la];
        [printscroll addSubview:las];
        xx=xx+40;
        NSLog(@"xx=%d",xx);
        
    }
    
    NSLog(@"xx=%d",xx);
    
    //this is for first page//title-bar2.png
    
    //[img_Event_head setFrame:CGRectMake(0, 0, 1024, 50)];
    UIImageView *img_head=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1024, 40)];
    img_head.image=[UIImage imageNamed:@"title-bar2.png"];
    [printscroll addSubview:img_head];
    
    
    lbl_Event_Name.textColor=[UIColor whiteColor];
    lbl_Event_Name.text=[results objectForKey:@"event_name"];
    [lbl_Event_Name setFrame:CGRectMake(190, 2, 400, 40)];
    lbl_Event_Name.font=[UIFont fontWithName:@"Enigmatic" size:20];
    [lbl_Event_Name setTextAlignment:NSTextAlignmentCenter];
    [printscroll addSubview:lbl_Event_Name];
    
    printscroll.contentSize=CGSizeMake(240, xx);
    printscroll.frame=CGRectMake(0, 0, 770, 920);
    UIGraphicsBeginPDFContextToFile( pdfFileName,printscroll.bounds, nil );
    CGContextRef pdfContext = UIGraphicsGetCurrentContext();
    UIGraphicsBeginPDFPage();
    //change here
    CGContextTranslateCTM(pdfContext,0.0, 0.0);
    [printscroll.layer renderInContext:pdfContext];
    
    
    //int totalNumberOfPages=totalCount/23;
    if(totalCount<23)
    {
        
    }
    
    else if(totalCount%23==0)
    {
        
        int totalNumberOfPages=totalCount/23;
        for(int i=0;i<totalNumberOfPages-1;i++)//for number of pages  from second page
        {
            UIGraphicsBeginPDFPage();
            printscroll.frame=CGRectMake(0, 150, 770, (i+2)*920);//width of scrollview
            CGContextTranslateCTM(pdfContext, 0.0, -920*(i+1));
            [printscroll.layer renderInContext:pdfContext];
            
        }
        
    }
    else
    {
        int totalNumberOfPages=totalCount/23;
        for(int i=0;i<totalNumberOfPages;i++)//for number of pages  from second page
        {
            UIGraphicsBeginPDFPage();
            printscroll.frame=CGRectMake(0, 150, 770, (i+2)*920);//width of scrollview
            CGContextTranslateCTM(pdfContext, 0.0, -920*(i+1));
            [printscroll.layer renderInContext:pdfContext];
            
        }
        
    }
    
    
    
    // remove PDF rendering context
    UIGraphicsEndPDFContext();
    
    
    
    
    
    
    NSURL *fileURL = [NSURL fileURLWithPath:pdfFileName];
    // Initialize Document Interaction Controller
    self.docController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
    
    // Configure Document Interaction Controller
    [self.docController setDelegate:self];
    
    // Preview PDF
    [self.docController presentPreviewAnimated:YES];
    
    
}

- (void)drawPageNumber:(NSInteger)pageNumber
{
    NSString* pageNumberString = [NSString stringWithFormat:@"Page %ld", (long)pageNumber];
    UIFont* theFont = [UIFont systemFontOfSize:20];
    
    CGSize pageNumberStringSize = [pageNumberString sizeWithFont:theFont
                                               constrainedToSize:pageSize
                                                   lineBreakMode:UILineBreakModeWordWrap];
    
    CGRect stringRenderingRect = CGRectMake(kBorderInset,
                                            pageSize.height - 40.0,
                                            pageSize.width - 2*kBorderInset,
                                            pageNumberStringSize.height);
    
    [pageNumberString drawInRect:stringRenderingRect withFont:theFont lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentCenter];
}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
	return self;
}

- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller
{
	return self.view;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller
{
	return self.view.frame;
}
- (void)documentInteractionController:(UIDocumentInteractionController *)controller willBeginSendingToApplication:(NSString *)application
{
    
}

- (void)documentInteractionController:(UIDocumentInteractionController *)controller didEndSendingToApplication:(NSString *)application
{
    
}

- (void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller
{
    
}




@end
