//
//  TAXTextField.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/14.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXTextField.h"
#import <objc/runtime.h>

static NSString *const placeholderTextColorKeyPath = @"placeholderLabel.textColor";
@implementation TAXTextField

//得到所有的方法
+ (void)getMethod{
    unsigned int count = 0;
    Method *methods = class_copyMethodList([UITextField class], &count);
    for (int i = 0; i<count; i++) {
        Method method = methods[i];
        TAXLog(@"%@-----%s",NSStringFromSelector(method_getName(method)),method_getTypeEncoding(method));
    }

}

//得到所有的属性
+ (void)getProperty{
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([UITextField class], &count);
    for (int i = 0; i<count; i++) {
        objc_property_t property = properties[i];
        
        TAXLog(@"%s-----%s",property_getName(property),property_getAttributes(property));
    }

}

//得到所有的变量
+ (void)getIvar{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    for (int i = 0; i<count; i++) {
        Ivar ivar = *(ivars + i);
        
        TAXLog(@"%s----%s",ivar_getName(ivar),ivar_getTypeEncoding(ivar));
    }

}



- (void)awakeFromNib{
    [self resignFirstResponder];
    self.tintColor = [UIColor whiteColor];
}

- (BOOL)becomeFirstResponder{
    [self setValue:[UIColor whiteColor] forKeyPath:placeholderTextColorKeyPath];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder{
    [self setValue:[UIColor grayColor] forKeyPath:placeholderTextColorKeyPath];
    return [super resignFirstResponder];
}


/*第二种方法通过重写-drawPlaceholderInRect:(CGRect)rect
- (void)drawPlaceholderInRect:(CGRect)rect{
    [self.placeholder drawInRect:CGRectMake(0, 15, rect.size.width, 25) withAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],
                                                                                         NSFontAttributeName:self.font                                                       }];
}*/

@end
