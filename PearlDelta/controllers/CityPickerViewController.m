//
//  CityPickerViewController.m
//  PearlDelta
//
//  Created by JERRY LIU on 8/2/13.
//  Copyright (c) 2013 com.genmk. All rights reserved.
//

#import "CityPickerViewController.h"

@interface CityPickerViewController ()

@end

@implementation CityPickerViewController

@synthesize picker, delegate, cities, pickCity;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    int startingIndex = 0;
    if (self.pickCity) startingIndex = [self.cities indexOfObject:self.pickCity];
    [self.picker selectRow:startingIndex inComponent:0 animated:NO];
    self.cityLabel.text = self.cities[startingIndex];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[self.picker selectRow:0 inComponent:0 animated:YES];
}


- (void)done {
    [self.delegate cityPicker:self didPickCity:self.pickCity];
}

- (void)cancel {
    [self.delegate cityPickerDidCancel:self];
}

-(void)cityChanged {
    int row = [self.picker selectedRowInComponent:0];
    pickCity = self.cities[row];
    self.cityLabel.text = pickCity;
}

#pragma mark -
#pragma mark PickerView Datasource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.cities.count;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.cities[row];
}

#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.pickCity = self.cities[row];
    self.cityLabel.text = self.pickCity;
}

@end
