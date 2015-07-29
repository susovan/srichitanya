//
//  LeftPaneViewController1.h
//  Cheer&Dance
//
//  Created by Madhava Reddy on 3/7/14.
//  Copyright (c) 2014 Adeptpros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebService.h"
#import "JSON.h"

@interface LeftPaneViewController1 : UIViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,WebServiceCompleteDelegate>
{
    int row_selected;
     WebService *m_pWebService;
     UITableView *leftTable;
    IBOutlet UILabel *leftpane_heading;
    
    // Search bar
     IBOutlet UISearchBar *search;
    NSMutableArray *CopylistofTeams;
    NSDictionary *Team_dicts;
    
}


@end
