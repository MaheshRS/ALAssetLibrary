//
//  AVARootViewController.m
//  AVAssetSample
//
//  Created by Mahesh on 9/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AVARootViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface AVARootViewController ()<UITableViewDataSource,UITableViewDelegate>
{
  NSMutableArray *dataContainer;
  ALAssetsLibrary *library;
  UITableView *tableViewContainer;
}

@end

@implementation AVARootViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
      [[self view]setBackgroundColor:[UIColor redColor]];
      
      dataContainer = [[NSMutableArray alloc]init];
      library = [[ALAssetsLibrary alloc]init];
    }
    return self;
}

- (void)dealloc
{
  [dataContainer release];
  [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
  
  // define the tableview
//  tableViewContainer = [[UITableView alloc]initWithFrame:[self view].bounds style:UITableViewStyleGrouped];
//  [tableViewContainer setDataSource:self];
//  [[self view]addSubview:tableViewContainer];
//  [tableViewContainer release];
  
  // Declare the assets success and faliure
  void (^assetsEnumeration)(ALAsset *,NSUInteger,BOOL *) = ^(ALAsset *asset,NSUInteger index,BOOL *stop){
    
    if(asset!=nil)
    {
      NSLog(@"obtained Asset %@",[asset valueForProperty:ALAssetPropertyAssetURL]);
      [dataContainer addObject:asset];
      [tableViewContainer reloadData];
    }
  };
  
  
  void (^assetsGroupEnumeration)(ALAssetsGroup *,BOOL *) = ^(ALAssetsGroup *group,BOOL *status){
    
    if(group!=nil)
    {
      [group enumerateAssetsUsingBlock:assetsEnumeration];
    }
  
  };
  
  
  // allocate the library
  library = [[ALAssetsLibrary alloc]init];
  
  [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:assetsGroupEnumeration failureBlock:^(NSError *error) {
    NSLog(@"Error :%@", [error localizedDescription]);
  }];
  
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - tableview data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [dataContainer count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *cellIdentifier =  @"assetImageCell";
  
  UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if(cell==nil)
  {
    cell = [[UITableViewCell alloc]init];
    
  }
  
  [[cell imageView]setImage:[UIImage imageWithCGImage:[(ALAsset *)[dataContainer objectAtIndex:[indexPath row]] thumbnail]]];
  [[cell textLabel]setText:[NSString stringWithFormat:@"  %@",[(ALAsset *)[dataContainer objectAtIndex:[indexPath row]] valueForProperty:ALAssetPropertyRepresentations]]];
  return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

@end
