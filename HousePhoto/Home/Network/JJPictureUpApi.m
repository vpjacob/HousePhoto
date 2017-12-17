//
//  JJPictureUpApi.m
//  HousePhoto
//
//  Created by vpjacob on 2017/12/17.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import "JJPictureUpApi.h"
#import "UIImage+Resize.h"
#import <YTKBatchRequest.h>
#import <AFURLRequestSerialization.h>
@interface JJPictureUpApi ()
@property (nonatomic, strong)UIImage *image;
@end

@implementation JJPictureUpApi{
    NSInteger _pageNo;
    NSInteger _pageSize;
    NSString *_uid;
}

- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super init]) {
        _image = image;
        _uid = [[NSUserDefaults standardUserDefaults] objectForKey:kUid];
    }
    return self;
}

- (id)requestArgument {
    NSDictionary *dic = @{
                          @"uid":_uid
                          
                          };
    [self.baseMuDic addEntriesFromDictionary:dic];
    return self.baseMuDic;
}


- (NSString *)requestUrl{
    
    return [NSString stringWithFormat:@"%@/upload/uploadPic.do",kUrl];
}


- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

- (AFConstructingBlock)constructingBodyBlock {
    if (_image) {
        return ^(id<AFMultipartFormData> formData) {
            NSData *data = [_image dealImageMaxFileSize:600];
            //            NSData *data = UIImageJPEGRepresentation(_image, 0.9);
            NSString *name = @"image.jpg";
            NSString *formKey = @"image";
            NSString *type = @"image/jpeg";
            [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
        };
    }
    return nil;
}

- (NSString *)getUploadFileUrl {
    return [self.responseJSONObject objectForKey:@"info"];
}

@end
