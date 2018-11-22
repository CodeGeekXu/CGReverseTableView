//
//  CGReverseTableView.m
//  CGReverseTableView
//
//  Created by 徐晨光 on 2018/11/22.
//

#import "CGReverseTableView.h"

@interface CGReverseTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) id<CGReverseTableViewDelegate> reverseDelegate;
@property (nonatomic, weak) id<CGReverseTableViewDataSource> reverseDataSource;

@end

@implementation CGReverseTableView

//@dynamic告诉编译器,属性的setter与getter方法由用户自己实现，不自动生成
@dynamic delegate;
@dynamic dataSource;

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setDelegate:(id<CGReverseTableViewDelegate>)delegate
{
    // 将父类代理设置为自己,子类代理设置为外部,然后重新实现父类代理方法
    super.delegate = self;
    self.reverseDelegate = delegate;
}

- (void)setDataSource:(id<CGReverseTableViewDataSource>)dataSource
{
    super.dataSource = self;
    self.reverseDataSource = dataSource;
}

#pragma mark - private methods

- (void)setup
{
    [self transformWithView:self];
}

- (void)transformWithView:(UIView *)view
{
    if (!CGAffineTransformEqualToTransform(view.transform, CGAffineTransformMakeScale (1,-1))) {
        view.transform = CGAffineTransformMakeScale (1,-1);
    }
}

#pragma mark - public methods

- (void)setTableHeaderView:(UIView *)tableHeaderView
{
    [super setTableHeaderView:tableHeaderView];
    [self transformWithView:tableHeaderView];
}

- (void)setTableFooterView:(UIView *)tableFooterView
{
    [super setTableFooterView:tableFooterView];
    [self transformWithView:tableFooterView];
}

- (void)addSubview:(UIView *)view
{
    [super addSubview:view];
    
    [self transformWithView:view];
}

- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index
{
    [super insertSubview:view atIndex:index];
    
    [self transformWithView:view];
}

- (void)insertSubview:(UIView *)view aboveSubview:(UIView *)siblingSubview
{
    [super insertSubview:view aboveSubview:siblingSubview];
    
    [self transformWithView:view];
}

- (void)insertSubview:(UIView *)view belowSubview:(UIView *)siblingSubview
{
    [super insertSubview:view belowSubview:siblingSubview];
    
    [self transformWithView:view];
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        UIView *header = [self.reverseDelegate tableView:tableView viewForHeaderInSection:section];
        [self transformWithView:header];
        return header;
    }
    
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
        UIView *footer = [self.reverseDelegate tableView:tableView viewForFooterInSection:section];
        [self transformWithView:footer];
        return footer;
    }
    
    return [UIView new];
}

// Display customization
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [self.reverseDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:willDisplayHeaderView:forSection:)]) {
        [self.reverseDelegate tableView:tableView willDisplayHeaderView:view forSection:section];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:willDisplayHeaderView:forSection:)]) {
        [self.reverseDelegate tableView:tableView willDisplayFooterView:view forSection:section];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:didEndDisplayingHeaderView:forSection:)]) {
        [self.reverseDelegate tableView:tableView didEndDisplayingHeaderView:view forSection:section];
    }
}
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:didEndDisplayingFooterView:forSection:)]) {
        [self.reverseDelegate tableView:tableView didEndDisplayingFooterView:view forSection:section];
    }
}

// Variable height support
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        return [self.reverseDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        return [self.reverseDelegate tableView:tableView heightForHeaderInSection:section];
    }
    
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
        return [self.reverseDelegate tableView:tableView heightForFooterInSection:section];
    }
    
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)]) {
        return [self.reverseDelegate tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
    }
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:estimatedHeightForHeaderInSection:)]) {
        return [self.reverseDelegate tableView:tableView estimatedHeightForHeaderInSection:section];
    }
    
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:estimatedHeightForFooterInSection:)]) {
        return [self.reverseDelegate tableView:tableView estimatedHeightForFooterInSection:section];
    }
    
    return 0.001;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:accessoryButtonTappedForRowWithIndexPath:)]) {
        [self.reverseDelegate tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:shouldHighlightRowAtIndexPath:)]) {
        return [self.reverseDelegate tableView:tableView shouldHighlightRowAtIndexPath:indexPath];
    }
    
    return NO;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:didHighlightRowAtIndexPath:)]) {
        [self.reverseDelegate tableView:tableView didHighlightRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:didUnhighlightRowAtIndexPath:)]) {
        [self.reverseDelegate tableView:tableView didUnhighlightRowAtIndexPath:indexPath];
    }
}

- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)]) {
        return [self.reverseDelegate tableView:tableView willSelectRowAtIndexPath:indexPath];
    }
    
    return indexPath;
}

- (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:willDeselectRowAtIndexPath:)]) {
        return [self.reverseDelegate tableView:tableView willDeselectRowAtIndexPath:indexPath];
    }
    
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.reverseDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)]) {
        [self.reverseDelegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)]) {
        return [self.reverseDelegate tableView:tableView editingStyleForRowAtIndexPath:indexPath];
    }
    
    return UITableViewCellEditingStyleNone;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:)]) {
        return [self.reverseDelegate tableView:tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    }
    
    return nil;
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:editActionsForRowAtIndexPath:)]) {
        return [self.reverseDelegate tableView:tableView editActionsForRowAtIndexPath:indexPath];
    }
    
    return nil;
}

- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath
API_AVAILABLE(ios(11.0)){
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:leadingSwipeActionsConfigurationForRowAtIndexPath:)]) {
        return [self.reverseDelegate tableView:tableView leadingSwipeActionsConfigurationForRowAtIndexPath:indexPath];
    }
    
    return nil;
}

- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath
API_AVAILABLE(ios(11.0)){
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:trailingSwipeActionsConfigurationForRowAtIndexPath:)]) {
        return [self.reverseDelegate tableView:tableView trailingSwipeActionsConfigurationForRowAtIndexPath:indexPath];
    }
    
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:shouldIndentWhileEditingRowAtIndexPath:)]) {
        return [self.reverseDelegate tableView:tableView shouldIndentWhileEditingRowAtIndexPath:indexPath];
    }
    
    return NO;
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:willBeginEditingRowAtIndexPath:)]) {
        [self.reverseDelegate tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:didEndEditingRowAtIndexPath:)]) {
        [self.reverseDelegate tableView:tableView didEndEditingRowAtIndexPath:indexPath];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:)]) {
        return [self.reverseDelegate tableView:tableView targetIndexPathForMoveFromRowAtIndexPath:sourceIndexPath toProposedIndexPath:proposedDestinationIndexPath];
    }
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:indentationLevelForRowAtIndexPath:)]) {
        return [self.reverseDelegate tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
    }
    
    return 0;
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:shouldShowMenuForRowAtIndexPath:)]) {
        return [self.reverseDelegate tableView:tableView shouldShowMenuForRowAtIndexPath:indexPath];
    }
    
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:canPerformAction:forRowAtIndexPath:withSender:)]) {
        return [self.reverseDelegate tableView:tableView canPerformAction:action forRowAtIndexPath:indexPath withSender:sender];
    }
    
    return NO;
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:performAction:forRowAtIndexPath:withSender:)]) {
        [self.reverseDelegate tableView:tableView performAction:action forRowAtIndexPath:indexPath withSender:sender];
    }
}

- (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0)
{
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:canFocusRowAtIndexPath:)]) {
        return [self.reverseDelegate tableView:tableView canFocusRowAtIndexPath:indexPath];
    }
    
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView shouldUpdateFocusInContext:(UITableViewFocusUpdateContext *)context
API_AVAILABLE(ios(9.0)){
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:shouldUpdateFocusInContext:)]) {
        return [self.reverseDelegate tableView:tableView shouldUpdateFocusInContext:context];
    }
    
    return NO;
}

- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator
API_AVAILABLE(ios(9.0)){
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:didUpdateFocusInContext:withAnimationCoordinator:)]) {
        [self.reverseDelegate tableView:tableView didUpdateFocusInContext:context withAnimationCoordinator:coordinator];
    }
}

- (nullable NSIndexPath *)indexPathForPreferredFocusedViewInTableView:(UITableView *)tableView NS_AVAILABLE_IOS(9_0)
{
    if ([self.reverseDelegate respondsToSelector:@selector(indexPathForPreferredFocusedViewInTableView:)]) {
        return [self.reverseDelegate indexPathForPreferredFocusedViewInTableView:tableView];
    }
    
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView shouldSpringLoadRowAtIndexPath:(NSIndexPath *)indexPath withContext:(id<UISpringLoadedInteractionContext>)context
API_AVAILABLE(ios(11.0)){
    if ([self.reverseDelegate respondsToSelector:@selector(tableView:shouldSpringLoadRowAtIndexPath:withContext:)]) {
        return [self.reverseDelegate tableView:tableView shouldSpringLoadRowAtIndexPath:indexPath withContext:context];
    }
    
    return NO;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.reverseDataSource respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
        return [self.reverseDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.reverseDataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
       return [self.reverseDataSource tableView:tableView numberOfRowsInSection:section];
    }
    
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.reverseDataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        return [self.reverseDataSource numberOfSectionsInTableView:tableView];
    }
    
    return 0;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([self.reverseDataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
        return [self.reverseDataSource tableView:tableView titleForHeaderInSection:section];
    }
    
    return nil;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if ([self.reverseDataSource respondsToSelector:@selector(tableView:titleForFooterInSection:)]) {
        return [self.reverseDataSource tableView:tableView titleForFooterInSection:section];
    }
    
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.reverseDataSource respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)]) {
        return [self.reverseDataSource tableView:tableView canEditRowAtIndexPath:indexPath];
    }
    
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.reverseDataSource respondsToSelector:@selector(tableView:canMoveRowAtIndexPath:)]) {
        return [self.reverseDataSource tableView:tableView canMoveRowAtIndexPath:indexPath];
    }
    
    return NO;
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if ([self.reverseDataSource respondsToSelector:@selector(sectionIndexTitlesForTableView:)]) {
        return [self.reverseDataSource sectionIndexTitlesForTableView:tableView];
    }
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if ([self.reverseDataSource respondsToSelector:@selector(tableView:sectionForSectionIndexTitle:atIndex:)]) {
        return [self.reverseDataSource tableView:tableView sectionForSectionIndexTitle:title atIndex:index];
    }
    
    return 0;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.reverseDataSource respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
        [self.reverseDataSource tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    if ([self.reverseDataSource respondsToSelector:@selector(moveRowAtIndexPath:toIndexPath:)]) {
        [self.reverseDataSource tableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    }
}


@end
