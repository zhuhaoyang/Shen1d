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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSueceeded)name: @"loginSueceeded" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutSueceeded)name: @"logoutSueceeded" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(storeupSueceeded)name: @"storeupSueceeded" object:nil];

        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        title.text = @"卡包";
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = [UIColor colorWithRed:0.88 green:0.42 blue:0 alpha:1];
        title.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        title.font = [UIFont boldSystemFontOfSize:23];
        self.navigationItem.titleView = title;
        m_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-49) style:UITableViewStylePlain];
        m_tableView.dataSource = self;
        m_tableView.delegate = self;
        m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:m_tableView];
        
//        arrMyShops = [[NSMutableArray alloc]initWithObjects:@"111",@"222",@"333",@"444",@"555", nil];
        
        btEdit = [UIButton buttonWithType:UIButtonTypeCustom];
        btEdit.frame = CGRectMake(0, 0, 53, 30);
        [btEdit setImage:[UIImage imageNamed:@"btn1"] forState:UIControlStateNormal];
        [btEdit addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
        btEdit.tag = 0;
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:btEdit];
        [self.navigationItem setRightBarButtonItem:rightButton];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    Global *global = [Global sharedGlobal];
    if (global.isLogined) {
        DatabaseManager *dbManager = [DatabaseManager sharedDatabaseManager];
        arrMyShops = (NSMutableArray *)[dbManager queryMyshopsFromTable];
        if ([arrMyShops count] == 0 || arrMyShops == nil) {
            m_serviceGetMyShops = [[serviceGetMyShops alloc]initWithDelegate:self requestMode:TRequestMode_Asynchronous];
            [m_serviceGetMyShops sendRequestWithData:[NSString stringWithFormat:@"userId=%@",global.userId] addr:@"get_my_shops?"];
        }
        
    }

}

- (void)loginSueceeded
{
    Global *global = [Global sharedGlobal];
    m_serviceGetMyShops = [[serviceGetMyShops alloc]initWithDelegate:self requestMode:TRequestMode_Asynchronous];
    [m_serviceGetMyShops sendRequestWithData:[NSString stringWithFormat:@"userId=%@",global.userId] addr:@"get_my_shops?"];
}

- (void)logoutSueceeded
{
    arrMyShops = nil;
    [m_tableView reloadData];
}

- (void)storeupSueceeded
{
    DatabaseManager *dbManager = [DatabaseManager sharedDatabaseManager];
    arrMyShops = (NSMutableArray *)[dbManager queryMyshopsFromTable];
    [m_tableView reloadData];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"loginSueceeded" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"logoutSueceeded" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"storeupSueceeded" object:nil];
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

- (void)edit:(id)sender
{
    UIButton *bt = sender;
    if (bt.tag == 0) {
        [bt setImage:[UIImage imageNamed:@"btn10"] forState:UIControlStateNormal];
        bt.tag = 1;
    }else if(bt.tag == 1){
        [bt setImage:[UIImage imageNamed:@"btn1"] forState:UIControlStateNormal];
        bt.tag = 0;
    }
    [m_tableView setEditing:!m_tableView.editing animated:YES];
//    if (m_tableView.editing)
//        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
//    else
//        [self.navigationItem.rightBarButtonItem setTitle:@"Delete"];

}

#pragma mark -
#pragma mark tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *shopId = [[arrMyShops objectAtIndex:[indexPath row]] objectForKey:@"shopId"];
    m_CardViewController = [[CardViewController alloc]initWithNibName:@"CardViewController" shopId:[[arrMyShops objectAtIndex:[indexPath row]] objectForKey:@"shopId"] bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:m_CardViewController animated:YES];
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
//    [cell.contentView addSubview:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"card_blank" ]]];
    cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"card_blank" ]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([indexPath row] < [arrMyShops count]) {
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 60)];
//        label.font = [UIFont boldSystemFontOfSize:25];
//        label.text = [[arrMyShops objectAtIndex:[indexPath row]]objectForKey:@"shopName"];
//        [cell.contentView addSubview:label];
        UIImageView *img;
        switch ([[[arrMyShops objectAtIndex:[indexPath row]] objectForKey:@"cardType"] intValue]) {
            case 1:
                img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"card1"]];
                break;
            case 2:
                img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"card2"]];
                break;
            case 3:
                img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"card3"]];
                break;
            case 4:
                img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"card4"]];
                break;
            case 5:
                img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"card5"]];
                break;
            default:
                img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cardsample"]];
                break;
        }
        img.frame = CGRectMake(20, 17, 280, 63);
        img.layer.shadowColor = [UIColor blackColor].CGColor;
        img.layer.shadowOffset = CGSizeMake(4, -4);
        img.layer.shadowOpacity = 0.5;
        img.layer.shadowRadius = 4.0;

        [cell.contentView addSubview:img];
        cell.textLabel.text = [[arrMyShops objectAtIndex:[indexPath row]]objectForKey:@"shopName"];
        cell.textLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    }
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([arrMyShops count] <= 5) {
        return 5;
    }else{
        return [arrMyShops count];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([arrMyShops count] > [indexPath row]) {
        return UITableViewCellEditingStyleDelete; //每行左边会出现红的删除按钮
    }else{
        return UITableViewCellEditingStyleNone;
    }

}

