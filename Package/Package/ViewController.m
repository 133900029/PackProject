//
//  ViewController.m
//  Package
//
//  Created by luozhuocheng on 16/7/13.
//  Copyright © 2016年 luozhuocheng. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController




NSPipe *NSOutPipe;
NSString *result_str;
NSArray *arrayLingYu;
NSArray *arrayShuShan;
NSArray *arrayHuanLing;
NSArray *arrayXianMoBian;

NSArray *arrayProjectName;
NSArray *arrayPath;
NSMutableArray *arrayBtn;
int game=0;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrayLingYu=[[NSArray alloc]initWithObjects:
                 @"AppStore:changyuyouxi_distribution:1000001:游戏名字:adhoc:cdf78db7-5cfe-4cfd-9c9a-821ff9743ae5",
                    nil];
    arrayShuShan=[[NSArray alloc]initWithObjects:
                  @"AppStore:changyuyouxi_distribution:1000002:游戏名字:adhoc:cdf78db7-5cfe-4cfd-9c9a-821ff9743ae5",
                  nil];
    arrayHuanLing=[[NSArray alloc]initWithObjects:
                   @"AppStore:changyuyouxi_distribution:1000003:游戏名字:adhoc:cdf78db7-5cfe-4cfd-9c9a-821ff9743ae5",
                   nil];
    arrayXianMoBian=[[NSArray alloc]initWithObjects:
                   @"AppStore:changyuyouxi_distribution:1000004:游戏名字:adhoc:cdf78db7-5cfe-4cfd-9c9a-821ff9743ae5",
                   nil];
    
    
    arrayPath=[[NSArray alloc]initWithObjects:
               @"/Users/luozhuocheng/IOS/PackProject/LingYu",
               @"/Users/luozhuocheng/IOS/PackProject/ShuShan",
               @"/Users/luozhuocheng/IOS/PackProject/HuanLing",
               @"/Users/luozhuocheng/IOS/PackProject/XianMoBian",
               nil];
    
    
    arrayProjectName=[[NSArray alloc]initWithObjects:
                      @"lingyu",
                      @"shushan",
                      @"huanling",
                      @"xianmobian",
                      nil];
    
      
    
    arrayBtn=[[NSMutableArray alloc]init];
    
    
    
 
    textView.editable=false;
    
    
    
 
}
-(void)viewDidAppear
{
    [super viewDidAppear];
    
 
    
    
    [self CreateRadioBtn];
    [self CreateTarget:0];
    
}
-(void)CreateRadioBtn
{
    NSButtonCell *prototype =[[NSButtonCell alloc] init];
    [prototype setTitle:@"target"];
    [prototype setButtonType:NSRadioButton];
    NSRect matrixRect = NSMakeRect(100, 100, 500 , 20);
    NSMatrix *myMatrix = [[NSMatrix alloc] initWithFrame:matrixRect
                                                    mode:NSRadioModeMatrix
                                               prototype:(NSCell *)prototype
                                            numberOfRows:1
                                         numberOfColumns:4];
    NSSize cellSize;
    cellSize.height=20;
    cellSize.width=100;
    myMatrix.cellSize=cellSize;
    [self.view.window.contentView addSubview:myMatrix];
    NSArray *cellArray = [myMatrix cells];
    [[cellArray objectAtIndex:0] setTitle:@"灵"];
    [[cellArray objectAtIndex:0] setAction:@selector(btnClickLingYu:)];
    [[cellArray objectAtIndex:1] setTitle:@"蜀"];
    [[cellArray objectAtIndex:1] setAction:@selector(btnClickShuShan:)];
    [[cellArray objectAtIndex:2] setTitle:@"幻"];
    [[cellArray objectAtIndex:2] setAction:@selector(btnClickHuanLing:)];
    [[cellArray objectAtIndex:3] setTitle:@"仙"];
    [[cellArray objectAtIndex:3] setAction:@selector(btnClickXianMoBian:)];
    [prototype release];
    [myMatrix release];
    
}


-(void)ResetTarget
{
    for(int i=0;i<arrayBtn.count;i++)
    {
        NSButton *button=[arrayBtn objectAtIndex:i];
        [button removeFromSuperview];
    }
    [arrayBtn removeAllObjects];
}


-(void)CreateTarget:(int)type
{
    NSArray *arrayTarget = nil;
    switch (type) {
        case 0:arrayTarget=arrayLingYu;break;
        case 1:arrayTarget=arrayShuShan;break;
        case 2:arrayTarget=arrayHuanLing;break;
        case 3:arrayTarget=arrayXianMoBian;break;
    }
    
    
    NSButton* pushButton;
    NSString *str;
    NSArray *arrayStr;
    NSString *strShow;
    int columnsWidth=310;
    int columnsNum=0;
    int rowsWidth=20;
    int rowsNum=0;
    for(int i=0;i<arrayTarget.count;i++)
    {
        if(i==25)
        {
            columnsNum=1;
            rowsNum=0;
        }
        rowsNum++;
        
        pushButton = [[[NSButton new] initWithFrame: NSMakeRect(columnsNum*columnsWidth, 640-rowsWidth*(rowsNum), 320, 20) ]autorelease];
        str=[[NSString alloc]initWithFormat:@"%d:%@",i,[arrayTarget objectAtIndex:i]];
        arrayStr=[str componentsSeparatedByString:@":"];
        strShow=[[NSString alloc]initWithFormat:@" %@ %@ %@ %@ %@",[arrayStr objectAtIndex:0],[arrayStr objectAtIndex:3],[arrayStr objectAtIndex:4],[arrayStr objectAtIndex:5],[arrayStr objectAtIndex:1]];
        
        if(i>=10)
         strShow=[[NSString alloc]initWithFormat:@"%@ %@ %@ %@ %@",[arrayStr objectAtIndex:0],[arrayStr objectAtIndex:3],[arrayStr objectAtIndex:4],[arrayStr objectAtIndex:5],[arrayStr objectAtIndex:1]];
        
        [pushButton setTitle:strShow];
        [pushButton setButtonType:NSSwitchButton];
        [self.view.window.contentView addSubview:pushButton];
  
        [arrayBtn addObject:pushButton];
        
    }
 
 
}




