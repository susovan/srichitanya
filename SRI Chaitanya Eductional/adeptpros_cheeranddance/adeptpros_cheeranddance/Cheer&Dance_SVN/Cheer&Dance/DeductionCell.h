//
//  DeductionCell.h
//  Cheer&Dance
//
//  Created by KUNDAN on 1/9/14.
//  Copyright (c) 2014 Adeptpros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeductionCell : UITableViewCell
{

}

@property(nonatomic,strong)IBOutlet UILabel *Lbl_cellHeading_fromDeduct1;

@property(nonatomic,strong)IBOutlet UILabel *Lbl_leftTitle_inDeduct;
@property(nonatomic,strong)IBOutlet UILabel *Lbl_centerTitle_inDeduct;
@property(nonatomic,strong)IBOutlet UILabel *Lbl_rightTitle_inDeduct;
@property(nonatomic,strong)IBOutlet UILabel *Lbl_deductionTitle_inDeduct;

@property(nonatomic,strong)IBOutlet UILabel *Lbl_commentsTitle_inDeduct;

@property(nonatomic,strong)IBOutlet UILabel *lbl_lastLine_deduction;
@property(nonatomic,strong)IBOutlet UILabel *lbl_1stLine_deduction;
@property(nonatomic,strong)IBOutlet UILabel *lbl_2ndLine_deduction;
@property(nonatomic,strong)IBOutlet UILabel *lbl_3rdLine_deduction;
@property(nonatomic,strong)IBOutlet UIImageView *img_leftDivider;
@property(nonatomic,strong)IBOutlet UIImageView *img_centerDivider;
@property(nonatomic,strong)IBOutlet UIImageView *img_rightDivider;
@property(nonatomic,strong)IBOutlet UIButton *Deductcell_cmt_btn;





@end
