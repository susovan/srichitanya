//
//  CustomcellFeeDetails.h
//  SRI Chaitanya Eductional
//
//  Created by susovan on 7/3/15.
//  Copyright (c) 2015 adeptpros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomcellFeeDetails : UITableViewCell

@property(nonatomic,strong)IBOutlet UILabel *attendanceMonth;
@property(nonatomic,strong)IBOutlet UILabel *totalPresent;
@property(nonatomic,strong)IBOutlet UILabel *totalAbsent;
@property(nonatomic,strong)IBOutlet UILabel *totalSick;
@property(nonatomic,strong)IBOutlet UILabel *totalHolidays;
@property(nonatomic,strong)IBOutlet UILabel *totalOuting;


@end
