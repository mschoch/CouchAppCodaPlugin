//
//  CouchAppCodaPlugin.m
//  CouchAppCodaPlugin
//
//  Created by Marty Schoch on 5/23/11.
//  Copyright 2011 Marty Schoch.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
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
