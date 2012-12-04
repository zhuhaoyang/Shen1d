//
//  LoginViewController.m
//  shen1d
//
//  Created by Myth on 12-10-30.
//
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.view.frame = CGRectMake(0, 0, 320, 480);
        // Custom initialization
//        self.hidesBottomBarWhenPushed = YES;
        UIImageView *backGround = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background"]];
        backGround.frame = CGRectMake(0, 0, 320, 460);
        [self.view addSubview:backGround];
        registerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
        registerView.alpha = 1;
        UIImageView *backGround1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background"]];
        backGround1.frame = CGRectMake(0, 0, 320, 460);
        [registerView addSubview:backGround1];
        
        emailLogin = [[UITextField alloc]initWithFrame:CGRectMake(50, 100, 220, 30)];
        emailLogin.borderStyle = UITextBorderStyleRoundedRect;
        emailLogin.delegate = self;
        emailLogin.autocapitalizationType = UITextAutocapitalizationTypeNone;
        emailLogin.autocorrectionType = UITextAutocorrectionTypeNo;
        emailLogin.returnKeyType = UIReturnKeyGo;
        emailLogin.placeholder = @"E-mail";
        emailLogin.tag = 1;
        [self.view addSubview:emailLogin];
        
        passwordLogin = [[UITextField alloc]initWithFrame:CGRectMake(50, 150, 220, 30)];
        passwordLogin.borderStyle = UITextBorderStyleRoundedRect;
        passwordLogin.delegate = self;
        passwordLogin.autocapitalizationType = UITextAutocapitalizationTypeNone;
        passwordLogin.autocorrectionType = UITextAutocorrectionTypeNo;
        passwordLogin.returnKeyType = UIReturnKeyGo;
        passwordLogin.placeholder = @"密码";
        passwordLogin.tag = 1;
        [self.view addSubview:passwordLogin];
        
        UIButton *btLogin = [UIButton buttonWithType:UIButtonTypeCustom];
        btLogin.frame = CGRectMake(50, 300, 100, 50);
        [btLogin addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        [btLogin setBackgroundImage:[UIImage imageNamed:@"btn_log2"] forState:UIControlStateNormal];
        [self.view addSubview:btLogin];
        
        UIButton *btTurn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btTurn1.frame = CGRectMake(200, 300, 100, 50);
        btTurn1.tag = 100;
        [btTurn1 addTarget:self action:@selector(turnOver:) forControlEvents:UIControlEventTouchUpInside];
        [btTurn1 setBackgroundImage:[UIImage imageNamed:@"btn_log1"] forState:UIControlStateNormal];
        [self.view addSubview:btTurn1];
        
        UIButton *btCancel1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btCancel1.frame = CGRectMake(0, 460-65, 320, 58);
        [btCancel1 addTarget:self action:@selector(cancelLogin) forControlEvents:UIControlEventTouchUpInside];
        [btCancel1 setBackgroundImage:[UIImage imageNamed:@"btn_cancel2"] forState:UIControlStateNormal];
        [self.view addSubview:btCancel1];
        
        
        emailRegister = [[UITextField alloc]initWithFrame:CGRectMake(50, 25, 220, 30)];
        emailRegister.borderStyle = UITextBorderStyleRoundedRect;
        emailRegister.delegate = self;
        emailRegister.autocapitalizationType = UITextAutocapitalizationTypeNone;
        emailRegister.autocorrectionType = UITextAutocorrectionTypeNo;
        emailRegister.returnKeyType = UIReturnKeyGo;
        emailRegister.placeholder = @"E-mail";
        [registerView addSubview:emailRegister];

        password1Register = [[UITextField alloc]initWithFrame:CGRectMake(50, 75, 220, 30)];
        password1Register.borderStyle = UITextBorderStyleRoundedRect;
        password1Register.delegate = self;
        password1Register.autocapitalizationType = UITextAutocapitalizationTypeNone;
        password1Register.autocorrectionType = UITextAutocorrectionTypeNo;
        password1Register.returnKeyType = UIReturnKeyGo;
        password1Register.placeholder = @"密码";
        [registerView addSubview:password1Register];
        
        password2Register = [[UITextField alloc]initWithFrame:CGRectMake(50, 125, 220, 30)];
        password2Register.borderStyle = UITextBorderStyleRoundedRect;
        password2Register.delegate = self;
        password2Register.autocapitalizationType = UITextAutocapitalizationTypeNone;
        password2Register.autocorrectionType = UITextAutocorrectionTypeNo;
        password2Register.returnKeyType = UIReturnKeyGo;
        password2Register.placeholder = @"确认密码";
        [registerView addSubview:password2Register];
        
        usernameRegister = [[UITextField alloc]initWithFrame:CGRectMake(50, 175, 220, 30)];
        usernameRegister.borderStyle = UITextBorderStyleRoundedRect;
        usernameRegister.delegate = self;
        usernameRegister.autocapitalizationType = UITextAutocapitalizationTypeNone;
        usernameRegister.autocorrectionType = UITextAutocorrectionTypeNo;
        usernameRegister.returnKeyType = UIReturnKeyGo;
        usernameRegister.placeholder = @"昵称";
        [registerView addSubview:usernameRegister];
        
        phonenumberRegister = [[UITextField alloc]initWithFrame:CGRectMake(50, 225, 220, 30)];
        phonenumberRegister.borderStyle = UITextBorderStyleRoundedRect;
        phonenumberRegister.delegate = self;
        phonenumberRegister.autocapitalizationType = UITextAutocapitalizationTypeNone;
        phonenumberRegister.autocorrectionType = UITextAutocorrectionTypeNo;
        phonenumberRegister.returnKeyType = UIReturnKeyGo;
        phonenumberRegister.placeholder = @"手机号";
        [registerView addSubview:phonenumberRegister];
        
        UIButton *btRegister = [UIButton buttonWithType:UIButtonTypeCustom];
        btRegister.frame = CGRectMake(50, 300, 100, 50);
        [btRegister addTarget:self action:@selector(register) forControlEvents:UIControlEventTouchUpInside];
        [btRegister setBackgroundImage:[UIImage imageNamed:@"btn_log1"] forState:UIControlStateNormal];
        [registerView addSubview:btRegister];
        
        UIButton *btTurn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btTurn2.frame = CGRectMake(200, 300, 100, 50);
        btTurn2.tag = 101;
        [btTurn2 addTarget:self action:@selector(turnOver:) forControlEvents:UIControlEventTouchUpInside];
        [btTurn2 setBackgroundImage:[UIImage imageNamed:@"btn_log2"] forState:UIControlStateNormal];
        [registerView addSubview:btTurn2];
        
        UIButton *btCancel2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btCancel2.frame = CGRectMake(0, 460-65, 320, 58);
        [btCancel2 addTarget:self action:@selector(cancelLogin) forControlEvents:UIControlEventTouchUpInside];
        [btCancel2 setBackgroundImage:[UIImage imageNamed:@"btn_cancel2"] forState:UIControlStateNormal];
        [registerView addSubview:btCancel2];
    }
    return self;
}

