//
//  ViewController.m
//  加密
//
//  Created by apple on 16/12/1.
//  Copyright © 2016年 wuhao. All rights reserved.
//

#import "ViewController.h"
#import "GTMBase64.h"
#import "SecurityUtil.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //需要加密的字符串
    NSString *input =  @"123456";
    // 加密之后的结果
    NSString *output = @"D9E0E2B1E622497EB6AA4FD64BF6439A";
    // 约定的加密密码
    NSString *key = @"1234567812345678";

    // 加密
    NSString  *strig = [SecurityUtil encryptAESData:input app_key:key];
    NSLog(@"加密后的字符串：%@",strig);
  
    
    // 错误的解密
    NSData *lastData = [output dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"要进行解密的data（10进制）：%@",lastData);
    
    
    // 正确的解密
    NSString *string = [SecurityUtil decryptAESData:output app_key:key];
    NSLog(@"解密出来的字符串：%@",string);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
