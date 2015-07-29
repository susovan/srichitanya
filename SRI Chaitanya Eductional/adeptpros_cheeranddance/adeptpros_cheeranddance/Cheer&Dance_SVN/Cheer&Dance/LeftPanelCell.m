//
//  LeftPanelCell.m
//  Cheer&Dance
//
//  Created by Madhava Reddy on 3/7/14.
//  Copyright (c) 2014 Adeptpros. All rights reserved.
//

#import "LeftPanelCell.h"

@implementation LeftPanelCell
@synthesize teamTitle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
