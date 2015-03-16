//
//  Midia.h
//  iTunesSearch
//
//  Created by Luciano Moreira Turrini on 3/12/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Midia : NSObject

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *nome;
@property (nonatomic, strong) NSString *trackId;
@property (nonatomic, strong) NSString *artista;
@property (nonatomic, strong) NSString *duracao;
@property (nonatomic, strong) NSString *genero;
@property (nonatomic, strong) NSString *pais;
@property (nonatomic, strong) NSString *preco;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *imageUrl;

@end
