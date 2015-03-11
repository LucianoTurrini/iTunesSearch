//
//  ViewController.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "iTunesManager.h"
#import "Entidades/Filme.h"

@interface TableViewController () {
    NSArray *midias;
    UITextView *TextView;
}

@end

@implementation TableViewController



- (void)viewDidLoad {
    
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    _itunes = [iTunesManager sharedInstance];
    midias = [_itunes buscarMidias:@"Apple"];
    
    //call HeadTable
    [self HeadTableSearch];
    
    

}


- (void)HeadTableSearch {
    
    //Header TableView
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, 80.f)];
    
    headerView.backgroundColor=[[UIColor redColor]colorWithAlphaComponent:0.5f];
    headerView.layer.borderColor=[UIColor blackColor].CGColor;
    headerView.layer.borderWidth=1.0f;
    
    //TextView
    TextView= [[UITextView alloc] initWithFrame:CGRectMake(15.0f, 35.0f, 150.0f, 25.0f)];
    TextView.textAlignment = NSTextAlignmentRight;
    TextView.text = @"";
    TextView.backgroundColor = [UIColor whiteColor];
    
    //Button
    UIButton *ButtonSearch= [[UIButton alloc] initWithFrame:CGRectMake(180.0f, 35.0f, 80.0f, 25.0f)];
    [ButtonSearch setTitle: @"Procurar" forState: UIControlStateNormal];
    [ButtonSearch setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    [ButtonSearch addTarget:self action:@selector(SeachTerm) forControlEvents:UIControlEventTouchUpInside];
    
    //Add Head and Replace
    self.tableview.tableHeaderView = headerView;
    [_tableview addSubview:TextView];
    [_tableview addSubview:ButtonSearch];
    
}

//Serch Term
- (void)SeachTerm {
    
    midias = [_itunes buscarMidias:TextView.text];
    
    [_tableview reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [midias count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    Filme *filme = [midias objectAtIndex:indexPath.row];
    
    [celula.nome setText:filme.nome];
    [celula.tipo setText:@"Filme"];
    [celula.artista setText:filme.artista];
    
    return celula;
}


//Tamanho da Celular
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}


@end
