// -*-  Mode:ObjC; c-basic-offset:4; tab-width:8; indent-tabs-mode:nil -*-

#import "GenEditTextViewController.h"

@implementation GenEditTextViewController

@synthesize delegate, identifier, text;

+ (GenEditTextViewController *)genEditTextViewController:(id<GenEditTextViewDelegate>)delegate title:(NSString*)title identifier:(int)id
{
    GenEditTextViewController *vc = [[[GenEditTextViewController alloc]
                                         initWithNibName:@"GenEditTextView"
                                         bundle:[NSBundle mainBundle]] autorelease];
    vc.delegate = delegate;
    vc.title = title;
    vc.identifier = id;

    return vc;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

#if 0
    if (IS_IPAD) {
        CGSize s = self.contentSizeForViewInPopover;
        s.height = 300;
        self.contentSizeForViewInPopover = s;
    }
#endif
    
    textField.placeholder = self.title;
	
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                                  initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self
                                                  action:@selector(doneAction)] autorelease];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [text release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    textField.text = text;
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)doneAction
{
    self.text = textField.text;
    [delegate genEditTextViewChanged:self identifier:identifier];

    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
#if 0
    if (IS_IPAD) return YES;
#endif
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
