//
//  ViewController.m
//  testHtml
//
//  Created by IOF－IOS2 on 15/10/12.
//  Copyright (c) 2015年 IOF－IOS2. All rights reserved.
//

#import "ViewController.h"
#import "SViewController.h"

@interface ViewController () <UIWebViewDelegate> {
    UIWebView *_pWebView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pWebView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _pWebView.delegate = self;
    _pWebView.scalesPageToFit = YES;
    [self.view addSubview:_pWebView];
    
    [self loadExamplePage:_pWebView];
}

- (void)loadExamplePage:(UIWebView*)webView {
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"html"];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [webView loadHTMLString:appHtml baseURL:baseURL];
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlString = [[request URL] absoluteString];
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"urlString=%@",urlString);
    NSArray *urlComps = [urlString componentsSeparatedByString:@"://"];
    // objc://fuck:/what are you 弄啥哩
    if([urlComps count] && [[urlComps objectAtIndex:0] isEqualToString:@"objc"])
    {
        
        NSArray *arrFucnameAndParameter = [(NSString*)[urlComps objectAtIndex:1] componentsSeparatedByString:@":/"];
        NSString *funcStr = [arrFucnameAndParameter objectAtIndex:0];
        
        if (1 == [arrFucnameAndParameter count])
        {
            // 没有参数
            if([funcStr isEqualToString:@"fuck/what are you 弄啥哩"])
            {
                /*调用本地函数*/
                SViewController *s = [SViewController new];
                [self.navigationController pushViewController:s animated:YES];
            }
        }
        else
        {
            NSLog(@"fuck");
        }
        return NO;
    }
    return TRUE;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
