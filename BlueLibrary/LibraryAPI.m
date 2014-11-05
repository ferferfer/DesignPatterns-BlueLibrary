//
//  LibraryAPI.m
//  BlueLibrary
//
//  Created by Fernando Garcia Corrochano on 5/11/14.
//  Copyright (c) 2014 Eli Ganem. All rights reserved.
//

#import "LibraryAPI.h"

@implementation LibraryAPI

+ (LibraryAPI*)sharedInstance{
	// 1 Declare a static variable to hold the instance of your class, ensuring it’s available globally inside your class.
	static LibraryAPI *_sharedInstance = nil;
 
	// 2 Declare the static variable dispatch_once_t which ensures that the initialization code executes only once.
	static dispatch_once_t oncePredicate;
 
	// 3 Use Grand Central Dispatch (GCD) to execute a block which initializes an instance of LibraryAPI. This is the essence of the Singleton design pattern: the initializer is never called again once the class has been instantiated.
	dispatch_once(&oncePredicate,
								^{
									_sharedInstance = [[LibraryAPI alloc] init];
								});
	return _sharedInstance;
}

@end
