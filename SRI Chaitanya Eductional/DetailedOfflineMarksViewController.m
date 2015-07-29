//
//  DetailedOfflineMarksViewController.m
//  SRI Chaitanya Eductional
//
//  Created by Adeptpros on 7/7/15.
//  Copyright (c) 2015 adeptpros. All rights reserved.
//

#import "DetailedOfflineMarksViewController.h"
#import "ServiceEngine.h"
#import "DetailedOfflineMarksCustomCell.h"
#import "Utility.h"
#import "offlineMarksViewController.h"
@interface DetailedOfflineMarksViewController ()

@end

@implementation DetailedOfflineMarksViewController

- (void)viewDidLoad
{
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backBtn@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    self.navigationItem.leftBarButtonItem=bar;
    
    NSString *sre11=[[NSUserDefaults standardUserDefaults]objectForKey:@"testCode"];
    [self.navigationItem setTitle:sre11];
    
    arr_Marks=[[NSMutableArray alloc]init];
    arr_Maxmarks=[[NSMutableArray alloc]init];
    arr_Sub=[[NSMutableArray alloc]init];
    arr_Testmode=[[NSMutableArray alloc]init];
    arr_Rank=[[NSMutableArray alloc]init];
    

    NSString *admin= [[NSUserDefaults standardUserDefaults]objectForKey:@"Admin"];
    NSString *attempt= [[NSUserDefaults standardUserDefaults]objectForKey:@"testCode"];

    
    NSString *jsonReQuest=[NSString stringWithFormat:@"admNo=%@;testCode=%@",admin,attempt];
    NSString *urlstr=[NSString stringWithFormat:@"http://202.153.37.44:9580/jsonServices/student/getStudentOfflineTestWiseMarks;"];
    
//http://202.153.37.44:9580/jsonServices/student/getStudentOfflineTestWiseMarks;admNo=;testCode=;
    

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
    offlineMarksViewController *vi=[[offlineMarksViewController alloc]initWithNibName:@"offlineMarksViewController" bundle:nil];
    [self presentViewController:vi animated:YES completion:nil];

}

-(void)WebServiceRequestCompleted:(NSDictionary *)result context:(NSString *)context;
{
    NSLog(@"%@",result);
    
    [Utility stopActivityIndicatorFromView:self.view];
    
    
   // NSString *sre  =[result objectForKey:@"ns2.MarksDetails"];
    
   // [[NSUserDefaults standardUserDefaults]setValue:sre forKey:@"result"];
    
    NSDictionary *dict;
    
    dict=[result objectForKey:@"ns2.MarksDetails"];
    
    arr=[dict objectForKey:@"Marks"];
    
    for (int i=0; i<[arr count]; i++)
    {
      [arr_Testmode addObject:[[arr objectAtIndex:i]objectForKey:@"testMode"]];
      [arr_Sub addObject:[[arr objectAtIndex:i]objectForKey:@"subject"]];
      [arr_Marks addObject:[[arr objectAtIndex:i]objectForKey:@"marks"]];
      [arr_Maxmarks addObject:[[arr objectAtIndex:i]objectForKey:@"maxMarks"]];
      [arr_Rank addObject:[[arr objectAtIndex:i]objectForKey:@"rank"]];
    }
    
    [tableview setDelegate:self];
    [tableview setDataSource:self];
    
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
    DetailedOfflineMarksCustomCell *cell =(DetailedOfflineMarksCustomCell *) [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    if(cell == nil)
    {
        NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"DetailedOfflineMarksCustomCell" owner:self options:nil];
        
        cell=[topLevelObjects objectAtIndex:0];
    }
    
//    NSString *attempt= [[NSUserDefaults standardUserDefaults]objectForKey:@"result"];
//    NSLog(@"%@",attempt);
    
    
    cell.lbl_Testmode.text=[arr_Testmode objectAtIndex:indexPath.row];
    
    cell.lbl_Marks.text=[NSString stringWithFormat:@"Scored %d Out Of %d",[[arr_Marks objectAtIndex:indexPath.row] intValue],[[arr_Maxmarks objectAtIndex:indexPath.row] intValue]];

    
//    cell.lbl_Marks.text=[NSString stringWithFormat:@"%@",[arr_Marks objectAtIndex:indexPath.row]];
//    cell.lbl_Maxmarks.text=[NSString stringWithFormat:@"%@",[arr_Maxmarks objectAtIndex:indexPath.row]];
    cell.lbl_Rank.text=[NSString stringWithFormat:@"%@",[arr_Rank objectAtIndex:indexPath.row]];
    cell.lbl_Subject.text=[arr_Sub objectAtIndex:indexPath.row];

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
