//
//  RankingEventViewController.h
//  Cheer&Dance
//
//  Created by Madhava Reddy on 3/24/14.
//  Copyright (c) 2014 Adeptpros. All rights reserved.
//
#define kBorderInset            20.0
#define kBorderWidth            1.0
#define kMarginInset            10.0

//Line drawing
#define kLineWidth              1.0

#import <UIKit/UIKit.h>
#import "WebService.h"

@interface RankingEventViewController : UIViewController <WebServiceCompleteDelegate,UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIDocumentInteractionControllerDelegate>
{
     WebService *m_pWebService;
    NSString *CheckWebService;
    NSArray *event_SummaryAry;
    IBOutlet UILabel *rankingEvent_Title,*Lbl_Eventname,*Lbl_date;
    UITableView *rankingTable;
    IBOutlet UILabel *Lbl_TeamnameTitle,*Lbl_stuntsTitle,*Lbl_ThumblingTitle,*Lbl_ChoreographyTitle,*Lbl_DeductionTitle,*Lbl_TotalscoreTitle,*Lbl_RankTitle,*Lbl_DANCETitle;
    

    IBOutlet UIScrollView *printscroll;
    IBOutlet UIView *reportView;
    IBOutlet UIButton *btn_Generate_pdf;
    
      CGSize pageSize;
    
    UIAlertView *rankingAlert;
    
    UIPickerView *pickview;
    IBOutlet  UIView *picker_uiview;
    IBOutlet UIButton *btn_Division;
    IBOutlet UITextField *txt_Diviosn_Drop;
    
    IBOutlet UILabel *lbl_Event_Name;
    IBOutlet UIImageView *img_Event_head;

}
-(IBAction)backFrom_rankingEvent:(id)sender;
-(IBAction)btn_ClickedForDivisonDrop:(id)sender;
-(IBAction)btn_Done_From_Divison_Picker:(id)sender;
@property(nonatomic,retain) UIPopoverController *aPopover;
@property(nonatomic,retain) UIViewController *popView;
@property(strong,nonatomic)UIDocumentInteractionController *docController;

@end
