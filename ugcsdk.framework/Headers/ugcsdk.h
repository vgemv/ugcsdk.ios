//
//  ugcsdk.h
//  ugcsdk
//
//  Created by weijh on 2020/4/28.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JSVideoEditorConfig:NSObject
@property NSArray<NSString*>* input; // 输入视频
@property NSString* output; // 输出视频
@property NSString* output_thumb; // 输出封面图
@end

@interface JSVideoEditorResult:NSObject
@property int statusCode;
@property NSString* message;
@property NSString* output; // 输出视频
@property NSString* output_thumb; // 输出封面图
@end

@protocol UGCCallbackDelegate
-(void)onUGCResult:(JSVideoEditorResult*)result;
@end

@interface JSVideoEditorViewController : UIViewController
@property id<UGCCallbackDelegate> callbackDelegate;
@property JSVideoEditorConfig* config;
@property NSString* startPage;
-(id)initWithConfig:(JSVideoEditorConfig*)config;
@end
