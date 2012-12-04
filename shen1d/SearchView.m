//
//  SearchView.m
//  shen1d
//
//  Created by Myth on 12-9-14.
//
//

#import "SearchView.h"

@implementation SearchView
@synthesize delegate = _delegate;
@synthesize searchTextField = _searchTextField;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.searchTextField = [[UITextField  alloc] initWithFrame:CGRectMake(0,7, frame.size.width, 25)];
		self.searchTextField.borderStyle = UITextBorderStyleRoundedRect;
        self.searchTextField.bounds = CGRectMake(0, 0, frame.size.width - 20, 31);
        self.searchTextField.returnKeyType = UIReturnKeySearch;
        self.searchTextField.layer.cornerRadius = 10.0;
        self.searchTextField.layer.borderColor = [UIColor darkGrayColor].CGColor;
        self.searchTextField.layer.borderWidth = 1.0;
        self.searchTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.searchTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.searchTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        self.searchTextField.text = NSLocalizedString(@"Current Location", nil);
        self.searchTextField.delegate = (id)self;
        
        
        UIButton *bookmark = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 29)];
        [bookmark setImage:[UIImage imageNamed:@"UISearchBarBookmarks"] forState:UIControlStateNormal];
        [bookmark setImage:[UIImage imageNamed:@"UISearchBarBookmarksPressed"] forState:UIControlStateHighlighted];
        [bookmark addTarget:self action:@selector(startBookmarkButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        self.searchTextField.rightViewMode = UITextFieldViewModeUnlessEditing;
        self.searchTextField.rightView = bookmark;
        self.searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        UILabel *preText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 35, 29)];
        preText.text = NSLocalizedString(@"Search:", nil);
        preText.backgroundColor = [UIColor clearColor];
        preText.textColor = [UIColor grayColor];
        preText.font = [UIFont systemFontOfSize:12];
        self.searchTextField.leftViewMode = UITextFieldViewModeAlways;
        self.searchTextField.leftView = preText;
        
        [self addSubview:self.searchTextField];

    }
    return self;
}

- (void)startBookmarkButtonClicked
{
    LOGS(@"13213");
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSRange myRange = [textField.text rangeOfString:NSLocalizedString(@"Current Location", nil) options:NSCaseInsensitiveSearch];
    if (myRange.location != NSNotFound) {
        [textField setText:@""];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.searchTextField) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(routeButtonClicked:)]) {
            [self.searchTextField resignFirstResponder];
            if (self.delegate && [self.delegate respondsToSelector:@selector(niftySearchViewResigend)]) {
                [self.delegate niftySearchViewResigend];
            }
            [self.delegate routeButtonClicked:self.searchTextField];
        }
    }
    return TRUE;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
