//
//  iTunesManager.h
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entidades/Filme.h"
#import "Entidades/Music.h"
#import "Entidades/Ebook.h"
#import "Entidades/Podcast.h"

@interface iTunesManager : NSObject
{
    NSMutableDictionary *allMidias;
}

@property (nonatomic, strong) NSMutableDictionary *allMidias;

/**
 * gets singleton object.
 * @return singleton
 */
+ (iTunesManager*)sharedInstance;

- (void)buscarMidias:(NSString *)termo;

@end
