//
//  ugcsdk.h
//  ugcsdk
//
//  Created by weijh on 2020/4/28.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define UGCRESULT_STATUS_OK     1
#define UGCRESULT_STATUS_CANCEL 0
#define UGCRESULT_STATUS_FAIL   -1

#define UGCLOGLEVEL_DEBUG   1
#define UGCLOGLEVEL_VERBOSE 2
#define UGCLOGLEVEL_INFO    3
#define UGCLOGLEVEL_WARN    4
#define UGCLOGLEVEL_ERROR   5
#define UGCLOGLEVEL_SILIENT 6

@interface JSVideoEditorConfig:NSObject
@property NSArray<NSString*>* input; // 输入视频
@property NSString* output; // 输出视频
@property NSString* output_thumb; // 输出封面图
@property int loglevel;
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
+(int)version;
@property id<UGCCallbackDelegate> callbackDelegate;
@property JSVideoEditorConfig* config;
@property NSString* startPage;
-(id)initWithConfig:(JSVideoEditorConfig*)config;
@end

@protocol DmcPickerDelegate<NSObject>
-(void) resultPicker:(NSMutableArray*) selectArray;
@end

@interface DmcPickerViewController : UIViewController
@property (nonatomic,weak)id<DmcPickerDelegate> _delegate;
/// Default is 9 / 默认最大可选9张图片
@property (nonatomic, assign) NSInteger maxSelectCount;
//'selectMode':101,//101=PICKER_IMAGE_VIDEO , 100=PICKER_IMAGE , 102=PICKER_VIDEO
@property (nonatomic, assign) NSInteger selectMode;
@property (nonatomic, assign) NSInteger maxSelectSize;
@end
