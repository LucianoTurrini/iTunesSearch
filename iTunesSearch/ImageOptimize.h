//
//  ImageOptimize.h
//  iTunesSearch
//
//  Created by Luciano Moreira Turrini on 3/15/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface ImageOptimize : NSObject

+ (void)processImageDataWithURLString:(NSString *)urlString andBlock:(void (^)(NSData *imageData))processImage;

@end
