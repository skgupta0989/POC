//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

typedef enum ScrollDirection {
    ScrollDirectionNone,
    ScrollDirectionRight,
    ScrollDirectionLeft,
    ScrollDirectionUp,
    ScrollDirectionDown,
    ScrollDirectionCrazy,
} ScrollDirection;
@interface BlogTableViewController : PFQueryTableViewController<UIScrollViewDelegate>
{
    NSMutableArray *postArray;
    ScrollDirection scrollDirection;;
}

@property (nonatomic, strong) NSMutableArray *postArray;
@property (nonatomic, assign) CGFloat lastContentOffset;
- (void)addPostButtonHandler:(id)sender;
- (void)refreshButtonHandler:(id)sender;

@end
