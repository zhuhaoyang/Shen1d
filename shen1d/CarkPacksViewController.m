//
//  CarkPacksViewController.m
//  shen1d
//
//  Created by Myth on 12-9-11.
//
//

#import "CarkPacksViewController.h"
@interface CarkPacksViewController ()


@end

@implementation CarkPacksViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"卡包";
        m_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-49) style:UITableViewStylePlain];
        m_tableView.dataSource = self;
        m_tableView.delegate = self;
        [self.view addSubview:m_tableView];
        
        arrCard = [[NSMutableArray alloc]initWithObjects:@"111",@"222",@"333",@"444",@"555", nil];
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                        initWithTitle:@"Delete"
                                        style:UIBarButtonItemStyleBordered
                                        target:self
                                        action:@selector(edit)];
        self.navigationItem.rightBarButtonItem = rightButton;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)edit
{
    [m_tableView setEditing:!m_tableView.editing animated:YES];
    if (m_tableView.editing)
        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
    else
        [self.navigationItem.rightBarButtonItem setTitle:@"Delete"];

}

#pragma mark -
#pragma mark tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark -
#pragma mark tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 60)];
    label.font = [UIFont boldSystemFontOfSize:25];
    label.text = [arrCard objectAtIndex:[indexPath row]];
    [cell.contentView addSubview:label];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrCard count];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete; //每行左边会出现红的删除按钮
}

- (BOOL)tableView:(UITableView *)tableView
canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
      toIndexPath:(NSIndexPath *)toIndexPath {
    NSUInteger fromRow = [fromIndexPath row];
    NSUInteger toRow = [toIndexPath row];
    
    id object = [arrCard objectAtIndex:fromRow];
    [arrCard removeObjectAtIndex:fromRow];
    [arrCard insertObject:object atIndex:toRow];
    NSLog(@"%@",arrCard);
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = [indexPath row];
    [arrCard removeObjectAtIndex:row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                     withRowAnimation:UITableViewRowAnimationFade];
    NSLog(@"%@",arrCard);
}



@end
