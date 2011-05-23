//
//  CouchAppCodaPlugin.h
//  CouchAppCodaPlugin
//
//  Created by Marty Schoch on 5/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CodaPlugInsController.h"


@interface CouchAppCodaPlugin : NSObject<CodaPlugIn> {
@private
    
    CodaPlugInsController* controller;
    
}

- (NSString*)name;
- (id)initWithPlugInController:(CodaPlugInsController*)inController bundle:(NSBundle*)yourBundle;
- (void)couchappPush:(id)sender;

@end
