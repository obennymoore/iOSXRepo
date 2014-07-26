//
//  ViewController.m
//  iOSProject
//
//  Created by Ochuko Benemoh on 2014-07-25.
//  Copyright (c) 2014 O|B. All rights reserved.
//
//  This app calculates your body mass index and displays the appropriate
//  along with a color coded risk level.
//
//  Constraints have been added appropriately for both portrait and landscape
//  orientations.
//
//  The segmented control programmatically inserts placeholders based on the
//  preferred unit of measurement
//
//  The text fields show the approprite unit of measurement on end editing and also
//  hides the soft keyboard on return
//
//  The soft keyboard also hides on click outside of any control as well as on click
//  of the "Check My BMI" button

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *weightTextField;
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *unitsSegmentedcontrol;
@property (weak, nonatomic) IBOutlet UILabel *bmiResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *heightUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *bmiStatusLabel;
-(void)setBMIStatus: (double)withBMIValue;
@end

@implementation ViewController{
    NSString* weightPlaceholder;
    NSString* heightPlaceholder;
    int flag;
    double w,h,bmi;
}

- (IBAction)unitSelector:(id)sender {
    
    UISegmentedControl* unitSegment = (UISegmentedControl*) sender;
    NSInteger selectedSegment = [unitSegment selectedSegmentIndex];
    
    switch (selectedSegment) {
        case 0:
            weightPlaceholder = @"in lbs";
            heightPlaceholder = @"in inches";
            [[self weightTextField] setText:@""];
            [[self heightTextField] setText:@""];
            [[self weightUnitLabel] setText:@""];
            [[self heightUnitLabel] setText:@""];
            [[self weightTextField] setPlaceholder:weightPlaceholder];
            [[self heightTextField] setPlaceholder:heightPlaceholder];
            flag = selectedSegment;
            break;
        case 1:
            weightPlaceholder = @"in kg";
            heightPlaceholder = @"in metres";
            [[self weightTextField] setText:@""];
            [[self heightTextField] setText:@""];
            [[self weightUnitLabel] setText:@""];
            [[self heightUnitLabel] setText:@""];
            [[self weightTextField] setPlaceholder:weightPlaceholder];
            [[self heightTextField] setPlaceholder:heightPlaceholder];
            flag = selectedSegment;
            break;
        default:
            break;
    }
}
- (IBAction)calculateBMI:(id)sender {
    
    [self.view endEditing:YES];
    
    w = [[[self weightTextField] text] doubleValue];
    h = [[[self heightTextField] text] doubleValue];
    
    if ([[[self weightTextField] text] length] == 0 || [[[self heightTextField] text] length] == 0) {
        UIAlertView* noValAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Empty value(s) exists. Please check your entry!" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [noValAlert show];
    }
    else{
    
    switch (flag) {
            case 0:
                bmi = (double) (w * 703) / (h * h);
                break;
            case 1:
                bmi =  w / (h * h);
                break;
            default:
                break;
        }
        NSString* bmiMessage = [NSString stringWithFormat:@"Your BMI is %.1f",bmi];
        [[self bmiResultLabel] setText:bmiMessage];
        [self setBMIStatus:bmi];
    }
}

-(void)setBMIStatus:(double)withBMIValue{
    NSString* bmiStatus;
    if (withBMIValue < 18.5) {
        bmiStatus = @"You are UNDERWEIGHT!";
        [self.bmiStatusLabel setTextColor:[UIColor yellowColor]];
    }
    else if (withBMIValue >= 18.5 && withBMIValue <= 24.9){
        bmiStatus = @"You are HEALTHY!";
        [self.bmiStatusLabel setTextColor:[UIColor greenColor]];
    }
    else if (withBMIValue >= 25 && withBMIValue <= 29.9){
        bmiStatus = @"You are OVERWEIGHT!";
        [self.bmiStatusLabel setTextColor:[UIColor orangeColor]];
    }
    else{
        bmiStatus = @"You are OBESE!";
        [self.bmiStatusLabel setTextColor:[UIColor redColor]];
    }
    [self.bmiStatusLabel setText:bmiStatus];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == self.weightTextField) {
        switch (flag) {
            case 0:
                [[self weightUnitLabel] setText:@"lb"];
                break;
            case 1:
                [[self weightUnitLabel] setText:@"kg"];
                break;
            default:
                break;
        }
    }
    else if (textField == self.heightTextField){
        switch (flag) {
            case 0:
                [[self heightUnitLabel] setText:@"in"];
                break;
            case 1:
                [[self heightUnitLabel] setText:@"m"];
                break;
            default:
                break;
        }
    }
    
}
    

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    UIAlertView* welcomeAlert = [[UIAlertView alloc]initWithTitle:@"B.M.I Calculator" message:@"Welcome to your body mass index calculator. Please enter your weight and height in your preferred unit" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
    [welcomeAlert show];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
