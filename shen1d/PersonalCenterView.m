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
        m_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-49) style:UITableViewStylePlain];
        m_tableView.dataSource = self;
        m_tableView.delegate = self;
        [self addSubview:m_tableView];
    }
    return self;
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
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger n;
    if (section == 0) {
        n = 1;
    }else if(section == 1){
        n = 5;
    }
    return n;
}



@end
