//
//  ViewController.h
//  Package
//
//  Created by luozhuocheng on 16/7/13.
//  Copyright © 2016年 luozhuocheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

{
    IBOutlet NSButton *btnSubmit;
    IBOutlet NSButton *btnLingYu;
    IBOutlet NSButton *btnShuShan; 
    
    IBOutlet NSTextView *textView;
    
    IBOutlet NSTextField *textNeed; 
    IBOutlet NSTextField *textSuccess;
}

@end

