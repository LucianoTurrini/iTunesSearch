//
//  iTunesManager.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "iTunesManager.h"


@implementation iTunesManager

@synthesize allMidias;

static iTunesManager *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];    
    });
    
    return SINGLETON;
}


- (void)buscarMidias:(NSString *)termo {
    
    allMidias = [[NSMutableDictionary alloc] init];
    
    Filme *filme = [[Filme alloc] init];
    Music *music = [[Music alloc] init];
    Ebook *ebook = [[Ebook alloc] init];
    Podcast *podcast = [[Podcast alloc] init];
    
    if (!termo) {
        termo = @"";
    }
    
    //Tratamento de erro casse passe uma espaço para URL, todo espaço deve ser trocado por %20 na URL
    termo = [termo stringByReplacingOccurrencesOfString:@" " withString: @"%20"];
    
    //Limite de 120 objetos
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=all&limit=120", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];
    if (error) {
        NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
        return ;
    }
    
    // pegar resultados do  NSDictionary *resultado e inserir no array
    NSArray *resultados = [resultado objectForKey:@"results"];
    NSMutableArray *Filmes = [[NSMutableArray alloc] init];
    NSMutableArray *Musicas = [[NSMutableArray alloc] init];
    NSMutableArray *Ebooks = [[NSMutableArray alloc] init];
    NSMutableArray *Podcasts = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in resultados) {
        
        if([[item objectForKey:@"kind"] isEqual: @"podcast"]) {
        [podcast setKey:@"Podcast"];
        [podcast setNome:[item objectForKey:@"trackName"]];
        [podcast setTrackId:[item objectForKey:@"trackId"]];
        [podcast setArtista:[item objectForKey:@"artistName"]];
        [podcast setDuracao:[item objectForKey:@"trackTimeMillis"]];
        [podcast setGenero:[item objectForKey:@"primaryGenreName"]];
        [podcast setPais:[item objectForKey:@"country"]];
        [podcast setImage:@"podcast.png"];
        [podcast setImageUrl:[item objectForKey:@"artworkUrl100"]];
        [Podcasts addObject:podcast];
        podcast = [[Podcast alloc] init];
        }
        else {
            if([[item objectForKey:@"kind"] isEqual: @"feature-movie"]) {
                [filme setKey:@"Filme"];
                [filme setNome:[item objectForKey:@"trackName"]];
                [filme setTrackId:[item objectForKey:@"trackId"]];
                [filme setArtista:[item objectForKey:@"artistName"]];
                [filme setDuracao:[item objectForKey:@"trackTimeMillis"]];
                [filme setGenero:[item objectForKey:@"primaryGenreName"]];
                [filme setPais:[item objectForKey:@"country"]];
                [filme setImage:@"video.jpg"];
                [filme setImageUrl:[item objectForKey:@"artworkUrl100"]];
                [Filmes addObject:filme];
                filme= [[Filme alloc] init];
             }
            else {
                 if ([[item objectForKey:@"kind"] isEqual: @"song"]) {
                    [music setKey:@"Musica"];
                    [music setNome:[item objectForKey:@"trackName"]];
                    [music setTrackId:[item objectForKey:@"trackId"]];
                    [music setArtista:[item objectForKey:@"artistName"]];
                    [music setDuracao:[item objectForKey:@"trackTimeMillis"]];
                    [music setGenero:[item objectForKey:@"primaryGenreName"]];
                    [music setPais:[item objectForKey:@"country"]];
                    [music setImage:@"music.png"];
                    [music setImageUrl:[item objectForKey:@"artworkUrl100"]];
                    [Musicas addObject:music];
                     music= [[Music alloc] init];
                }
                 else
                    if ([[item objectForKey:@"kind"] isEqual: @"ebook"]) {
                        [ebook setKey:@"Ebook"];
                        [ebook setNome:[item objectForKey:@"trackName"]];
                        [ebook setTrackId:[item objectForKey:@"trackId"]];
                        [ebook setArtista:[item objectForKey:@"artistName"]];
                        [ebook setDuracao:[item objectForKey:@"trackTimeMillis"]];
                        [ebook setGenero:[item objectForKey:@"primaryGenreName"]];
                        [ebook setPais:[item objectForKey:@"country"]];
                        [ebook setImage:@"ebook.png"];
                        [ebook setImageUrl:[item objectForKey:@"artworkUrl100"]];
                        [Ebooks addObject:ebook];
                        ebook= [[Ebook alloc] init];
                    }
            }
        }

        
    }
    
        
        //if ([Filmes count] != 0)
        [allMidias setObject:Filmes forKey:@"Filmes"];
        //if ([Podcasts count] != 0)
        [allMidias setObject:Podcasts forKey:@"Podcasts"];
        //if ([Ebooks count] != 0)
        [allMidias setObject:Ebooks forKey:@"Ebooks"];
        //if ([Musicas count] != 0)
        [allMidias setObject:Musicas forKey:@"Musicas"];
    
    
}


#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[iTunesManager alloc] init];
}

- (id)mutableCopy
{
    return [[iTunesManager alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    return self;
}


@end
