//
//  SecurityUtil.h
//  Smile
//
//  Created by 蒲晓涛 on 12-11-24.
//  Copyright (c) 2012年 BOX. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "SecurityUtil.h"
#import "GTMBase64.h"
#import "NSData+AES.h"


@implementation SecurityUtil

#pragma mark - base64

+ (NSString*)encodeBase64String:(NSString * )input {
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]; 
    data = [GTMBase64 encodeData:data]; 
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	return base64String;
}

+ (NSString*)decodeBase64String:(NSString * )input { 
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]; 
    data = [GTMBase64 decodeData:data]; 
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	return base64String;
} 

+ (NSString*)encodeBase64Data:(NSData *)data {
	data = [GTMBase64 encodeData:data]; 
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	return base64String;
}

+ (NSString*)decodeBase64Data:(NSData *)data {
	data = [GTMBase64 decodeData:data]; 
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	return base64String;
}


#pragma mark - AES加密
//将string转成带密码的及处理过的 string
+(NSString *)encryptAESData:(NSString*)string app_key:(NSString*)key
{
    //将nsstring转化为nsdata
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //使用密码对nsdata进行加密
    NSData *encryptedData = [data AES128EncryptWithKey:key];
    
    // 将数据data转化为byte类型
    Byte * setPasswdWithAES_dataToByte = (Byte *)[encryptedData bytes];
    NSString * newStr=@"";
    
    // 转化成16进制
    for(int i=0;i<[encryptedData length];i++){
        NSString * lastStr = [NSString stringWithFormat:@"%x",setPasswdWithAES_dataToByte[i]&0XFF];
        if (lastStr.length==1) {
            lastStr=[@"0" stringByAppendingString:lastStr];
        }
        newStr=[newStr stringByAppendingString:lastStr];
    }
    // 将字符串中的小写字母转化成大写字母（主要是美观）
    newStr=[newStr uppercaseString];
    
    return newStr;
}


#pragma mark - AES解密
//将带密码的data转成string
+(NSString*)decryptAESData:(NSString *)hexStr app_key:(NSString*)key
{
    
    unsigned long len = [hexStr length]/2;       // Target length
    unsigned char *buf = malloc(len);
    unsigned char *whole_byte = buf;
    char byte_chars[3]={'\0','\0','\0'};
    // 遍历字符串转换成16进制的data
    for(int i=0;i<[hexStr length]/2;i++){
        byte_chars[0] = [hexStr characterAtIndex:i*2];
        byte_chars[1] = [hexStr characterAtIndex:i*2+1];
        *whole_byte = strtol(byte_chars,NULL,16);
        whole_byte++;
    }
    NSData *subData = [NSData dataWithBytes:buf length:len];
    free(buf);
    
    NSMutableData *mdata = [[NSMutableData alloc]init];
    // 拼接data
    [mdata appendData:subData];
    
    //使用密码对data进行解密
    NSData *decryData = [mdata AES128DecryptWithKey:key];
    //将解了密码的nsdata转化为nsstring
    NSString *str = [[NSString alloc] initWithData:decryData encoding:NSUTF8StringEncoding];
    return str;
}

@end
