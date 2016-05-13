//
//  SettingsViewController.m
//  Mini vMac
//
//  Created by Jesús A. Álvarez on 07/05/2016.
//  Copyright © 2016 namedfork. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppDelegate.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)showInsertDisk:(id)sender {
    [[AppDelegate sharedInstance] showInsertDisk:sender];
}

- (void)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)changeSpeed:(UISegmentedControl*)sender {
    if ([sender isKindOfClass:[UISegmentedControl class]]) {
        EmulationSpeed speedValues[] = {
            EmulationSpeed1x,
            EmulationSpeed2x,
            EmulationSpeed4x,
            EmulationSpeed8x,
            EmulationSpeed16x,
            EmulationSpeedMax};
        [AppDelegate sharedInstance].emulationSpeed = speedValues[sender.selectedSegmentIndex];
    }
}

- (IBAction)changeMouseType:(UISegmentedControl*)sender {
    if ([sender isKindOfClass:[UISegmentedControl class]]) {
        [[NSUserDefaults standardUserDefaults] setBool:sender.selectedSegmentIndex == 1 forKey:@"trackpad"];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        // keyboard layout
        return 0;
    } else {
        return 1;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0: return NSLocalizedString(@"Speed", nil);
        case 1: return NSLocalizedString(@"Mouse Type", nil);
        case 2: return NSLocalizedString(@"Keyboard Layout", nil);
        case 3: return NSLocalizedString(@"About", nil);
        default: return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger section = indexPath.section;
    if (section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"speed" forIndexPath:indexPath];
        UISegmentedControl *speedControl = (UISegmentedControl*)[cell viewWithTag:128];
        EmulationSpeed speed = [AppDelegate sharedInstance].emulationSpeed;
        speedControl.selectedSegmentIndex = speed == EmulationSpeedMax ? 5 : speed;
    } else if (section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"mouse" forIndexPath:indexPath];
        UISegmentedControl *mouseControl = (UISegmentedControl*)[cell viewWithTag:128];
        mouseControl.selectedSegmentIndex = [defaults boolForKey:@"trackpad"] ? 1 : 0;
    } else if (section == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"keyboard" forIndexPath:indexPath];
    } else if (section == 3) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"about" forIndexPath:indexPath];
    }
    return cell;
}

@end