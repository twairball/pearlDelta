//
//  CityPickerViewController.h
//  PearlDelta
//
//  Created by JERRY LIU on 8/2/13.
//  Copyright (c) 2013 com.genmk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CityPickerViewController;

@protocol CityPickerViewControllerDelegate <NSObject>
- (void)cityPickerDidCancel:(CityPickerViewController *)picker;
- (void)cityPicker:(CityPickerViewController *)picker didPickCity:(NSString *)city;
@end

@interface CityPickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) IBOutlet UILabel* cityLabel;
@property (nonatomic, strong) IBOutlet UIPickerView* picker;
@property (nonatomic, strong) id <CityPickerViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray* cities;
@property (nonatomic, strong) NSString* pickCity;
@property (nonatomic, strong) NSString* pickingFor;


- (IBAction)cancel;
- (IBAction)done;
- (IBAction)cityChanged;

@end
