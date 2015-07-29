//
//  OnlineMarksViewController.m
//  SRI Chaitanya Eductional
//
//  Created by Adeptpros on 7/6/15.
//  Copyright (c) 2015 adeptpros. All rights reserved.
//

#import "OnlineMarksViewController.h"
#import "ServiceEngine.h"
#import "OnlineMarksCustomcell.h"
#import "DetailedOnlineMarksViewController.h"
#import "DetailsViewController.h"
#import "Utility.h"
@interface OnlineMarksViewController ()

@end

@implementation OnlineMarksViewController

- (void)viewDidLoad
{
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backBtn@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    
    self.navigationItem.leftBarButtonItem=bar;
    
    [self.navigationItem setTitle:@"ONLINE MARKS"];
    
    
    NSString *admin= [[NSUserDefaults standardUserDefaults]objectForKey:@"Admin"];
    
    NSString *jsonReQuest=[NSString stringWithFormat:@"admno=%@",admin];
    NSString *urlstr=[NSString stringWithFormat:@"http://202.153.37.49/college-student/mobileResults.jml?"];
    
//http://202.153.37.49/college-student/mobileResults.jml?admno=;


    urlstr=[urlstr stringByAppendingString:jsonReQuest];
    
    NSString *encodedString = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[ServiceEngine CallService]setWebServiceDelegate:self];
    
    [[ServiceEngine CallService]PostService:encodedString body:nil context:nil authorization:nil httpMethod:HTTPMethod_POST];

    [Utility startActivityIndicatorOnView:self.view withText:@"SRI Chaitanya"];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)backBtn:(id)sender;
{
   
    DetailsViewController *vi=[[DetailsViewController alloc]initWithNibName:@"DetailsViewController" bundle:nil];
    [self presentViewController:vi animated:YES completion:nil];

}

-(void)backButtonAction:(UIBarButtonItem*)sende
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)WebServiceRequestCompleted:(NSDictionary *)result context:(NSString *)context;
{
    NSLog(@"%@",result);
    [Utility stopActivityIndicatorFromView:self.view];
    
  arr= [result objectForKey:@"attempts"];
    if (![arr count]==0)
    {
        for (int i=0; i<[arr count]; i++)
        {
            attempt_id=[[arr objectAtIndex:i]objectForKey:@"attemptid"];
            
            [arr_Examdate addObject:[[arr objectAtIndex:i]objectForKey:@"ExamDate"]];
            [arr_Testname addObject:[[arr objectAtIndex:i]objectForKey:@"TestName"]];
            
            
            [tableview_online reloadData];
            
        }

    }
    else
    {
        [Utility showToast:@"NoData" inView:self.view];
    }
    
    
//        for (int i=0; i<[arr count]; i++)
//        {
//            attempt_id=[[arr objectAtIndex:i]objectForKey:@"attemptid"];
//            
//            [arr_Examdate addObject:[[arr objectAtIndex:i]objectForKey:@"ExamDate"]];
//            [arr_Testname addObject:[[arr objectAtIndex:i]objectForKey:@"TestName"]];
//            
//            
//            [tableview_online reloadData];
    
        


    }
    


-(void)WebServiceRequestFailed:(NSDictionary *)response;
{
    NSLog(@"%@",response);
    
    [Utility stopActivityIndicatorFromView:self.view];
    
    
    
    [Utility showToast:@"Exception report" inView:self.view];
    

    
    }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *Identifier=@"Cell";
    OnlineMarksCustomcell *cell =(OnlineMarksCustomcell *) [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    if(cell == nil)
    {
        NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"OnlineMarksCustomcell" owner:self options:nil];
        
        cell=[topLevelObjects objectAtIndex:0];
    }
    
    [cell.lbl_Testname sizeToFit];
    
    cell.lbl_Examdate.text=[[arr objectAtIndex:indexPath.row]objectForKey:@"TestName"];
    cell.lbl_Testname.text=[[arr objectAtIndex:indexPath.row]objectForKey:@"ExamDate"];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 100;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *sre  =[[arr objectAtIndex:indexPath.row]objectForKey:@"attemptid"];
    NSString *sre1=[[arr objectAtIndex:indexPath.row]objectForKey:@"TestName"];
    
   [[NSUserDefaults standardUserDefaults]setObject:sre forKey:@"attemptid"];
    [[NSUserDefaults standardUserDefaults]setObject:sre1 forKey:@"TestName"];

    
    DetailedOnlineMarksViewController *qwe=[[DetailedOnlineMarksViewController alloc]initWithNibName:@"DetailedOnlineMarksViewController" bundle:nil];
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
