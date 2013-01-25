CFAsyncImageView for iOS 4.0 and later with ARC support
================

CFAsyncImageView is simple subclass of UIImageView with internal image loader. I use it about 2 years in my projects.

##Interface

        -(void)loadImageWithName:(NSString*)image;
        -(void)loadImageFromURL:(NSString*)url;
        -(void)loadImageFromURL:(NSString*)url withPlaceholder:(UIImage*)image;
        -(void)loadImageFromURL:(NSString*)url withTarger:(id)target selector:(SEL)selector;

        -(void)addImage:(UIImage*)image;
        -(void)addImageToImageView:(UIImage *)image animated:(BOOL)animated;

##How to use it?

1. Drag and drop CFAsyncImageView folder in you project.

2. Change kMaxImagesInCache if needed. kMaxImagesInCache depends on size of images.

3. Last, but very important step. Add one line of code into you Application Delegate. A saw a lot of AsyncImageView implementation and no one mention about cleaning image cache in case of memory warning.


        - (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
            //we should prevent your application to crash in case memory warnings
            [CFAsyncImageView applicationDidReceiveMemoryWarning];
        }





        
##FAQ
###What do you use for cashing images in memory?
I decided to use standart NSCache (available in iOS 4.0 and later). 




###Do you cache images on disk?
No! Since iOS5.0 NSURLConnection can automatically cache all download data on disk. But you should be sure that your web server return cacheable images. 

If the [Cache-Control headers](http://condor.depaul.edu/dmumaugh/readings/handouts/SE435/HTTP/node24.html) indicate that this request can be cached, iOS automatically saves it to a local sqlite cache file in AppDirectory/Caches/(bundleid)/Cache.db. E.g. public, max-age=31536000 marks that the request cache will be valid for a year, as max-age is listed in seconds.
You can read mor about native disk-cache [here](http://petersteinberger.com/blog/2012/nsurlcache-uses-a-disk-cache-as-of-ios5/).



##My other usefull libs
[Foursqaure2](https://github.com/Constantine-Fry/Foursquare-API-v2) - Foursquare API v2 For iOS and MacOS.