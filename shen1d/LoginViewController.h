//
//  LoginViewController.h
//  shen1d
//
//  Created by Myth on 12-10-30.
//
//

#import <UIKit/UIKit.h>
#import "serviceLogin.h"
#import "serviceRegister.h"
#import "Global.h"
#import "DatabaseManager.h"
#import "PublicDefine.h"
#import "QRCodeGenerator.h"
@interface LoginViewController : UIViewController<UITextFieldDelegate,serviceRegisterCallBackDelegate>{
    UITextField *emailLogin;
    UITextField *passwordLogin;
    
    UITextField *emailRegister;
    UITextField *password1Register;
    UITextField *password2Register;
    UITextField *usernameRegister;
    UITextField *phonenumberRegister;
    
    NSString *strUsername;
    NSString *strPassword;
    NSString *strEmail;
    NSString *strPhonenumber;
    serviceLogin *m_serviceLogin;
    serviceRegister *m_serviceRegister;
    UIView *registerView;
    DatabaseManager *dbManager;
}

@end