- (void)cancelLogin
{
//    CATransition *animation = [CATransition animation];
//    animation.delegate = self;
//    animation.duration = 0.5f ;
//    animation.timingFunction = UIViewAnimationCurveEaseInOut;
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
//    animation.subtype = kCATransitionFromBottom;
//    animation.type = @"cube";
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:m_LoginViewController.view cache:YES];
//    [self.view.layer addAnimation:animation forKey:@"animationID"];

    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [UIView beginAnimations:nil context:context];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationDuration:0.3];
//    
//    self.view.frame = CGRectMake(0, -460, 320, 460);
//
//    [UIView setAnimationDelegate:self];
//    [UIView commitAnimations];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"removeLoginView" object:nil];
//    [self.view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.3];

//    [self.view removeFromSuperview];

}

- (void)login
{
//    NSLog(@"login!");
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    UIAlertView *alert;
    if ([emailLogin.text length] == 0) {
        alert = [[UIAlertView alloc]initWithTitle:@"Email不可为空!"
                                          message:nil
                                         delegate:self
                                cancelButtonTitle:@"确认"
                                otherButtonTitles: nil];
        [alert show];
        return;
    }else if([passwordLogin.text length] == 0){
        alert = [[UIAlertView alloc]initWithTitle:@"密码不可为空!"
                                          message:nil
                                         delegate:self
                                cancelButtonTitle:@"确认"
                                otherButtonTitles: nil];
        [alert show];
        return;
    }else{
        m_serviceLogin = [[serviceLogin alloc]initWithDelegate:self requestMode:TRequestMode_Asynchronous];
        [m_serviceLogin sendRequestWithData:[NSString stringWithFormat:@"email=%@&password=%@",emailLogin.text,passwordLogin.text] addr:@"login?"];
    }
}

