//
//  PersonalCenterView.m
//  shen1d
//
//  Created by Myth on 12-9-27.
//
//

#import "PersonalCenterView.h"

@implementation PersonalCenterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSueceeded)name: @"loginSueceeded" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutSueceeded)name: @"logoutSueceeded" object:nil];
        arrMyRecords = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-49) style:UITableViewStylePlain];
        m_tableView.dataSource = self;
        m_tableView.delegate = self;
        Global *global = [Global sharedGlobal];
        if (global.isLogined) {
            m_serviceGetRecords = [[serviceGetRecords alloc]initWithDelegate:self requestMode:TRequestMode_Asynchronous];
            [m_serviceGetRecords sendRequestWithData:[NSString stringWithFormat:@"userId=%@",global.userId] addr:@"get_records?"];
        }
        
        [self addSubview:m_tableView];
    }
    return self;
}

- (void)loginSueceeded
{
    Global *global = [Global sharedGlobal];
    m_serviceGetRecords = [[serviceGetRecords alloc]initWithDelegate:self requestMode:TRequestMode_Asynchronous];
    [m_serviceGetRecords sendRequestWithData:[NSString stringWithFormat:@"userId=%@",global.userId] addr:@"get_records?"];
}

- (void)logoutSueceeded
{
    [arrMyRecords removeAllObjects];
    [m_tableView reloadData];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"loginSueceeded" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"logoutSueceeded" object:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

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
    return 2;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *str;
    if (section == 0) {
        str = @"我的积分";
    }else if(section == 1){
        str = @"我的消费记录";
    }
    return str;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([indexPath section] == 1) {
//        cell.textLabel.text = [NSString stringWithFormat:@"金额:%@",[[arrMyRecords objectAtIndex:[indexPath row]] objectForKey:@"price"]];
        UILabel *lbShopName = [[UILabel alloc]initWithFrame:CGRectMake(30, 5, 290, 40)];
        lbShopName.textAlignment = NSTextAlignmentLeft;
        lbShopName.text = [[arrMyRecords objectAtIndex:[indexPath row]]objectForKey:@"shopName"];
        lbShopName.font = [UIFont boldSystemFontOfSize:22];
        [cell addSubview:lbShopName];
        
        UILabel *lbPrice = [[UILabel alloc]initWithFrame:CGRectMake(30, 40, 290, 30)];
        lbPrice.textAlignment = NSTextAlignmentLeft;
        lbPrice.text = [NSString stringWithFormat:@"金额:%@",[[arrMyRecords objectAtIndex:[indexPath row]] objectForKey:@"price"]];
        lbPrice.font = [UIFont systemFontOfSize:15];
        [cell addSubview:lbPrice];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger n = 0;
    if (section == 0) {
        n = 1;
    }else if(section == 1){
        n = [arrMyRecords count];
    }
    return n;
}


#pragma mark -
#pragma mark serviceCallBack
- (void)serviceGetRecordsCallBack:(NSDictionary *)dicCallBack withErrorMessage:(Error *)error;
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
            arrMyRecords = [dicCallBack objectForKey:@"records"];
            [m_tableView reloadData];
        }
    }else{
        LOGS(@"失败");
    }
    
}


@end
