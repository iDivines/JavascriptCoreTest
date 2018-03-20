//
//  ViewController.m
//  JavascriptCoreTest
//
//  Created by cmbdev on 2018/3/20.
//  Copyright © 2018年 idivines. All rights reserved.
//

#import "ViewController.h"
#import "MyJSObject.h"
@import JavaScriptCore;

@interface ViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webview;
@property (nonatomic, strong) JSContext *context;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webview.delegate = self;
    [self.view addSubview:_webview];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    [_webview loadRequest:[NSURLRequest requestWithURL:url]];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    _context = [self.webview valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    MyJSObject *jsObject = [MyJSObject new];
    
    //两种注入方式
    //1.通过实现JSExport协议，注入oc对象
    _context[@"MyObj"] = jsObject;
    
    //2.通过block的方式注入一个方法
    _context[@"block"] = ^{
        NSLog(@"block run");
    };
    
}

- (void)ocInvockJs{
    //1.oc调用网页中test方法,和在js中调用一样
    [_context evaluateScript:@"test(\"哈哈哈，我很帅\")"];
    
    //2.调用注入的MyObj对象中的方法,和在js中调用一样
    [_context evaluateScript:@"MyObj.test()"];
    
    //3.调用注入的block方法,和在js中调用一样
    [_context evaluateScript:@"block()"];
}

@end
