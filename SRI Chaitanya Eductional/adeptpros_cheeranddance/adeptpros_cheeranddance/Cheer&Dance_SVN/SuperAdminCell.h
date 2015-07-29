//
//  SuperAdminCell.h
//  VotingTalents
//
//  Created by madhu on 11/29/10.
//  Copyright 2010 __Geniusport__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SuperAdminCell:UITableViewCell {
	IBOutlet UILabel *NameOfDirector;
	IBOutlet UILabel *MailIdOfDirector;

}

@property (nonatomic, retain) UILabel *NameOfDirector;
@property (nonatomic, retain) UILabel *MailIdOfDirector;

@end