- (void)register
{
    m_serviceRegister = [[serviceRegister alloc]initWithDelegate:self requestMode:TRequestMode_Asynchronous];
    [m_serviceRegister sendRequestWithData:[NSString stringWithFormat:@"username=%@&password=%@&email=%@&phonenumber=%@",usernameRegister.text,password1Register.text,emailRegister.text,phonenumberRegister.text] addr:@"register?"];
    
    
    
}

- (void)turnOver:(id)sender
{
    UIButton *bt = sender;
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.7];
    
    
    if (bt.tag == 100) {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
        [self.view addSubview:registerView];
    }else if(bt.tag == 101){
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];

        [registerView removeFromSuperview];
    }
    
    
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用某个方法
    //[UIView setAnimationDidStopSelector:@selector(animationFinished:)];
    [UIView commitAnimations];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [emailLogin resignFirstResponder];
    [passwordLogin resignFirstResponder];
    [emailRegister resignFirstResponder];
    [password1Register resignFirstResponder];
    [password2Register resignFirstResponder];
    [usernameRegister resignFirstResponder];
    [phonenumberRegister resignFirstResponder];
    if (textField.tag == 1) {
        [self login];
    }else if(textField.tag == 0){
        [self register];
    }
    return 1;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark serviceCallBack
- (void)serviceRegisterCallBack:(NSDictionary *)dicCallBack withErrorMessage:(Error *)error;
{
    UIAlertView *alert;
    if ([dicCallBack objectForKey:@"state"] != nil) {
        if ([dicCallBack objectForKey:@"state"] == [NSNumber numberWithInt:1]) {
            alert = [[UIAlertView alloc]initWithTitle:[dicCallBack objectForKey:@"error"]
                                              message:nil
                                             delegate:self
                                    cancelButtonTitle:@"确认"
                                    otherButtonTitles:nil];
        }else if([dicCallBack objectForKey:@"state"] == [NSNumber numberWithInt:0]){
            alert = [[UIAlertView alloc]initWithTitle:@"登陆成功"
                                              message:nil
                                             delegate:self
                                    cancelButtonTitle:@"确认"
                                    otherButtonTitles:nil];
            Global *global = [Global sharedGlobal];
            global.userId = [dicCallBack objectForKey:@"userId"];
        }
    }else{
        LOGS(@"失败");
    }
    [alert show];
}


- (void)serviceLoginCallBack:(NSDictionary *)dicCallBack withErrorMessage:(Error *)error;
{
    UIAlertView *alert;
    if ([dicCallBack objectForKey:@"state"] != nil) {
        if ([dicCallBack objectForKey:@"state"] == [NSNumber numberWithInt:1]) {
            alert = [[UIAlertView alloc]initWithTitle:[dicCallBack objectForKey:@"error"]
                                              message:nil
                                             delegate:self
                                    cancelButtonTitle:@"确认"
                                    otherButtonTitles:nil];
        }else if([dicCallBack objectForKey:@"state"] == [NSNumber numberWithInt:0]){
            alert = [[UIAlertView alloc]initWithTitle:@"登陆成功"
                                              message:nil
                                             delegate:self
                                    cancelButtonTitle:@"确认"
                                    otherButtonTitles:nil];
            Global *global = [Global sharedGlobal];
//            global.userId = nil;
//            CFRelease((__bridge CFTypeRef)(global.userId));
//            global.userId = [NSString stringWithFormat:@"%i",[[[dicCallBack objectForKey:@"user"] objectForKey:@"userId"]intValue]];
            global.userId = [NSString stringWithFormat:@"%@",[[dicCallBack objectForKey:@"user"] objectForKey:@"userId"]];
            global.uname = [[dicCallBack objectForKey:@"user"] objectForKey:@"uname"];
            global.email = [[dicCallBack objectForKey:@"user"] objectForKey:@"email"];
            global.password = [[dicCallBack objectForKey:@"user"] objectForKey:@"password"];
            global.qrcode = [QRCodeGenerator qrImageForString:global.userId imageSize:100];
            global.phone = [[dicCallBack objectForKey:@"user"] objectForKey:@"phone"];
            global.created = [[dicCallBack objectForKey:@"user"] objectForKey:@"created"];
            dbManager = [DatabaseManager sharedDatabaseManager];
            [dbManager deleteTable:TableNamePersonalInfo];
            [dbManager insertPersonalInfo:[dicCallBack objectForKey:@"user"]];
            global.isLogined = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSueceeded" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"removeLoginView" object:nil];
        }
    }else{
       LOGS(@"失败");
    }
    [alert show];
}

@end
