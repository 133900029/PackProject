//
//  main.m
//  Console
//
//  Created by 罗焯成 on 16/9/6.
//  Copyright © 2016年 罗焯成. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        
        NSLog(@"Hello, World!");
        
        
        if(argc >0)
        {
            NSLog([[NSString alloc]initWithFormat:@"argv0:%s",argv[0]]);
        }
        if(argc >1)
        {
            NSLog([[NSString alloc]initWithFormat:@"argv1:%s",argv[1]]);
        }
        if(argc >2)
        {
            NSLog([[NSString alloc]initWithFormat:@"argv2:%s",argv[2]]);
        }
        
        // Commands are read from standard input:
        NSFileHandle *input = [NSFileHandle fileHandleWithStandardInput];
        
        NSPipe *inPipe = [NSPipe new];  // pipe for shell input
        NSPipe *outPipe = [NSPipe new]; // pipe for shell output
        
        NSTask *task = [NSTask new];
        //[task setLaunchPath:@"/bin/sh"];
        
        [task setLaunchPath:@"/Users/luozhuocheng/IOS/PackProject/ConsoleScript/console.sh"];
        
        [task setStandardInput:inPipe];
        [task setStandardOutput:outPipe];
        [task launch];
        
        // Wait for standard input ...
        [input waitForDataInBackgroundAndNotify];
        // ... and wait for shell output.
        [[outPipe fileHandleForReading] waitForDataInBackgroundAndNotify];
        
        // Wait asynchronously for standard input.
        // The block is executed as soon as some data is available on standard input.
        [[NSNotificationCenter defaultCenter] addObserverForName:NSFileHandleDataAvailableNotification
                                                          object:input queue:nil
                                                      usingBlock:^(NSNotification *note)
         {
             NSData *inData = [input availableData];
             if ([inData length] == 0) {
                 // EOF on standard input.
                 [[inPipe fileHandleForWriting] closeFile];
             } else {
                 // Read from standard input and write to shell input pipe.
                 [[inPipe fileHandleForWriting] writeData:inData];
                 
                 // Continue waiting for standard input.
                 [input waitForDataInBackgroundAndNotify];
             }
         }];
        
        // Wait asynchronously for shell output.
        // The block is executed as soon as some data is available on the shell output pipe.
        [[NSNotificationCenter defaultCenter] addObserverForName:NSFileHandleDataAvailableNotification
                                                          object:[outPipe fileHandleForReading] queue:nil
                                                      usingBlock:^(NSNotification *note)
         {
             // Read from shell output
             NSData *outData = [[outPipe fileHandleForReading] availableData];
             NSString *outStr = [[NSString alloc] initWithData:outData encoding:NSUTF8StringEncoding];
             NSLog(@"output: %@", outStr);
             
             // Continue waiting for shell output.
             [[outPipe fileHandleForReading] waitForDataInBackgroundAndNotify];
         }];
        
        [task waitUntilExit];
        
        
        
        
        
        
    }
    return 0;
}
