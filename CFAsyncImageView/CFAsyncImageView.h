//
//  Created by Constantine Fry on 25/01/13.
//


//this number depends on size of images
#define kMaxImagesInCache 50

@class CFImageLoader;
@interface CFAsyncImageView : UIView {
    CFImageLoader *loader;
	UIImageView *imageView;
    SEL selector;
    UIImageView *_placeholderImageView;
}
@property (nonatomic,weak)id target;
@property (weak, nonatomic,readonly)NSString* urlString;
@property(nonatomic,strong) UIImageView* imageView;


-(id)init;

+(NSCache*)sharedImageCache;
+(void)applicationDidReceiveMemoryWarning;



-(void)loadImageWithName:(NSString*)image;
-(void)loadImageFromURL:(NSString*)url;
-(void)loadImageFromURL:(NSString*)url withPlaceholder:(UIImage*)image;
-(void)loadImageFromURL:(NSString*)url withTarger:(id)tar selector:(SEL)sel;

-(void)addImage:(UIImage*)image;
-(void)addImageToImageView:(UIImage *)image animated:(BOOL)animated;



@end
