//
//  DetailedOnlineMarksViewController.m
//  SRI Chaitanya Eductional
//
//  Created by Adeptpros on 7/6/15.
//  Copyright (c) 2015 adeptpros. All rights reserved.
//

#import "DetailedOnlineMarksViewController.h"
#import "ServiceEngine.h"
#import "DetailedOnlineCustomTableViewCell.h"
#import "Utility.h"
#import "OnlineMarksViewController.h"
@interface DetailedOnlineMarksViewController ()

@end

@implementation DetailedOnlineMarksViewController

- (void)viewDidLoad
{
    NSString *sre11=[[NSUserDefaults standardUserDefaults]objectForKey:@"TestName"];
    
    [self.navigationItem setTitle:sre11];
    
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backBtn@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    self.navigationItem.leftBarButtonItem=bar;
    
//    NSString *sre11=[[NSUserDefaults standardUserDefaults]objectForKey:@"TestName"];
//
//    [self.navigationItem setTitle:sre11];
    

    arr_Sub=[[NSMutableArray alloc]init];
    arr_Attempted=[[NSMutableArray alloc]init];
    arr_Ttlmarks=[[NSMutableArray alloc]init];
    arr_Ttlqst=[[NSMutableArray alloc]init];
    arr_Wrong=[[NSMutableArray alloc]init];
    arr_Correct=[[NSMutableArray alloc]init];
    arr_Pos=[[NSMutableArray alloc]init];
    arr_Neg=[[NSMutableArray alloc]init];
    
    
    NSString *admin= [[NSUserDefaults standardUserDefaults]objectForKey:@"Admin"];
    NSString *attempt= [[NSUserDefaults standardUserDefaults]objectForKey:@"attemptid"];
    
//    NSString *sre11=[[NSUserDefaults standardUserDefaults]objectForKey:@"TestName"];
//    lbl_Heading.text=sre11;
//    lbl_Heading.textAlignment=NSTextAlignmentCenter;
    
    NSString *jsonReQuest=[NSString stringWithFormat:@"admno=%@&examattemptid=%@",admin,attempt];
    NSString *urlstr=[NSString stringWithFormat:@"http://202.153.37.49/college-student/attemptResults.jml?"];
    
//http://202.153.37.49/college-student/attemptResults.jml?admno=&examattemptid=;
    
    
    urlstr=[urlstr stringByAppendingString:jsonReQuest];
    
    NSString *encodedString = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[ServiceEngine CallService]setWebServiceDelegate:self];
    [[ServiceEngine CallService]PostService:encodedString body:nil context:nil authorization:nil httpMethod:HTTPMethod_POST];
    [Utility startActivityIndicatorOnView:self.view withText:@"SRI Chaitanya"];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


-(void)backButtonAction:(UIBarButtonItem*)sende
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)backBtn:(id)sender;
{
    OnlineMarksViewController *vi=[[OnlineMarksViewController alloc]initWithNibName:@"OnlineMarksViewController" bundle:nil];
    [self presentViewController:vi animated:YES completion:nil];

}

-(void)WebServiceRequestCompleted:(NSDictionary *)result context:(NSString *)context;
{
    NSLog(@"%@",result);
    [Utility stopActivityIndicatorFromView:self.view];
    
   arr= [result objectForKey:@"subjects"];
    
    for (int i=0; i<[arr count]; i++)
    {
        [arr_Sub addObject:[[arr objectAtIndex:i]objectForKey:@"subject"]];
        [arr_Attempted addObject:[[arr objectAtIndex:i]objectForKey:@"Attempted Questions"]];
        [arr_Correct addObject:[[arr objectAtIndex:i]objectForKey:@"Correct Answers"]];
        [arr_Neg addObject:[[arr objectAtIndex:i]objectForKey:@"Negative Marks"]];
        [arr_Pos addObject:[[arr objectAtIndex:i]objectForKey:@"Positive Marks"]];
        [arr_Ttlmarks addObject:[[arr objectAtIndex:i]objectForKey:@"Total Marks"]];
        [arr_Ttlqst addObject:[[arr objectAtIndex:i]objectForKey:@"Total Questions"]];
        [arr_Wrong addObject:[[arr objectAtIndex:i]objectForKey:@"Wrong Answers"]];

    }
    [tableview reloadData];
    
}

-(void)WebServiceRequestFailed:(NSDictionary *)response;
{
    NSLog(@"%@",response);
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:@"" otherButtonTitles:@"", nil];
    
    [alert show];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *Identifier=@"Cell";
    DetailedOnlineCustomTableViewCell *cell =(DetailedOnlineCustomTableViewCell *) [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    if(cell == nil)
    {
        NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"DetailedOnlineCustomTableViewCell" owner:self options:nil];
        
        cell=[topLevelObjects objectAtIndex:0];
    }
    
    cell.lbl_Score.text=[NSString stringWithFormat:@"Scored %d Out Of %d",[[arr_Ttlmarks objectAtIndex:indexPath.row] intValue],[[arr_Ttlqst objectAtIndex:indexPath.row] intValue]];
    
    cell.lbl_Subject.text=[NSString stringWithFormat:@"%@",[arr_Sub objectAtIndex:indexPath.row]];
    cell.lbl_pencil.text=[NSString stringWithFormat:@"%@",[arr_Attempted objectAtIndex:indexPath.row]];
    cell.lbl_tick.text=[NSString stringWithFormat:@"%@",[arr_Correct objectAtIndex:indexPath.row]];
    cell.lbl_plus.text=[NSString stringWithFormat:@"%@",[arr_Pos objectAtIndex:indexPath.row]];
    cell.lbl_cross.text=[NSString stringWithFormat:@"%@",[arr_Wrong objectAtIndex:indexPath.row]];
    cell.lbl_minus.text=[NSString stringWithFormat:@"%@",[arr_Neg objectAtIndex:indexPath.row]];

    return cell;

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 130;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
