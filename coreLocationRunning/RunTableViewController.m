// Martha Wolnicki
// wolnicki@usc.edu
// ITP 342
// Bennett Lee
// Final Project: coreLocationRunning

#import "RunTableViewController.h"
#import "RunModel.h"
#import "RunDetailsViewController.h"

// interface
@interface RunTableViewController ()

@property (strong, nonatomic) RunModel *model;
@property (strong, nonatomic) Run* selectedRun;

@end



// implementation
@implementation RunTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@" RUN VIEW CONTROLLER LOADED");
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // model singleton method
    self.model = [RunModel sharedModel];
}

- (void) viewWillAppear {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




// data source methods, delegate methods
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// number of rows in section - rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [self.model numberOfRuns];
}


// configuration of the cell using data from the model
-(UITableViewCell* ) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath: indexPath];
    
    Run *run = [self.model runAtIndex: indexPath.row];
    
    cell.textLabel.text =[NSString stringWithFormat:@"TIME: %@ s,(%@ m)", run.timeString, run.distanceString];
    
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    
    // if going to run details view controller
    if ([segue.identifier isEqualToString:@"runDetailsViewControllerSegue"])
    {
        
        RunDetailsViewController *rd = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        self.selectedRun =  [self.model runAtIndex: indexPath.row];
        
        // Pass the selected object to the new view controller
        rd.selectedRun = _selectedRun;
    }
    
    // if going to run view controller
    else if ([segue.identifier isEqualToString:@"createNewRun"]){
        RunTableViewController *runViewController = [segue destinationViewController];
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedRun =  [self.model runAtIndex: indexPath.row];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if ( [_model numberOfRuns] == 1){
            [_model removeRun];
        }
        
        else{
            // delete row from the data source
            [_model removeRunAtIndex:indexPath.row];
        }
        
        // animation of the deletion
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}




//AddViewController *addViewController = [segue destinationViewController];
// Pass the selected object to the new view controller
//addViewController.selectedRun = _selectedRun;




/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
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


@end
