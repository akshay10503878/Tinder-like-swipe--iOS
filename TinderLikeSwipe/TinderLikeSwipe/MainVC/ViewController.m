//
//  ViewController.m
//  TinderLikeSwipe
//
//  Created by akshay bansal on 10/30/17.
//  Copyright © 2017 akshay bansal. All rights reserved.
//

#import "ViewController.h"
#import "UIViewX.h"
#import "QuartzCore/QuartzCore.h"
#import "DesinableButton.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *menuView;
@property (strong, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (strong, nonatomic) IBOutlet UIViewX *card;
@property (strong, nonatomic) IBOutlet DesinableButton *menuButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.menuView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    /*--need to set these if doesnot want overlapping--*/
    //self.menuView.layer.zPosition = 1;
    //self.menuButton.layer.zPosition=1;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)menuTap:(id)sender {
    
    UIButton *button = (UIButton*)sender;
    
    [UIView animateWithDuration:0.7 animations:^{
        if( CGAffineTransformEqualToTransform(self.menuView.transform, CGAffineTransformIdentity))
        {
            self.menuView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            button.backgroundColor = [UIColor colorWithRed:209.0/255 green:56.0/255 blue:85.0/255 alpha:1];
            
        }
        else{
            
            self.menuView.transform = CGAffineTransformIdentity;
            button.backgroundColor = [UIColor colorWithRed:166.0/255 green:62.0/255 blue:80.0/255 alpha:1];
            
        }
    }];
    
}

- (IBAction)panView:(UIPanGestureRecognizer *)sender {
    
    UIViewX *card = (UIViewX*)sender.view;
    CGPoint point = [sender translationInView:card];
    
    /*--  ThumbImage alpha with distance  --*/
    
    int xCenter = card.center.x - self.view.center.x;
    if (xCenter > 0) {
        self.thumbImageView.image = [UIImage imageNamed:@"thumbs-up"];
        self.thumbImageView.tintColor = [UIColor greenColor];
        self.thumbImageView.alpha = (xCenter/self.view.center.x);
    }
    else
    {
        self.thumbImageView.image = [UIImage imageNamed:@"thumbs-down"];
        self.thumbImageView.tintColor = [UIColor redColor];
        self.thumbImageView.alpha = -(xCenter/self.view.center.x);
    }
    
    
    /*--Using two translation At same time--*/
    // Rotation and scaling
    card.transform = CGAffineTransformConcat((CGAffineTransformMakeRotation(xCenter/(self.view.center.x/0.61))), CGAffineTransformMakeScale(MIN(80.0/(abs(xCenter)), 1) , MIN(80.0/(abs(xCenter) ), 1) ));
    
    /*-- Moving the card view --*/
    if (sender.state==UIGestureRecognizerStateEnded) {
        //left side
        if (card.center.x < 65){
            [UIView animateWithDuration:0.3 animations:^{
                 card.center = CGPointMake(card.center.x-200, card.center.y);
                 self.card.alpha=0;
            }];
            return;
            }
        else if(card.center.x > self.view.frame.size.width - 65) {
           // right side
        [UIView animateWithDuration:0.3 animations:^{
            card.center = CGPointMake(card.center.x+200, card.center.y);
            self.card.alpha=0;
        }];
            return;
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            self.card.center = CGPointMake(self.view.center.x, self.view.center.y);
            self.thumbImageView.alpha=0;
            card.transform=CGAffineTransformIdentity;
        }];
        
    }
    else
    {
        self.card.center = CGPointMake(self.view.center.x+point.x, self.view.center.y);
    }
    
    
}



- (IBAction)reset:(id)sender {
    self.card.transform=CGAffineTransformIdentity;
    self.card.alpha=1;
    self.card.center=self.view.center;
    self.thumbImageView.alpha=0;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
