//
//  CustomCell.m
//  Cheer&Dance
//
//  Created by KUNDAN on 12/30/13.
//  Copyright (c) 2013 Adeptpros. All rights reserved.
//

#import "CustomCell.h"
#import "ViewController.h"
#import "Singleton.h"
NSArray *ars;
@implementation CustomCell
@synthesize more_btn,Lbl_headings,lbl_possible_points,lbl_cell_scoreTitle,lbl_cell_commentTitle;
@synthesize img_div1,img_div2,img_div3,img_div4;

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
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}




- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    static NSCharacterSet *charSet = nil;
    if(!charSet) {
        charSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet] ;
    }
    
    NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    int length = (int)[currentString length];
    if (length >3) {
        return NO;
    }
   
    
    NSRange strLocation = [string rangeOfCharacterFromSet:charSet];
    return (strLocation.location == NSNotFound);
}






@end
