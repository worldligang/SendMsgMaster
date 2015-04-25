# SendMsgMaster

iOS调用系统的发短信功能可以分为两种：1，程序外调用系统发短信。2，程序内调用系统发短信。第二种的好处是用户发短信之后还可以回到app。这对app来说非常重要。

###程序外调用系统发短信

这个方法其实很简单，直接调用openURL即可：

	[[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"sms://13888888888"]];
	

###程序内调用系统发短信

#####1）导入MessageUI.framework，并引入头文件：
	
	#import <MessageUI/MessageUI.h>

#####2）实现代理方法MFMessageComposeViewControllerDelegate

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
	
#####3）发送短信

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
	
参数phones：发短信的手机号码的数组，数组中是一个即单发,多个即群发。

#####4）调用发短信的方法

	    [self showMessageView:[NSArray arrayWithObjects:@"13888888888",@"13999999999", nil] title:@"test" body:@"你是土豪么，么么哒"];

我的微信iOS开发：iOSDevTip

代码下载地址:<a href="https://github.com/worldligang/SendMsgMaster.git"target="_blank"title="SendMsgMaster">SendMsgMaster</a>