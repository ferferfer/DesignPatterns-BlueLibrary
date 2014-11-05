//
//  Album+TableRepresentation.h
//  BlueLibrary
//
//  Created by Fernando Garcia Corrochano on 5/11/14.
//  Copyright (c) 2014 Eli Ganem. All rights reserved.
//

#import "Album.h"

@interface Album (TableRepresentation)
//tr_ at the beginning of the method name, as an abbreviation of the name of the category: TableRepresentation
- (NSDictionary*)tr_tableRepresentation;

@end
