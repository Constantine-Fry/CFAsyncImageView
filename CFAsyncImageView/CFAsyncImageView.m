//
//  Created by Constantine Fry on 25/01/13.
//

#import "CFAsyncImageView.h"

typedef void (^ImageHandler)(UIImage *image);
@interface CFImageLoader : NSObject
@property (nonatomic) NSUInteger maxImageSize;
@property (nonatomic) CGSize maxSize;

-(void)loadImageWithUrl:(NSString*)url
                handler:(ImageHandler)handler;
-(void)cancel;
@end





@implementation CFAsyncImageView

@synthesize imageView,urlString;

static NSCache* _cache;
+(NSCache*)sharedImageCache{
    if (!_cache) {
        _cache = [[NSCache alloc]init];
        [_cache setCountLimit:kMaxImagesInCache];
    }
    return _cache;
}

+(void)applicationDidReceiveMemoryWarning{
    [_cache removeAllObjects];
}

- (void)initAsyncView {
    self.backgroundColor = [UIColor clearColor];
    if (!imageView){
        imageView = [[UIImageView alloc] init];
        imageView.frame = self.bounds;
        imageView.contentMode      = UIViewContentModeScaleAspectFit;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self insertSubview:imageView atIndex:0];
    }
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initAsyncView];
}




- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        [self initAsyncView];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        [self initAsyncView];
    }
    return self;
}


- (void)addImageToImageView:(UIImage *)image animated:(BOOL)animated{
    [loader cancel];
    
    imageView.image = image;
    
    if (animated) {
        imageView.alpha = 0; 
        [UIView beginAnimations:@"" context:nil];
        [UIView setAnimationDuration:0.3];
        imageView.alpha = 1;
        [UIView commitAnimations];
    }

    
	[self setNeedsLayout];
}








-(void)addImage:(UIImage*)image {
	if (!image) {
        [loader cancel];
        imageView.image = nil;
        [self setNeedsDisplay];
        return;
    }
    [self addImageToImageView:image animated:NO];
}


-(void)loadImageWithName:(NSString *)imageName {
    if (!imageName) {
        return;
    }
    UIImage *image = [UIImage imageNamed:imageName];
    [self addImageToImageView:image animated:NO];
	
}

-(void)loadImageFromURL:(NSString*)url withPlaceholder:(UIImage*)image{
    if (!_placeholderImageView) {
        _placeholderImageView = [[UIImageView alloc]init];
        _placeholderImageView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
        [self insertSubview:_placeholderImageView belowSubview:imageView];
        _placeholderImageView.frame = self.bounds;
    }
    if (image != _placeholderImageView.image)
        _placeholderImageView.image = image;
    [self loadImageFromURL:url];
}

-(void)loadImageFromURL:(NSString*)url {
    [self loadImageFromURL:url withTarger:nil selector:nil];
}

-(void)loadImageFromURL:(NSString*)url withTarger:(id)tar selector:(SEL)sel {
	_target = tar;
    selector = sel;
    
    imageView.image = nil;
    
    if (!loader) {
        loader = [[CFImageLoader alloc]init];
    }
    
    CFAbsoluteTime time = CFAbsoluteTimeGetCurrent();
    [loader loadImageWithUrl:url handler:^(UIImage *image) {
        
        BOOL animated = (CFAbsoluteTimeGetCurrent() - time) > 0.4;
        [self addImageToImageView:image animated:animated];
        [_target performSelector:selector withObject:image];
    }];
}
@end

















@implementation CFImageLoader{
    NSURLConnection *connection;
    NSMutableData *data;
    NSString *__weak _urlString;
    NSCache *_imageCache;
    ImageHandler _handler;
}

- (id)init
{
    self = [super init];
    if (self) {
        _imageCache = [CFAsyncImageView sharedImageCache];
        self.maxImageSize = 400000;
        self.maxSize = CGSizeMake(200, 200);
    }
    return self;
}

-(void)loadImageWithUrl:(NSString*)url
                handler:(ImageHandler)handler{
    
    [connection cancel];
    data = nil;
    
    if (!url ) {
        handler(nil);
    }
    
    
    
    _urlString = url;
    UIImage *cachedImage = [_imageCache objectForKey:_urlString];
    
    if ( cachedImage != nil ) {
        handler(cachedImage);
        return;
    }
    
    _handler = handler;
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]
                                             cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                         timeoutInterval:10];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)incrementalData {
    if ( data == nil ) {
        data = [[NSMutableData alloc] initWithCapacity:2048];
    }
    [data appendData:incrementalData];
}


- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConnection {
    connection = nil;
    UIImage *image = [UIImage imageWithData:data];
    if (!image) {
        NSLog(@"no image: %@",_urlString);
    }
    if (image) {
        [_imageCache setObject:image
                        forKey:_urlString
                          cost:data.length];
    }
    _handler(image);
    data = nil;
}


-(void)cancel{
    [connection cancel];
    connection = nil;
    data = nil;
}

@end
