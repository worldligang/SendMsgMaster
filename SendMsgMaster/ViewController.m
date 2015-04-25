//
//  ViewController.m
//  SendMsgMaster
//
//  Created by ligang on 15/4/25.
//  Copyright (c) 2015年 ligang. All rights reserved.
//
//  我的微信iOS开发：iOSDevTip
//  我的博客地址 http://www.superqq.com

#import "ViewController.h"
#import <MessageUI/MessageUI.h>

@interface ViewController ()<MFMessageComposeViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *iOSDevTip = [UIButton buttonWithType:UIButtonTypeCustom];
    iOSDevTip.frame = CGRectMake(20, 80, 100, 50);
    [iOSDevTip setBackgroundColor:[UIColor orangeColor]];
    [iOSDevTip setTitle:@"send msg" forState:UIControlStateNormal];
    [iOSDevTip setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:iOSDevTip];
    [iOSDevTip addTarget:self action:@selector(actioniOSDevTipClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)actioniOSDevTipClick:(id)sender
{
    //方法一
//    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"sms://13888888888"]];
    
    [self showMessageView:[NSArray arrayWithObjects:@"13888888888",@"13999999999", nil] title:@"test" body:@"你是土豪么，么么哒"];
}

-(void)showMessageView:(NSArray *)phones title:(NSString *)title body:(NSString *)body
{
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = phones;
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = body;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:title];//修改短信界面标题
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark - MFMessageComposeViewController

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            
            break;
        case MessageComposeResultFailed:
            //信息传送失败
            
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
