//
//  ViewController.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "TableViewController.h"


@interface TableViewController ()

@end

@implementation TableViewController

@synthesize itunes;

@synthesize searchBar;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setTitle:@"Itunes Search"];
    
    
    itunes = [iTunesManager sharedInstance];

    [searchBar setPlaceholder:NSLocalizedString(@"Buscar", nil)];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    CGFloat viewWidth = self.view.bounds.size.width;
    CGFloat viewHeight = self.view.bounds.size.height;
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(viewWidth/2, viewHeight/2);
    spinner.tag = 12;
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sectionTitles = [[NSArray alloc] init];
        
        [itunes buscarMidias:searchBar.text];
        
        sectionTitles = [itunes.allMidias allKeys];
        
        [_tableview reloadData];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableview reloadData];
            [spinner stopAnimating];
            [spinner removeFromSuperview];
        });
    });
}



- (void)searchBarCancelButtonClicked: (UISearchBar *)searchBar {
    [itunes setAllMidias:nil];
    [_tableview reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [itunes.allMidias count];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [itunes.allMidias[sectionTitles[section]] count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return sectionTitles[section];
}

//Resolve o problema mas necessita melhorar...
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    
    if(indexPath.section == 0) {
        NSMutableArray *MovieItems  = [[NSMutableArray alloc] initWithArray:[itunes.allMidias objectForKey:@"Filmes"]];
        Filme *filme  = [MovieItems objectAtIndex:indexPath.row];
        [celula.nome setText:filme.nome];
        [celula.tipo setText:filme.key];
        [celula.artista setText:filme.artista];
        [celula.image setImage:[UIImage imageNamed:filme.image]];
        [ImageOptimize processImageDataWithURLString:filme.imageUrl andBlock:^(NSData *imageData) {
            if (self.view.window) {
                UIImage *image = [UIImage imageWithData:imageData];
                
                [celula.imageUrl setImage:image];
            }
            
        }];
        return celula;
    }
        else if (indexPath.section == 1) {
        NSMutableArray *EbookItems  = [[NSMutableArray alloc] initWithArray:[itunes.allMidias objectForKey:@"Ebooks"]];
        Ebook *ebook  = [EbookItems objectAtIndex:indexPath.row];
        [celula.nome setText:ebook.nome];
        [celula.tipo setText:ebook.key];
        [celula.artista setText:ebook.artista];
        [celula.image setImage:[UIImage imageNamed:ebook.image]];
        [ImageOptimize processImageDataWithURLString:ebook.imageUrl andBlock:^(NSData *imageData) {
                if (self.view.window) {
                    UIImage *image = [UIImage imageWithData:imageData];
                    
                    [celula.imageUrl setImage:image];
                }
                
        }];
        return celula;
        }
        else if (indexPath.section == 2) {
            NSMutableArray *PodcastsItems  = [[NSMutableArray alloc] initWithArray:[itunes.allMidias objectForKey:@"Podcasts"]];
            Podcast *podcast  = [PodcastsItems objectAtIndex:indexPath.row];
            [celula.nome setText:podcast.nome];
            [celula.tipo setText:podcast.key];
            [celula.artista setText:podcast.artista];
            [celula.image setImage:[UIImage imageNamed:podcast.image]];
            [ImageOptimize processImageDataWithURLString:podcast.imageUrl andBlock:^(NSData *imageData) {
                if (self.view.window) {
                    UIImage *image = [UIImage imageWithData:imageData];
                    
                    [celula.imageUrl setImage:image];
                }
                
            }];
            return celula;
        }

    else {
        NSMutableArray *MusicItems  = [[NSMutableArray alloc] initWithArray:[itunes.allMidias objectForKey:@"Musicas"]];
        Music *musica = [MusicItems objectAtIndex:indexPath.row];
        [celula.nome setText:musica.nome];
        [celula.tipo setText:musica.key];
        [celula.artista setText:musica.artista];
        [celula.image setImage:[UIImage imageNamed:musica.image]];
        [ImageOptimize processImageDataWithURLString:musica.imageUrl andBlock:^(NSData *imageData) {
            if (self.view.window) {
                UIImage *image = [UIImage imageWithData:imageData];
                
                [celula.imageUrl setImage:image];
            }
            
        }];
        return celula;
    }
    
    return celula;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     [self.searchBar resignFirstResponder];
     DetailViewController *dvc = [[DetailViewController alloc] init];
    
     Midia *selectedMedia = [[Midia alloc] init];
    
     if (indexPath.section == 0) {
         NSMutableArray *MovieItems  = [[NSMutableArray alloc] initWithArray:[itunes.allMidias objectForKey:@"Filmes"]];
         Filme *filme  = [MovieItems objectAtIndex:indexPath.row];
         selectedMedia = filme;
     }
     else if (indexPath.section == 1) {
         NSMutableArray *EbookItems  = [[NSMutableArray alloc] initWithArray:[itunes.allMidias objectForKey:@"Ebooks"]];
         Ebook *ebook = [EbookItems objectAtIndex:indexPath.row];
         selectedMedia = ebook;
     }
     else if (indexPath.section == 2) {
         NSMutableArray *PodcastItems = [[NSMutableArray alloc] initWithArray:[itunes.allMidias objectForKey:@"Podcasts"]];
         Podcast *podcast = [PodcastItems objectAtIndex:indexPath.row];
         selectedMedia = podcast;
     }
     else {
         NSMutableArray *MusicItems  = [[NSMutableArray alloc] initWithArray:[itunes.allMidias objectForKey:@"Musicas"]];
         Music *musica = [MusicItems objectAtIndex:indexPath.row];
         selectedMedia = musica;
     }
    
    [dvc setMidia:selectedMedia];
    selectedMedia = nil;
     [self.navigationController pushViewController:dvc animated:YES];
}


//Tamanho da Celular
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}


@end
