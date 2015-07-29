//
//  offlineMarksViewController.m
//  SRI Chaitanya Eductional
//
//  Created by Adeptpros on 7/7/15.
//  Copyright (c) 2015 adeptpros. All rights reserved.
//

#import "offlineMarksViewController.h"
#import "ServiceEngine.h"
#import "OfflineMarksCustomCell.h"
#import "DetailedOfflineMarksViewController.h"
#import "Utility.h"
#import "DetailsViewController.h"
@interface offlineMarksViewController ()

@end

@implementation offlineMarksViewController

- (void)viewDidLoad
{
    
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backBtn@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    self.navigationItem.leftBarButtonItem=bar;
   
    [self.navigationItem setTitle:@"OFFLINE MARKS"];
    
    arr_Testdt=[[NSMutableArray alloc]init];
    arr_Testmode=[[NSMutableArray alloc]init];
    arr_Marks=[[NSMutableArray alloc]init];
    arr_Maxmks=[[NSMutableArray alloc]init];
    arr_Rank=[[NSMutableArray alloc]init];
    arr_Sub=[[NSMutableArray alloc]init];
    arr_Testcode=[[NSMutableArray alloc]init];

    NSString *admin= [[NSUserDefaults standardUserDefaults]objectForKey:@"Admin"];
    
    NSString *jsonReQuest=[NSString stringWithFormat:@"admNo=%@",admin];
    NSString *urlstr=[NSString stringWithFormat:@"http://202.153.37.44:9580/jsonServices/student/getStudentOfflineTotals;"];
    
    // http://202.153.37.44:9580/jsonServices/student/getStudentOfflineTotals;admNo=;
    
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


-(void)WebServiceRequestCompleted:(NSDictionary *)result context:(NSString *)context;
{
    NSLog(@"%@",result);
    [Utility stopActivityIndicatorFromView:self.view];
    
    NSDictionary *dict;
    
    dict=[result objectForKey:@"ns2.MarksDetails"];
    
   if (![dict isEqual:@""])
    {
    if([[dict objectForKey:@"Marks"] isKindOfClass:[NSArray class]])
    {
        arr=[dict objectForKey:@"Marks"];
        
        for (int i=0; i<[arr count]; i++)
        {
            [arr_Testmode addObject:[[arr objectAtIndex:i]objectForKey:@"testMode"]];
            [arr_Testdt addObject:[[arr objectAtIndex:i]objectForKey:@"testDate"]];
            [arr_Marks addObject:[[arr objectAtIndex:i]objectForKey:@"marks"]];
            [arr_Maxmks addObject:[[arr objectAtIndex:i]objectForKey:@"maxMarks"]];
            [arr_Rank addObject:[[arr objectAtIndex:i]objectForKey:@"rank"]];
            [arr_Sub addObject:[[arr objectAtIndex:i]objectForKey:@"subject"]];
            [arr_Testcode addObject:[[arr objectAtIndex:i]objectForKey:@"testCode"]];
        }
    }
    else
    {
        [arr_Testmode addObject:[[dict objectForKey:@"Marks"]objectForKey:@"testMode"]];
        [arr_Testdt addObject:[[dict objectForKey:@"Marks"] objectForKey:@"testDate"]];
        [arr_Marks addObject:[[dict objectForKey:@"Marks"] objectForKey:@"marks"]];
        [arr_Maxmks addObject:[[dict objectForKey:@"Marks"] objectForKey:@"maxMarks"]];
        [arr_Rank addObject:[[dict objectForKey:@"Marks"] objectForKey:@"rank"]];
        [arr_Sub addObject:[[dict objectForKey:@"Marks"] objectForKey:@"subject"]];
        [arr_Testcode addObject:[[dict objectForKey:@"Marks"] objectForKey:@"testCode"]];
    }
 
 }
    
    else
    {
//        [self dismissViewControllerAnimated:YES completion:nil];
        
        [Utility showToast:@"NO DATA" inView:self.view];
        
        
        
        
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"No Data" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@".k", nil];
//            
//            [alert show];
    }

    [tableview setDelegate:self];
    [tableview setDataSource:self];
    
    [tableview reloadData];
    
}

-(IBAction)backBtn:(id)sender;
{
    DetailsViewController *vi=[[DetailsViewController alloc]initWithNibName:@"DetailsViewController" bundle:nil];
    [self presentViewController:vi animated:YES completion:nil];

}

-(void)WebServiceRequestFailed:(NSDictionary *)response;
{
    NSLog(@"%@",response);
    
    [Utility stopActivityIndicatorFromView:self.view];
    [Utility showToast:@"Exception report" inView:self.view];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return [arr_Testmode count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *Identifier=@"Cell";
    OfflineMarksCustomCell *cell =(OfflineMarksCustomCell *) [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    if(cell == nil)
    {
        NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"OfflineMarksCustomCell" owner:self options:nil];
        
        cell=[topLevelObjects objectAtIndex:0];
        
        
    }
    
    cell.lbl_Testmode.text=[arr_Testmode objectAtIndex:indexPath.row];
    cell.lbl_Testdt.text=[arr_Testdt objectAtIndex:indexPath.row];
    cell.lbl_Testcode.text=[arr_Testcode objectAtIndex:indexPath.row];
    
    cell.lbl_Marks.text=[NSString stringWithFormat:@"Scored %d Out Of %d",[[arr_Marks objectAtIndex:indexPath.row] intValue],[[arr_Maxmks objectAtIndex:indexPath.row] intValue]];

//    cell.lbl_Marks.text=[NSString stringWithFormat:@"%@",[arr_Marks objectAtIndex:indexPath.row]];
//    cell.lbl_Maxmks.text=[NSString stringWithFormat:@"%@",[arr_Maxmks objectAtIndex:indexPath.row]];
    cell.lbl_Rank.text=[NSString stringWithFormat:@"%@",[arr_Rank objectAtIndex:indexPath.row]];

    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 150;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell* theCell = [tableView cellForRowAtIndexPath:indexPath];
        theCell.contentView.backgroundColor=[UIColor whiteColor];
    
    //Deselect the cell so you can see the color change
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//    cell.contentView.backgroundColor = [UIColor whiteColor];

    NSString *sre =[arr_Testcode objectAtIndex:indexPath.row];
    
    [[NSUserDefaults standardUserDefaults]setObject:sre forKey:@"testCode"];

    
    DetailedOfflineMarksViewController *qwe=[[DetailedOfflineMarksViewController alloc]initWithNibName:@"DetailedOfflineMarksViewController" bundle:nil];
    
    [self.navigationController pushViewController:qwe animated:YES];

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
