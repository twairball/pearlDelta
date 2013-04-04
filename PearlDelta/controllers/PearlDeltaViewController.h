//
//  PearlDeltaViewController.h
//  PearlDelta
//
//  Created by JERRY LIU on 8/2/13.
//  Copyright (c) 2013 com.genmk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityPickerViewController.h"

@interface PearlDeltaViewController : UIViewController <CityPickerViewControllerDelegate>

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;

@property (nonatomic, strong) IBOutlet UILabel* departLabel;
@property (nonatomic, strong) IBOutlet UILabel* arrivalLabel;

@property (nonatomic, strong) IBOutlet UIButton* departButton;
@property (nonatomic, strong) IBOutlet UIButton* arrivalButton;
@property (nonatomic, strong) IBOutlet UIButton* doneButton;


@end
