//
//  CardBackView.m
//  shen1d
//
//  Created by Myth on 12-9-20.
//
//

#import "CardBackView.h"

@implementation CardBackView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        m_tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        m_tableView.dataSource = self;
        m_tableView.delegate = self;
        [self addSubview:m_tableView];
        
        arrPrivilege = [[NSArray alloc]initWithObjects:@"午夜来店消费满80元送菜梗猪肝一份(招牌菜)",@"晚餐来店消费十三香小龙虾或碳烤小龙虾送指定啤酒两瓶",@"晚餐来店消费十三香小龙虾或碳烤小龙虾送指定啤酒两瓶", nil];
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
    return 100;
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
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bq.png"]];
    image.frame = CGRectMake(20, 20, 60, 60);
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(100, 10, 220, 80)];
    textView.editable = YES;
    textView.delegate = self;
    textView.scrollEnabled = NO;
//    [textView canBecomeFirstResponder];
    textView.text = [arrPrivilege objectAtIndex:[indexPath row]];
    [textView setFont:[UIFont systemFontOfSize:18]];
    [cell addSubview:textView];
    [cell addSubview:image];
    
    return cell;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrPrivilege count];
}



@end
