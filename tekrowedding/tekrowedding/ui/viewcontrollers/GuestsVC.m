//
//  GuestsVC.m
//  tekrowedding
//
//  Created by Rocio Tovar on 29/1/15.
//  Copyright (c) 2015 Rocio Tovar. All rights reserved.
//

#import "GuestsVC.h"
#import "GuestCell.h"

@interface GuestsVC ()
{
    NSArray *_guestsArray;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GuestsVC

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_guestsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GuestCell *cell = (GuestCell *)[_tableView dequeueReusableCellWithIdentifier:@"GuestCell"];

    if (!cell) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([tableView class]) owner:self options:nil];

        // retrieve cell
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                cell = currentObject;
            }
        }
    }

    [cell setGuest:_guestsArray[indexPath.row]];

    return cell;

}

@end
