//
//  ViewController.m
//  picMe
//
//  Created by Bhavin Ahir on 2017-06-06.
//  Copyright © 2017 Bhavin Ahir. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


AVCaptureSession *session;
AVCaptureStillImageOutput *StillImageOutput;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    
    session = [[AVCaptureSession alloc] init];
    
    [session setSessionPreset:AVCaptureSessionPresetPhoto];
    
   // AVCaptureDevice *inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDevice *inputDevice = nil;
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for(AVCaptureDevice *camera in devices) {
        if([camera position] == AVCaptureDevicePositionFront) { // front is front camera
            inputDevice = camera;
            break;
        }
    }
    
    
    NSError *error;
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:&error];
    if ([session canAddInput:deviceInput]) {
        [session addInput:deviceInput];
        }
AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    CALayer *rootLayer = [[self view] layer];
    [rootLayer setMasksToBounds:YES];
    CGRect frame = frameforcapture.frame;
    [previewLayer setFrame:frame];
    [rootLayer insertSublayer:previewLayer atIndex:0];
    StillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [StillImageOutput setOutputSettings:outputSettings];
    [session addOutput:StillImageOutput];
    [session startRunning];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)takePhoto:(id)sender{

    AVCaptureConnection *videoConnections = nil;
    
    for (AVCaptureConnection *connection in StillImageOutput.connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType]isEqual:AVMediaTypeVideo]) {
                videoConnections = connection;
                break;
            }
        }
    }

 [StillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnections completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
     if (imageDataSampleBuffer != NULL) {
        
         NSData *imagedata = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer ];
         
         UIImage *image = [UIImage imageWithData:imagedata];
         imageView.image = image;
         
     }
 }];
}

@end
