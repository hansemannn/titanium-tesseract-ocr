/**
 * ti.tesseract
 *
 * Created by Hans Knoechel
 * Copyright (c) 2017 Axway Appcelerator. All rights reserved.
 */

#import "TiTesseractModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation TiTesseractModule

#pragma mark Internal

-(id)moduleGUID
{
	return @"bd15c466-99f8-4589-9bb9-b5f22526a158";
}

-(NSString *)moduleId
{
	return @"ti.tesseract";
}

#pragma mark Lifecycle

-(void)startup
{
	[super startup];
	NSLog(@"[DEBUG] %@ loaded",self);
}

#pragma Public APIs

- (void)recognize:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    // Required parameters
    id image = [args objectForKey:@"image"];
    id callback = [args objectForKey:@"callback"];
    
    // Optional parameters
    id charWhitelist = [args objectForKey:@"charWhitelist"];
    id rect = [args objectForKey:@"rect"];
    
    ENSURE_TYPE(image, NSString);
    ENSURE_TYPE(callback, KrollCallback);
    ENSURE_TYPE_OR_NIL(charWhitelist, NSString);
    ENSURE_TYPE_OR_NIL(rect, NSDictionary);
    
    // Create RecognitionOperation
    G8RecognitionOperation *operation = [[G8RecognitionOperation alloc] initWithLanguage:@"eng"];
    
    // Configure inner G8Tesseract object as described before
    // operation.tesseract.charWhitelist = @"01234567890";
    operation.tesseract.image = [[TiUtils image:image proxy:self] g8_blackAndWhite];
    
    // Apply whitelist if supplied
    if (charWhitelist != nil) {
        operation.tesseract.charWhitelist = charWhitelist;
    }
    
    // Apply rectangle if supplied
    if (rect != nil) {
        operation.tesseract.rect = [TiUtils rectValue:rect];
    }
    
    // Setup the recognitionCompleteBlock to receive the Tesseract object
    // after text recognition. It will hold the recognized text.
    operation.recognitionCompleteBlock = ^(G8Tesseract *recognizedTesseract) {
        // Retrieve the recognized text upon completion
        NSLog(@"%@", [recognizedTesseract recognizedText]);
        [(KrollCallback *)callback call:@[@{
            @"recognizedText": NULL_IF_NIL([recognizedTesseract recognizedText])
        }] thisObject:self];
    };
    
    // Add operation to queue
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}

@end
