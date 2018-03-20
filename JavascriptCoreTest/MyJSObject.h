//
//  MyJSObject.h
//  JavascriptCoreTest
//
//  Created by cmbdev on 2018/3/20.
//  Copyright © 2018年 idivines. All rights reserved.
//

#import <Foundation/Foundation.h>
@import JavaScriptCore;

@protocol MyJSExport <JSExport>
-(void)test;
@end

@interface MyJSObject : NSObject <MyJSExport>

@end