-(IBAction)btnClickLingYu:(id)sender
{
    [self ResetTarget];
    [self CreateTarget:0];
    game=0;
    
}
-(IBAction)btnClickShuShan:(id)sender
{
    [self ResetTarget];
    [self CreateTarget:1];
    game=1;
}
-(IBAction)btnClickHuanLing:(id)sender
{
    [self ResetTarget];
    [self CreateTarget:2];
    game=2;
}
-(IBAction)btnClickXianMoBian:(id)sender
{
    [self ResetTarget];
    [self CreateTarget:3];
    game=3;
}


 
-(NSMutableArray *)GetTargetState:(int)type
{
    
    NSArray *arrayTarget = nil;
    switch (type) {
        case 0:arrayTarget=arrayLingYu;break;
        case 1:arrayTarget=arrayShuShan;break;
        case 2:arrayTarget=arrayHuanLing;break;
        case 3:arrayTarget=arrayXianMoBian;break;
    }
    
    NSMutableArray *arrayState;
    arrayState=[[NSMutableArray alloc]init];
    
    NSString* str;
    
    NSButton *button;
    for(int i=0;i<arrayBtn.count;i++)
    {
        button=[arrayBtn objectAtIndex:i];
        if(button.state==1)
        {
            str= [arrayTarget objectAtIndex:i];
            [arrayState addObject:str];
        }
    }
    
    return arrayState;
}

-(IBAction)btnClickStart:(id)sender
{
 
  
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(NSThreadStart) object:nil];
    thread.threadPriority = 1;
    [thread start];
    [btnSubmit setEnabled:false];
}




-(void)NSThreadStart
{
    
 
    
    NSMutableArray* array=[self GetTargetState:game];
    
    int count=array.count;
    NSString *strNum=[[NSString alloc]initWithFormat:@"NEED NUM :  %d",count];
    [textNeed setStringValue:strNum];
    
    
    NSLog(@"%@",array);
    NSString * str=[self MixTarget:array];
    NSString *pathAndValue=[[NSString alloc]initWithFormat:@"sh /Users/luozhuocheng/IOS/PackProject/PackageScript/script.sh %@",str];
    
    
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/bin/sh"];//使用shell 普通指令
    NSArray *ar=[[NSArray alloc]initWithObjects:@"-c",pathAndValue, nil];//有效
    [task setArguments:ar];//有效
    
    
    //启动前，增加输出设置＋＋＋
    
    NSOutPipe = [NSPipe pipe];
    [task setStandardOutput: NSOutPipe];
    NSFileHandle *file;
    file = [NSOutPipe fileHandleForReading];

    
    [file waitForDataInBackgroundAndNotify];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(commandNotification)//更新命令
                                                 name:NSFileHandleDataAvailableNotification
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeNotification)//更新success数量
                                                 name:NSTextViewDidChangeSelectionNotification
                                               object:nil];
    
    [task launch];
    [task waitUntilExit];
   
    [btnSubmit setEnabled:true];
}


-(NSString *)MixTarget:(NSMutableArray*)array
{
    NSString *str=@"";
    for(int i=0;i<array.count;i++)
    {
        if(i!=array.count-1)
        {
            str=[str stringByAppendingString:  [[NSString alloc]initWithFormat:  @"%@=",[array objectAtIndex:i]]];
        }
        else
        {
            str=[str stringByAppendingString:  [[NSString alloc]initWithFormat:  @"%@=%@=%@",
                                                [array objectAtIndex:i],
                                                [arrayPath objectAtIndex:game],
                                                [arrayProjectName objectAtIndex:game]
                                                ]];
        }
    }
    return str;
    
}


-(void)changeNotification
{

    NSString *getAllResult;
    getAllResult=[[textView textStorage] string];
    
    NSArray *arrayClean=  [getAllResult componentsSeparatedByString:@"CLEAN SUCCEEDED"];
    
    NSArray *arrayExport=  [getAllResult componentsSeparatedByString:@"EXPORT SUCCEEDED"];
    
    //NSLog(@"count : %lu",([array count]-1));
    
    int count=arrayClean.count+arrayExport.count-2;
    NSString *str=[[NSString alloc]initWithFormat:@"SUCCESS NUM : %d",count/2];
    [textSuccess setStringValue:str]; 
}

   
-(void)commandNotification
{ 
    
    NSData *data = nil;
    while ((data = [[NSOutPipe fileHandleForReading] availableData]) && [data length]){
        NSString *outStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //NSLog(@"output: %@", outStr);
        

        dispatch_async(dispatch_get_main_queue(), ^{
 
            @synchronized(self){
                
                NSAttributedString* attr = [[NSAttributedString alloc] initWithString:outStr];
                [[textView textStorage] appendAttributedString:attr];

                NSRect insertionRect=[[textView layoutManager] boundingRectForGlyphRange:[textView selectedRange] inTextContainer:[textView textContainer]];
                NSPoint scrollPoint=NSMakePoint(0,insertionRect.origin.y);
                //NSLog(@"YYYYY:%f",insertionRect.origin.y);
                [textView scrollPoint:scrollPoint];
                
            }
        });
    }
    
    
 

    
}


   







@end
