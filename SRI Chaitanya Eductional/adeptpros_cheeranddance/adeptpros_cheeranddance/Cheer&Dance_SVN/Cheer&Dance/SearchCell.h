//
//  SearchCell.h
//  Cheer&Dance
//
//  Created by Madhava Reddy on 2/25/14.
//  Copyright (c) 2014 Adeptpros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UILabel *lbl_Team_Name;
@property(nonatomic,strong)IBOutlet UILabel *lbl_Divison_Name;
@property(nonatomic,strong)IBOutlet UILabel *lbl_City_Name;
@property(nonatomic,strong)IBOutlet UILabel *lbl_WarmUp_Time;
@property(nonatomic,strong)IBOutlet UILabel *lbl_Perform_Time;
@property(nonatomic,strong)IBOutlet UILabel *lbl_Floor_Name;


@end
