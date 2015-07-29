//
//  StudentDetailsViewController.m
//  SRI Chaitanya Eductional
//
//  Created by susovan on 7/2/15.
//  Copyright (c) 2015 adeptpros. All rights reserved.
//

#import "StudentDetailsViewController.h"
#import "DetailsViewController.h"
#import "StudentSearchCell.h"
#import "Utility.h"
#import "SearchViewcontroller.h"
@interface StudentDetailsViewController ()
{
    NSDictionary *dictTempData;
    IBOutlet UILabel *admno;
}

@end

@implementation StudentDetailsViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andMyData:(NSDictionary *)tempData{
    if(self == nil)
   self =  [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    dictTempData = tempData;
    [[NSUserDefaults standardUserDefaults]setObject:tempData forKey:@"searchresult"];
    return self;
}

- (void)viewDidLoad
{
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backBtn@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    self.navigationItem.leftBarButtonItem=bar;

    
    arr_AdmNo=[[NSMutableArray alloc]init];
    arr_Campus=[[NSMutableArray alloc]init];
    arr_City=[[NSMutableArray alloc]init];
    arr_PrnNm=[[NSMutableArray alloc]init];
    arr_StdNm=[[NSMutableArray alloc]init];

    NSLog(@"%@",dictTempData);
    NSDictionary *dict1;
    

    NSDictionary *dict;
   dict1=[[NSUserDefaults standardUserDefaults]objectForKey:@"searchresult"];
    dict=[dict1 objectForKey:@"ns2.StudentDetails"];
    
    //dict=[dictTempData objectForKey:@"ns2.StudentDetails"];
    
   
        if([[dict objectForKey:@"Student"] isKindOfClass:[NSArray class]])
        {
           NSArray * arr=[dict objectForKey:@"Student"];
            
            for (int i=0; i<[arr count]; i++)
            {
              //  [arr_Maxmks addObject:[[arr objectAtIndex:i]objectForKey:@"maxMarks"]];

                [arr_AdmNo addObject:[[arr objectAtIndex:i]objectForKey:@"admNo"]];
                
                
                NSString *str1=[[arr objectAtIndex:i]objectForKey:@"city"];
                NSString *str2=[[arr objectAtIndex:i] objectForKey:@"campus"];
                NSString *str3=[NSString stringWithFormat:@"Studying in %@ at %@",str2,str1];
                
                [arr_City addObject:str3];
                [arr_PrnNm addObject:[[arr objectAtIndex:i] objectForKey:@"parentName"]];
                [arr_StdNm addObject:[[arr objectAtIndex:i] objectForKey:@"studentName"]];
            }
        }
        else
        {
            [arr_AdmNo addObject:[[dict objectForKey:@"Student"]objectForKey:@"admNo"]];
            
            NSString *str1=[[dict objectForKey:@"Student"]objectForKey:@"city"];
            NSString *str2=[[dict objectForKey:@"Student"] objectForKey:@"campus"];
            NSString *str3=[NSString stringWithFormat:@"Studying in %@ at %@",str2,str1];
            
            [arr_City addObject:str3];
            [arr_PrnNm addObject:[[dict objectForKey:@"Student"] objectForKey:@"parentName"]];
            [arr_StdNm addObject:[[dict objectForKey:@"Student"] objectForKey:@"studentName"]];
        }
        

    [tableview_StudentDetails setDelegate:self];
    [tableview_StudentDetails setDataSource:self];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)backButtonAction:(UIBarButtonItem*)sende
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [arr_AdmNo count];
}

-(IBAction)backButton:(id)sender;
{
    SearchViewcontroller *obj=[[SearchViewcontroller alloc]initWithNibName:@"SearchViewcontroller" bundle:nil];
    [self presentViewController:obj animated:YES completion:nil];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *Identifier=@"Cell";
    StudentSearchCell *cell =(StudentSearchCell *) [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    if(cell == nil)
    {
        NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"StudentSearchCell" owner:self options:nil];
        cell=[topLevelObjects objectAtIndex:0];
    }
    
    cell.admin_No.text=[NSString stringWithFormat:@"%@",[arr_AdmNo objectAtIndex:indexPath.row]];
    cell.student_Name.text=[arr_StdNm objectAtIndex:indexPath.row];
    cell.parent_Name.text=[arr_PrnNm objectAtIndex:indexPath.row];
    cell.city_Nm.text=[arr_City objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 145;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *sre  =[NSString stringWithFormat:@"%@",[arr_AdmNo objectAtIndex:indexPath.row]];
    NSString *sre1  =[arr_StdNm objectAtIndex:indexPath.row];

    
    [[NSUserDefaults standardUserDefaults]setObject:sre forKey:@"Admin"];
    [[NSUserDefaults standardUserDefaults]setObject:sre1 forKey:@"StudentNm"];

    
    DetailsViewController *qwe=[[DetailsViewController alloc]initWithNibName:@"DetailsViewController" bundle:nil];
    
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