- (BOOL)tableView:(UITableView *)tableView
canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([arrMyShops count] > [indexPath row]) {
        return YES;
    }else{
        return NO;
    }

}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
      toIndexPath:(NSIndexPath *)toIndexPath {
    NSUInteger fromRow = [fromIndexPath row];
    NSUInteger toRow = [toIndexPath row];
    
    id object = [arrMyShops objectAtIndex:fromRow];
    [arrMyShops removeObjectAtIndex:fromRow];
    [arrMyShops insertObject:object atIndex:toRow];
    DatabaseManager *dbManager = [DatabaseManager sharedDatabaseManager];
    if ([dbManager deleteTable:TableNameMyShops]) {
        [dbManager insertMyShops:arrMyShops];
    }
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    
    Global *global = [Global sharedGlobal];
    m_serviceDelMyShop = [[serviceDelMyShop alloc]initWithDelegate:self requestMode:TRequestMode_Asynchronous];
    [m_serviceDelMyShop sendRequestWithData:[NSString stringWithFormat:@"userId=%@&shopId=%@",global.userId,[[arrMyShops objectAtIndex:row] objectForKey:@"shopId"]] addr:@"del_my_shop?"];
    [arrMyShops removeObjectAtIndex:row];
   //    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
//                     withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark -
#pragma mark serviceCallBack
- (void)serviceGetMyShopsCallBack:(NSDictionary *)dicCallBack withErrorMessage:(Error *)error;
{
    UIAlertView *alert;
    if ([dicCallBack objectForKey:@"state"] != nil) {
        if ([dicCallBack objectForKey:@"state"] == [NSNumber numberWithInt:1]) {
            alert = [[UIAlertView alloc]initWithTitle:[dicCallBack objectForKey:@"error"]
                                              message:nil
                                             delegate:self
                                    cancelButtonTitle:@"确认"
                                    otherButtonTitles:nil];
            [alert show];
        }else if([dicCallBack objectForKey:@"state"] == [NSNumber numberWithInt:0]){
            arrMyShops = [dicCallBack objectForKey:@"shops"];
            DatabaseManager *dbManager = [DatabaseManager sharedDatabaseManager];
            [dbManager insertMyShops:arrMyShops];
            [m_tableView reloadData];
        }
    }else{
       LOGS(@"失败");
    }
    
}

- (void)serviceDelMyShopCallBack:(NSDictionary *)dicCallBack withErrorMessage:(Error *)error
{
    UIAlertView *alert;
    if ([dicCallBack objectForKey:@"state"] != nil) {
        if ([dicCallBack objectForKey:@"state"] == [NSNumber numberWithInt:1]) {
            alert = [[UIAlertView alloc]initWithTitle:[dicCallBack objectForKey:@"error"]
                                              message:nil
                                             delegate:self
                                    cancelButtonTitle:@"确认"
                                    otherButtonTitles:nil];
            [alert show];
        }else if([dicCallBack objectForKey:@"state"] == [NSNumber numberWithInt:0]){
            DatabaseManager *dbManager = [DatabaseManager sharedDatabaseManager];
            if ([dbManager deleteTable:TableNameMyShops]) {
                [dbManager insertMyShops:arrMyShops];
                [m_tableView reloadData];
//                alert = [[UIAlertView alloc]initWithTitle:@"删除成功!"
//                                                  message:nil
//                                                 delegate:self
//                                        cancelButtonTitle:@"确认"
//                                        otherButtonTitles:nil];
//                [alert show];
            }

        }
    }else{
        LOGS(@"失败");
    }

}



//- (void)serviceGetShopCallBack:(NSDictionary *)dicCallBack withErrorMessage:(Error *)error;
//{
//    UIAlertView *alert;
//    if ([dicCallBack objectForKey:@"state"] != nil) {
//        if ([dicCallBack objectForKey:@"state"] == [NSNumber numberWithInt:1]) {
//            alert = [[UIAlertView alloc]initWithTitle:[dicCallBack objectForKey:@"error"]
//                                              message:nil
//                                             delegate:self
//                                    cancelButtonTitle:@"确认"
//                                    otherButtonTitles:nil];
//            [alert show];
//        }else if([dicCallBack objectForKey:@"state"] == [NSNumber numberWithInt:0]){
//            m_CardViewController = [[CardViewController alloc]initWithNibName:@"CardViewController" data:[dicCallBack objectForKey:@"shop"] bundle:[NSBundle mainBundle]];
//            [self.navigationController pushViewController:m_CardViewController animated:YES];
//        }
//    }else{
//        LOGS(@"失败");
//    }
//    
//}

@end
