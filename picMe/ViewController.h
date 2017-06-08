//
//  ViewController.h
//  picMe
//
//  Created by Bhavin Ahir on 2017-06-06.
//  Copyright © 2017 Bhavin Ahir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController {
    IBOutlet UIView *frameforcapture;
    IBOutlet UIImageView *imageView;
    

}

-(IBAction)takePhoto:(id)sender;


@end

