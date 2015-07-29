//
//  DetailsViewController.m
//  SRI Chaitanya Eductional
//
//  Created by susovan on 7/2/15.
//  Copyright (c) 2015 adeptpros. All rights reserved.
//

#import "DetailsViewController.h"
#import "FEEDetailViewController.h"
#import "ATTENDANCEViewController.h"
#import "OnlineMarksViewController.h"
#import "offlineMarksViewController.h"
#import "StudentDetailsViewController.h"
@interface DetailsViewController ()

@end

@implementation DetailsViewController


- (void)viewDidLoad
{
    
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backBtn@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    
    self.navigationItem.leftBarButtonItem=bar;
    
    
    studentname.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"StudentNm"];
    adminNO.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"Admin"];

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)backButtonAction:(UIBarButtonItem*)sende
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)backButton:(id)sender;
{
    StudentDetailsViewController *obj=[[StudentDetailsViewController alloc]initWithNibName:@"StudentDetailsViewController" bundle:nil];
    [self.navigationController pushViewController:obj animated:YES];
}
-(IBAction)freedetails:(id)sender
{
    FEEDetailViewController *obj=[[FEEDetailViewController alloc]initWithNibName:@"FEEDetailViewController" bundle:nil];
    [self.navigationController pushViewController:obj animated:YES];
}
-(IBAction)attendance:(id)sender;
{
    ATTENDANCEViewController *obj=[[ATTENDANCEViewController alloc]initWithNibName:@"ATTENDANCEViewController" bundle:nil];
    [self.navigationController pushViewController:obj animated:YES];
}
-(IBAction)offlinemark:(id)sender
{
    offlineMarksViewController *obj=[[offlineMarksViewController alloc]initWithNibName:@"offlineMarksViewController" bundle:nil];
    [self.navigationController pushViewController:obj animated:YES];
}
-(IBAction)onlinemark:(id)sender;
{
    OnlineMarksViewController *obj=[[OnlineMarksViewController alloc]initWithNibName:@"OnlineMarksViewController" bundle:nil];
    [self.navigationController pushViewController:obj animated:YES];
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
