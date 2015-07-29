//
//  ATTENDANCEViewController.m
//  SRI Chaitanya Eductional
//
//  Created by susovan pati on 7/5/15.
//  Copyright (c) 2015 adeptpros. All rights reserved.
//

#import "ATTENDANCEViewController.h"
#import "CustomcellFeeDetails.h"
#import "ServiceEngine.h"
#import "DetailsViewController.h"
#import "Utility.h"
@interface ATTENDANCEViewController ()

@end

@implementation ATTENDANCEViewController
{
    NSMutableArray *attendanceMonth;
    NSMutableArray *totalAbsent;
    NSMutableArray *totalHolidays;
    NSMutableArray *totalOuting;
    NSMutableArray *totalPresent;
    NSMutableArray *totalSick;

}
- (void)viewDidLoad
{
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backBtn@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    self.navigationItem.leftBarButtonItem=bar;
   

    attendanceMonth=[[NSMutableArray alloc]init];
    totalAbsent=[[NSMutableArray alloc]init];
    totalHolidays=[[NSMutableArray alloc]init];
    totalOuting=[[NSMutableArray alloc]init];
    totalPresent=[[NSMutableArray alloc]init];
    totalSick=[[NSMutableArray alloc]init];
    [self.navigationItem setTitle:@"ATTENDANCE DETAILS"];
    NSString *admin= [[NSUserDefaults standardUserDefaults]objectForKey:@"Admin"];
    
    NSString *jsonReQuest=[NSString stringWithFormat:@"admNo=%@;",admin];
    NSString *urlstr=[NSString stringWithFormat:@"http://202.153.37.44:9580/jsonServices/student/getStudentAttendance;"];
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

-(void)WebServiceRequestCompleted:(NSDictionary *)result context:(NSString *)context
{
    NSLog(@"%@",result);
    [Utility stopActivityIndicatorFromView:self.view];
    
    NSArray *arr=[[result objectForKey:@"ns2.AttendanceDetails"]objectForKey:@"Attendance"];
    for (int i=0; i<[arr count]; i++)
    {
        [attendanceMonth addObject:[[arr objectAtIndex:[[NSString stringWithFormat:@"%d",i]integerValue]]objectForKey:@"attendanceMonth"]];
        [totalAbsent addObject:[[arr objectAtIndex:[[NSString stringWithFormat:@"%d",i]integerValue ]]objectForKey:@"totalAbsent"]];
        [totalHolidays addObject:[[arr objectAtIndex:[[NSString stringWithFormat:@"%d",i] integerValue]]objectForKey:@"totalHolidays"]];

        [totalOuting addObject:[[arr objectAtIndex:[[NSString stringWithFormat:@"%d",i] integerValue]]objectForKey:@"totalOuting"]];
        [totalPresent addObject:[[arr objectAtIndex:[[NSString stringWithFormat:@"%d",i] integerValue]]objectForKey:@"totalPresent"]];
        [totalSick addObject:[[arr objectAtIndex:[[NSString stringWithFormat:@"%d",i] integerValue]]objectForKey:@"totalSick"]];
        
    }
    
    [tablattendance reloadData];
    
}
-(IBAction)backbutton:(id)sender;
{
    DetailsViewController *vi=[[DetailsViewController alloc]initWithNibName:@"DetailsViewController" bundle:nil];
    [self presentViewController:vi animated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier=@"Cell1";
    CustomcellFeeDetails *dcell =(CustomcellFeeDetails *) [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    if(dcell == nil)
    {
        NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CustomcellFeeDetails" owner:self options:nil];
        dcell=[topLevelObjects objectAtIndex:0];
    }
     dcell.attendanceMonth.text=[NSString stringWithFormat:@"%@",[attendanceMonth objectAtIndex:indexPath.row]];
     dcell.totalAbsent.text=[NSString stringWithFormat:@"%@",[totalAbsent objectAtIndex:indexPath.row]];
     dcell.totalHolidays.text=[NSString stringWithFormat:@"%@",[totalHolidays objectAtIndex:indexPath.row]];
     dcell.totalOuting.text=[NSString stringWithFormat:@"%@",[totalOuting objectAtIndex:indexPath.row]];
     dcell.totalPresent.text=[NSString stringWithFormat:@"%@",[totalPresent objectAtIndex:indexPath.row]];
     dcell.totalSick.text=[NSString stringWithFormat:@"%@",[totalSick objectAtIndex:indexPath.row]];
    
    return dcell;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [attendanceMonth count];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
