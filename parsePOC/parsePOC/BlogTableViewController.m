//

#import "BlogTableViewController.h"
#import "NewPostViewController.h"
#import "Parse/Parse.h"

@implementation BlogTableViewController

@synthesize postArray;
@synthesize lastContentOffset;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"Post";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"textContent";
//        self.textKey = @"updatedAt";
        
        // The title for this table in the Navigation Controller.
        self.title = @"Post";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
//        self.paginationEnabled = YES;
        
        // The number of objects to show per page
//        self.objectsPerPage = 3;
    }
    return self;
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"Posts"];
    postArray = [[NSMutableArray alloc] init];
    UIBarButtonItem *refresh =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonHandler:)];
    
    UIBarButtonItem *add =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPostButtonHandler:)];
//    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonHandler:)]];
//    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPostButtonHandler:)]];
//    self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, -20, 0);
    NSArray *actionButtonItems = @[refresh,add];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 0;
    
    
}

- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
//    if ([PFUser currentUser])
//        [self refreshButtonHandler:nil];
}


- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}

#pragma mark - Button handlers

- (void)refreshButtonHandler:(id)sender 
{
////    //Create query for all Post object by the current user
////    PFQuery *postQuery = [PFQuery queryWithClassName:self.parseClassName];
////    [postQuery whereKey:@"author" equalTo:[PFUser currentUser]];
////    
////    // Run the query
////    [postQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
////        if (!error) {
////            //Save results and update the table
////            NSLog(@"user id %@",objects)
////            postArray = objects;
////            [self.tableView reloadData];
////        }
////    }];
//    
//    NSLog(@"");
//    
}

- (PFQuery *)queryForTable {
   
//    PFQuery *query;
//    PFObject *lastObject = [self.objects lastObject];
//    if (lastObject) {
//        query = [PFQuery queryWithClassName:@"Post" predicate:[NSPredicate predicateWithFormat:@"updatedAt >= %@",lastObject.updatedAt]];
//    }
//    else{
//        query = [PFQuery queryWithClassName:@"Post" predicate:[NSPredicate predicateWithFormat:@"author = %@", [PFUser currentUser]]];
//    }
  
    
 
//
//     orderby asc
    
     PFQuery *query =[PFQuery queryWithClassName:self.parseClassName];
    [query whereKey:@"author" equalTo:[PFUser currentUser]];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//            
//            
//            for (PFObject *object in objects) {
//                NSLog(@"%@", object.objectId);
//            }
////            NSLog(@"values = %@",objects);
//        }else{
//            
//        }
//    }];
  
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    
    
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
//    [query orderByAscending:@"updatedAt"];
    
    return query;
    
}

- (void)addPostButtonHandler:(id)sender 
{
    NewPostViewController *newPostViewController = [[NewPostViewController alloc] init];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:newPostViewController] animated:YES completion:nil];
}

//- (void)loadNextPage{
//    NSLog(@"Refresh....");
//}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.objects.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
  
//    NSLog(@"post id %@",object.objectId);
//    [postArray addObject:object.objectId];
    cell.textLabel.text = [object objectForKey:@"textContent"];
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"Added by: %@", [object objectForKey:@"author"]];
    // Configure the cell with the textContent of the Post as the cell's text label
//    PFObject *post = [postArray objectAtIndex:indexPath.row];
//    [cell.textLabel setText:[post objectForKey:@"textContent"]];
    
    return cell;
}

//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForNextPageAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *CellIdentifier = @"NextPage";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//      
//    }
//    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
////    cell.textLabel.text = nil;
////    cell.userInteractionEnabled = NO;
//    
//    return cell;
//}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You selected" message:[ NSString stringWithFormat:@"%d",[indexPath row]] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//    [alert show];
//    NSString *objectId = [postArray objectAtIndex:[indexPath row]];
//    NSLog(@"%@",objectId);
    [self objectAtIndexPath:indexPath];
    NSLog(@"%@",[self objectAtIndexPath:indexPath].objectId);
    [self likePost:[self objectAtIndexPath:indexPath]];
}


-(void)likePost:(PFObject *)object{
    [object addUniqueObject:[PFUser currentUser].objectId forKey:@"likes"];
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You selected" message:@"liked" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error" message:@" not liked" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
        
    
    
}
/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    if (self.lastContentOffset <  scrollView.contentOffset.y )
        scrollDirection = ScrollDirectionDown;
    else if (self.lastContentOffset > scrollView.contentOffset.y)
        scrollDirection = ScrollDirectionUp;
    
    self.lastContentOffset = scrollView.contentOffset.y;
}
//
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

    if(scrollDirection == ScrollDirectionUp)
        //if(rowIndex < 5.0f)
        
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"scrolled" message:@" up" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
    else if(scrollDirection == ScrollDirectionDown)

    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"scrolled" message:@" down" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [alert show];
        [self queryForTable];
        [self objectsWillLoad];
        
       
    }
    
}

*/

@end
