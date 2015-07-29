//
//  OnlineMarksCustomcell.m
//  SRI Chaitanya Eductional
//
//  Created by Adeptpros on 7/6/15.
//  Copyright (c) 2015 adeptpros. All rights reserved.
//

#import "OnlineMarksCustomcell.h"

@implementation OnlineMarksCustomcell
@synthesize lbl_Examdate,lbl_Testname,img;
- (void)awakeFromNib {
    
    [lbl_Testname sizeToFit];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
