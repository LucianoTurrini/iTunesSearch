//
//  ImageOptimize.m
//  iTunesSearch
//
//  Created by Luciano Moreira Turrini on 3/15/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "ImageOptimize.h"

@implementation ImageOptimize

+ (void)processImageDataWithURLString:(NSString *)urlString andBlock:(void (^)(NSData *imageData))processImage
{
    NSURL *url = [NSURL URLWithString:urlString];
    
    dispatch_queue_t callerQueue = dispatch_get_current_queue();
    dispatch_queue_t downloadQueue = dispatch_queue_create("com.myapp.processsmagequeue", NULL);
    dispatch_async(downloadQueue, ^{
        NSData * imageData = [NSData dataWithContentsOfURL:url];
        
        dispatch_async(callerQueue, ^{
            processImage(imageData);
        });
    });
    //    dispatch_release(downloadQueue);
}

@end
