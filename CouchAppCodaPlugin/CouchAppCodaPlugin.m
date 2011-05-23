//
//  CouchAppCodaPlugin.m
//  CouchAppCodaPlugin
//
//  Created by Marty Schoch on 5/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CouchAppCodaPlugin.h"


@implementation CouchAppCodaPlugin


- (NSString*)name {
	return @"CouchApp";
}

-(id)initWithPlugInController:(CodaPlugInsController *)inController bundle:(NSBundle *)yourBundle {
    
	if ( (self = [super init]) != nil ) {
		controller = inController;
        [controller registerActionWithTitle:NSLocalizedString(@"Couchapp Push", @"Couchapp Push")
                      underSubmenuWithTitle:nil
                                     target:self
                                   selector:@selector(couchappPush:)
                          representedObject:nil
                              keyEquivalent:@"@`"
                                 pluginName:@"CouchApp"];
	}
	return self;    
}

- (void)couchappPush:(id)sender {
    CodaTextView  *textView = [controller focusedTextView:self];
    NSString *siteLocalPath = [textView siteLocalPath];
    
    if(siteLocalPath != nil) {
        NSTask *task = [[NSTask alloc] init];
        [task setCurrentDirectoryPath:siteLocalPath];
        [task setLaunchPath:@"/usr/local/bin/couchapp"];
        [task setArguments:[NSArray arrayWithObject:@"push"]];

        [task launch];
        [task waitUntilExit];
        int status = [task terminationStatus];
        
        if (status == 0)
            NSLog(@"Couchapp push succeeded.");
        else
            NSLog(@"Couchapp push failed.");        
    }
    
}

@end
