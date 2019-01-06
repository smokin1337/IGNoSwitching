#import <objc/runtime.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import <UserNotifications/UserNotifications.h>
#import <UIKit/UIKit.h>

@interface IGSwitchUsersController : UIViewController
@end

%hook SBUIAction

  -(id)initWithTitle:(id)arg1 subtitle:(id)arg2 image:(id)arg3 badgeView:(id)arg4 handler:(/*^block*/id)arg5{

    if([arg1 isEqualToString:@"Switch Account"]){
      arg5 = ^{nil;};
      arg2 = @"Protected";
      return %orig;
    }
    else{
      return %orig;
    }
  }

%end

%hook IGTabBarController

  -(void)_displaySwitchUsersTableView:(BOOL)arg1 animated:(BOOL)arg2{

    if(arg1 == YES){

      LAContext *laContext = [[LAContext alloc] init];

      NSError *error = nil;
      if ([laContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error]) {
        if (error) {


        } else {

          [laContext evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"IGNoSwitching Protection" reply:^(BOOL success, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
              if (error) {

                UIViewController * controller = [[UIApplication sharedApplication] keyWindow].rootViewController;
                while (controller.presentedViewController) {
                controller = controller.presentedViewController;
                }
                  NSString *title = @"IGNoSwitching";
                  NSString *message = @"You must authenticate to switch users, please try again !!";//[[NSNumber numberWithLong:self.status] stringValue];//stringToDisplay;//[stringToDisplay stringValue];

                  UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
                  UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                      // Extra Stuff?
                    }];
                    [alert addAction:okButton];
                    [controller presentViewController:alert animated:YES completion:nil];



              } else if (success) {

                  %orig;

              } else {
                UIViewController * controller = [[UIApplication sharedApplication] keyWindow].rootViewController;
                while (controller.presentedViewController) {
                controller = controller.presentedViewController;
                }
                  NSString *title = @"IGNoSwitching";
                  NSString *message = @"You must authenticate to switch users, please try again !!";//[[NSNumber numberWithLong:self.status] stringValue];//stringToDisplay;//[stringToDisplay stringValue];

                  UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
                  UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                    }];
                    [alert addAction:okButton];
                    [controller presentViewController:alert animated:YES completion:nil];
              }
            });
          }];
        }
      }
    }
    else{
      %orig;
    }
  }
%end

%hook IGProfileTitleViewController

  -(void)_displaySwitchControl:(BOOL)arg1{

    if(arg1 == YES){

      LAContext *laContext = [[LAContext alloc] init];
      NSError *error = nil;

      if ([laContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error]) {
        //dispatch_async(dispatch_get_main_queue(), ^{
        if (error) {


        } else {

          [laContext evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"IGNoSwitching" reply:^(BOOL success, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
              if (error) {

                UIViewController * controller = [[UIApplication sharedApplication] keyWindow].rootViewController;
                while (controller.presentedViewController) {
                controller = controller.presentedViewController;
                }
                  NSString *title = @"IGNoSwitching";
                  NSString *message = @"You must authenticate to switch users, please try again !!";//[[NSNumber numberWithLong:self.status] stringValue];//stringToDisplay;//[stringToDisplay stringValue];

                  UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
                  UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                      // Extra Stuff?
                    }];
                    [alert addAction:okButton];
                    [controller presentViewController:alert animated:YES completion:nil];

              } else if (success) {

                  %orig;

              } else {
                UIViewController * controller = [[UIApplication sharedApplication] keyWindow].rootViewController;
                while (controller.presentedViewController) {
                controller = controller.presentedViewController;
                }
                  NSString *title = @"IGNoSwitching";
                  NSString *message = @"You must authenticate to switch users !!";//[[NSNumber numberWithLong:self.status] stringValue];//stringToDisplay;//[stringToDisplay stringValue];

                  UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
                  UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {

                    }];
                    [alert addAction:okButton];
                    [controller presentViewController:alert animated:YES completion:nil];
              }
            });
          }];
        }
      }
    }
    else{
      %orig;
    }
  }
%end
