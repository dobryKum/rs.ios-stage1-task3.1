#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong) UIView *viewResultColor;

@property(nonatomic, strong) UILabel *labelRed;
@property(nonatomic, strong) UILabel *labelGreen;
@property(nonatomic, strong) UILabel *labelBlue;
@property(nonatomic, strong) UILabel *labelResultColor;

@property(nonatomic, strong) UITextField *textFieldRed;
@property(nonatomic, strong) UITextField *textFieldGreen;
@property(nonatomic, strong) UITextField *textFieldBlue;

@property(nonatomic, strong) UIButton *buttonProcess;

@end

@implementation ViewController

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.labelResultColor = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, 90, 30)];
    self.labelRed = [[UILabel alloc] initWithFrame:CGRectMake(30, 150, 60, 30)];
    self.labelGreen = [[UILabel alloc] initWithFrame:CGRectMake(30, 200, 60, 30)];
    self.labelBlue = [[UILabel alloc] initWithFrame:CGRectMake(30, 250, 60, 30)];
    
    self.labelResultColor.text = @"Color";
    self.labelRed.text = @"RED";
    self.labelGreen.text = @"GREEN";
    self.labelBlue.text = @"BLUE";
    
    self.viewResultColor = [[UIView alloc] initWithFrame:CGRectMake(140, 100, 180, 30)];
    self.textFieldRed = [[UITextField alloc] initWithFrame:CGRectMake(120, 150, 200, 30)];
    self.textFieldGreen = [[UITextField alloc] initWithFrame:CGRectMake(120, 200, 200, 30)];
    self.textFieldBlue = [[UITextField alloc] initWithFrame:CGRectMake(120, 250, 200, 30)];
    
    self.viewResultColor.backgroundColor = UIColor.grayColor;
    
    self.textFieldRed.borderStyle = UITextBorderStyleRoundedRect;
    self.textFieldGreen.borderStyle = UITextBorderStyleRoundedRect;
    self.textFieldBlue.borderStyle = UITextBorderStyleRoundedRect;

    self.textFieldRed.placeholder = @"0..255";
    self.textFieldGreen.placeholder = @"0..255";
    self.textFieldBlue.placeholder = @"0..255";
    
    [self.textFieldRed addTarget:self action:@selector(returnToDefaultState) forControlEvents:UIControlEventAllTouchEvents];
    [self.textFieldGreen addTarget:self action:@selector(returnToDefaultState) forControlEvents:UIControlEventAllTouchEvents];
    [self.textFieldBlue addTarget:self action:@selector(returnToDefaultState) forControlEvents:UIControlEventAllTouchEvents];
    
    self.buttonProcess = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - 50, 300, 100, 30)];
    [self.buttonProcess setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.buttonProcess setTitle:@"Process" forState:UIControlStateNormal];
    [self.buttonProcess addTarget:self action:@selector(buttonProcessTapped) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.accessibilityIdentifier = @"mainView";
    self.textFieldRed.accessibilityIdentifier = @"textFieldRed";
    self.textFieldGreen.accessibilityIdentifier = @"textFieldGreen";
    self.textFieldBlue.accessibilityIdentifier = @"textFieldBlue";
    self.buttonProcess.accessibilityIdentifier = @"buttonProcess";
    self.labelRed.accessibilityIdentifier = @"labelRed";
    self.labelGreen.accessibilityIdentifier = @"labelGreen";
    self.labelBlue.accessibilityIdentifier = @"labelBlue";
    self.labelResultColor.accessibilityIdentifier = @"labelResultColor";
    self.viewResultColor.accessibilityIdentifier = @"viewResultColor";
    
    [self.view addSubview:self.labelResultColor];
    [self.view addSubview:self.labelRed];
    [self.view addSubview:self.labelGreen];
    [self.view addSubview:self.labelBlue];
    
    [self.view addSubview:self.viewResultColor];
    [self.view addSubview:self.textFieldRed];
    [self.view addSubview:self.textFieldGreen];
    [self.view addSubview:self.textFieldBlue];
    
    [self.view addSubview:self.buttonProcess];
}

-(void)buttonProcessTapped {
    NSString *redValue = self.textFieldRed.text;
    NSString *greenValue = self.textFieldGreen.text;
    NSString *blueValue = self.textFieldBlue.text;
    
    [self returnToDefaultState];
    
    if (redValue.length == 0 || greenValue.length == 0 || blueValue.length == 0 ||
        ![self.textFieldRed.text isEqual:[NSString stringWithFormat:@"%d", redValue.intValue]] ||
        ![self.textFieldGreen.text isEqual:[NSString stringWithFormat:@"%d", greenValue.intValue]] ||
        ![self.textFieldBlue.text isEqual:[NSString stringWithFormat:@"%d", blueValue.intValue]] ||
        [redValue intValue] < 0 || [redValue intValue] > 255 ||
        [blueValue intValue] < 0 || [greenValue intValue] > 255 ||
        [greenValue intValue] < 0 || [blueValue intValue] > 255) {
        self.labelResultColor.text = @"Error";
        self.viewResultColor.backgroundColor = UIColor.grayColor;
        return;
    }
    
    UIColor *newResultColor = [UIColor colorWithRed:[redValue floatValue]/255
                                              green:[greenValue floatValue]/255
                                               blue:[blueValue floatValue]/255
                                              alpha:1.0];
    self.viewResultColor.backgroundColor = newResultColor;
    [self.labelResultColor setText:[self hexStringFromColor:newResultColor]];
}

-(void)returnToDefaultState {
    if ([self.labelResultColor.text  isEqual: @"Color"])
        return;
    self.labelResultColor.text = @"Color";
    self.viewResultColor.backgroundColor = UIColor.grayColor;
    self.textFieldRed.text = @"";
    self.textFieldGreen.text = @"";
    self.textFieldBlue.text = @"";
}

- (NSString *)hexStringFromColor:(UIColor *)color {
    const CGFloat *components = CGColorGetComponents(color.CGColor);

    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];

    return [NSString stringWithFormat:@"0x%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255)];
}

@end
