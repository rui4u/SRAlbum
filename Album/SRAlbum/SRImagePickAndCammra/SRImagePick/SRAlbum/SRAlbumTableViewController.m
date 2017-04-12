//
//  SRAlbumTableViewController.m
//  CameraDemo
//
//  Created by sharui on 16/10/9.
//  Copyright © 2016年 sharui. All rights reserved.
//

#import "SRAlbumTableViewController.h"
#import "SRImageGridCollectionViewController.h"
#import "SRAlbumModel.h"
#import <Photos/Photos.h>
@interface SRAlbumTableViewController ()

/**
 当前照片个数
 */
@property (nonatomic ,assign ) NSInteger currentNum;

/**
 最大照片个数
 */
@property (nonatomic ,assign ) NSInteger maxNumber;
/**
 图片资源
 */
@property (nonatomic ,strong ) NSArray<SRAlbumModel *> * albumModelArray;
@end

@implementation SRAlbumTableViewController
- (instancetype)initWithCurrentPicNumber:(NSInteger)currentNum andMaxNumber:(NSInteger )maxNumber {
    self = [super init];
	
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.maxNumber = maxNumber;
        self.currentNum = currentNum;
    }
	
	return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"照片";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(clickCloseButton)];
    
    [self getAlbumResources:^(NSArray<SRAlbumModel *> * albumResouse, BOOL isDenied) {
        
        if (isDenied) {
    
            self.view = [[UIView alloc] initWithFrame:self.view.bounds];
            UILabel * label = [[UILabel alloc] initWithFrame:self.view.bounds];
            label.numberOfLines = 0;
            label.font = [UIFont systemFontOfSize:13];
            label.text = @"请在iphone的“设置-隐私-照片”选项中,\n允许访问你的手机相册";
            label.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:label];
            return ;
            
        }
        
        self.albumModelArray = albumResouse;
     
        [self.tableView  reloadData];
        
        if (albumResouse.count > 1) {
            
            SRAlbumModel *assetCollection =  self.albumModelArray [0];

            
            SRImageGridCollectionViewController * imageGrid = [[SRImageGridCollectionViewController alloc] initWithSRAlbumModel:assetCollection
                                                                                                           withCurrentPicNumber:self.currentNum
                                                                                                                   andMaxNumber:self.maxNumber];
            
            [self.navigationController pushViewController:imageGrid animated:NO];
        }
    }];
    
}


/**
 获取相册资源
 */
- (void)getAlbumResources:(void (^)(NSArray *, BOOL ))completion {
    // 获取相册访问权限状态
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    switch (status) {
        case PHAuthorizationStatusAuthorized:
            [self fetchResultWithCompletion:completion];
            break;
        case PHAuthorizationStatusNotDetermined:
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                [self fetchResultWithCompletion:completion];
            }];
        }
            break;
        default:
            completion(nil, YES);
            break;
    }

    

}

- (void)fetchResultWithCompletion:(void (^)(NSArray *, BOOL ))completion {

    // 相机胶卷
    PHFetchResult *userLibrary = [PHAssetCollection
                                  fetchAssetCollectionsWithType: PHAssetCollectionTypeSmartAlbum
                                  subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary
                                  options:nil];
    
    // 同步相册
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"localizedTitle" ascending:NO]];
    
    PHFetchResult *syncedAlbum = [PHAssetCollection
                                  fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum
                                  subtype:PHAssetCollectionSubtypeAlbumSyncedAlbum
                                  options:options];
    
    NSMutableArray *result = [NSMutableArray array];
    [userLibrary enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [result addObject:[SRAlbumModel creatAlbumModelWithAssetCollection:obj]];
    }];
    [syncedAlbum enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [result addObject:[SRAlbumModel creatAlbumModelWithAssetCollection:obj]];
    }];
    

    
    dispatch_async(dispatch_get_main_queue(), ^{ completion(result.copy, NO); });


}
- (void)clickCloseButton {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.albumModelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"test"];
    
    SRAlbumModel *albumModel =  self.albumModelArray [indexPath.row];
    
    cell.textLabel.text = albumModel.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SRAlbumModel *albumModel =  self.albumModelArray [indexPath.row];
  
    
    SRImageGridCollectionViewController * imageGrid = [[SRImageGridCollectionViewController alloc] initWithSRAlbumModel:albumModel
                                                                                                   withCurrentPicNumber:self.currentNum
                                                                                                           andMaxNumber:self.maxNumber];
    
    [self.navigationController pushViewController:imageGrid animated:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
