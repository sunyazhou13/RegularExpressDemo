//
//  ViewController.m
//  RegularExpressDemo
//
//  Created by sunyazhou on 2018/6/25.
//  Copyright © 2018年 Kwai Co., Ltd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *input;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.input.delegate = self;
    [self.input addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
}

//当文本内容改变时调用
- (void)textChange:(UITextField *)textField
{
    self.label.text = [self filterString3:textField.text];
}

//去除字符串中所有的非字母数字和汉字的字符 方案1
- (NSString *)filterString1:(NSString *)str {
    NSString *regex = @"^[a-zA-Z0-9\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    NSMutableString * retStr = [NSMutableString string];
    for(NSInteger i=0; i< [str length];i++){
        NSRange range = NSMakeRange(i, 1);
        NSString *character = [str substringWithRange:range];
        if([pred evaluateWithObject:character])
        {
            [retStr appendString:character];
        }
    }
    return retStr;
}

//方案2
- (NSString *)filterString2:(NSString *)str {
    NSString *regex = @"[^a-zA-Z0-9\u4e00-\u9fa5]";
    NSMutableString *mstr = [NSMutableString stringWithFormat:@"%@", str];
    NSUInteger i = [mstr replaceOccurrencesOfString:regex withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, mstr.length)];
    return [NSString stringWithFormat:@"%@-长度:%zd",mstr,i];
}

//方案3
- (NSString *)filterString3:(NSString *)str {
    NSString *regex = @"[^a-zA-Z0-9\u4e00-\u9fa5]";
    return [str stringByReplacingOccurrencesOfString:regex withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, str.length)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
