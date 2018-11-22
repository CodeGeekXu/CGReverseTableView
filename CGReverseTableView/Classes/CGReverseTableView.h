//
//  CGReverseTableView.h
//  CGReverseTableView
//
//  Created by 徐晨光 on 2018/11/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Override UITableViewDelegate
 */
@protocol CGReverseTableViewDelegate <UITableViewDelegate>

@end

@protocol CGReverseTableViewDataSource <UITableViewDataSource>

@end

@interface CGReverseTableView : UITableView

@property (nonatomic, weak) id<CGReverseTableViewDelegate> delegate;
@property (nonatomic, weak) id<CGReverseTableViewDataSource> dataSource;

@end

NS_ASSUME_NONNULL_END
