//
//  NOVViewController.m
//  Is It November
//
//  Created by jl on 13/02/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import "NOVViewController.h"

@interface NOVViewController ()

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;

@end

@implementation NOVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *currentDate = [NSDate date];
    
// TESTING - testing other dates
//    NSDateComponents *testDate = [[NSDateComponents alloc] init];
//    [testDate setMonth:8];
//    [testDate setDay:29];
//    [testDate setHour:2];
//    [testDate setMinute:0];
//    [testDate setSecond:0];
//    [testDate setYear:2014];
//    NSDate *currentDate = [calendar dateFromComponents:testDate];
    
    // Current day date components
    NSDateComponents *currentDayComponents = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:currentDate];
    
    // Init variable for current year
    int currentYear = [currentDayComponents year];
    
    // Date component for 1st Nov
    NSDateComponents *novemberDate = [[NSDateComponents alloc] init];
    [novemberDate setMonth:11];
    [novemberDate setDay:1];
    [novemberDate setHour:0];
    [novemberDate setMinute:0];
    [novemberDate setSecond:0];
    // If month is December, add one to currentYear
    // as you'll want next year's November
    if ([currentDayComponents month] == 12) {
        currentYear++;
    }
    [novemberDate setYear:currentYear];
    
    // Compare today and November start date
    // and calculate the difference
    NSDate *startDate = currentDate;
    NSDate *endDate = [calendar dateFromComponents:novemberDate];
    unsigned int unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:startDate toDate:endDate options:0];
    int months = [comps month];
    int days = [comps day];
    
    // Check to see if it's currently November and update label accordingly
    // If it's November ..
    if ([currentDayComponents month] == 11) {
        self.resultLabel.text = @"YES! It is!";
        self.countdownLabel = nil;
    // If it's not November ..
    } else {
        self.resultLabel.text = @"No, it is not.";
        // If it's Oct 30 ..
        if ([currentDayComponents month] == 10 && [currentDayComponents day] == 30) {
            self.countdownLabel.text = [NSString stringWithFormat:@"There is only %d day until November.", days];
        // If it's Oct 31 ..
        } else if ([currentDayComponents month] == 10 && [currentDayComponents day] == 31) {
            self.countdownLabel.text = @"It's November tomorrow.";
        } else {
        // Any other day ..
            self.countdownLabel.text = [NSString stringWithFormat:@"There are %d months and %d days until November.", months, days];
        }
    }
}

@end
