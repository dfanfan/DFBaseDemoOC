//
//  DFShareVC.m
//  DFBaseDemocOC
//
//  Created by dff on 2020/1/6.
//  Copyright © 2020 DF. All rights reserved.
//

#import "DFShareVC.h"
#import "DFShareUtils.h"

@interface DFShareVC ()
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation DFShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];
    [self setupData];
    
}

- (void)setupNav {
    [self setTitle:@"友盟分享"];
}


- (void)setupData {
    self.dataArray = @[@"分享URL",
                       @"分享图片"];
    
}

- (void)shareUrl {
    DFShareObject *object = [[DFShareObject alloc] init];
    object.webUrl = @"www.baidu.com";
    
    [DFShareUtils showSharePlatforms:self object:object complete:^(NSError * _Nonnull error) {
        NSLog(@"share result = %@", error);
    }];
}

- (void)shareImage {
    
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.dataArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self shareUrl];
            break;
        case 1:
            [self shareImage];
            break;
            
        default:
            break;
    }
}





@end
