//
//  RankingCell.m
//  Cheer&Dance
//
//  Created by Madhava Reddy on 3/24/14.
//  Copyright (c) 2014 Adeptpros. All rights reserved.
//

#import "RankingCell.h"

@implementation RankingCell
@synthesize lbl_Final_Score,lbl_Day_1_Score,lbl_Day_2_Score,lbl_Rank,lbl_LabelName,lbl_location;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
