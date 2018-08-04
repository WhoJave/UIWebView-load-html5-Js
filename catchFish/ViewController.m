//
//  ViewController.m
//  catchFish
//
//  Created by OnePiece on 2018/8/2.
//  Copyright © 2018年 OnePiece. All rights reserved.
//


#import "ViewController.h"
#define Wwidth [UIScreen mainScreen].bounds.size.width
#define Wheight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *h5View;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.h5View = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, Wwidth, Wheight)];
    self.h5View.delegate = self;
    self.h5View.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.h5View];
    
    self.h5View.scalesPageToFit = YES;
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];

    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"index"
                                                          ofType:@"html"];
    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    [self.h5View loadHTMLString:htmlCont baseURL:baseURL];

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"webView %@ /n,request %@/n,navigationType %ld",webView,request,(long)navigationType);
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"%s",__func__);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{

    NSString * javascript = [NSString stringWithFormat:@"var viewPortTag=document.createElement('meta');  \
                  viewPortTag.id='viewport';  \
                  viewPortTag.name = 'viewport';  \
                  viewPortTag.content = 'width=%d; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;';  \
                  document.getElementsByTagName('head')[0].appendChild(viewPortTag);" , (int)webView.bounds.size.width];
    
    [webView stringByEvaluatingJavaScriptFromString:javascript];
    NSLog(@"%s",__func__);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
