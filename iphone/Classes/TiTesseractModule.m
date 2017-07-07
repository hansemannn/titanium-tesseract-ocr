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
    id charBlacklist = [args objectForKey:@"charBlacklist"];
    id rect = [args objectForKey:@"rect"];
    id languages = [args objectForKey:@"languages"];
    id engineMode = [args objectForKey:@"engineMode"];
    
    ENSURE_TYPE(image, NSString);
    ENSURE_TYPE(callback, KrollCallback);
    ENSURE_TYPE_OR_NIL(charWhitelist, NSArray);
    ENSURE_TYPE_OR_NIL(charBlacklist, NSArray);
    ENSURE_TYPE_OR_NIL(rect, NSDictionary);
    ENSURE_TYPE_OR_NIL(languages, NSArray);
    ENSURE_TYPE_OR_NIL(engineMode, NSNumber);
    
    // Create RecognitionOperation
    G8RecognitionOperation *operation = [[G8RecognitionOperation alloc] initWithLanguage:languages ? [languages stringByAppendingString:@"+"] : @"eng"];
    
    // Configure inner G8Tesseract object as described before
    // operation.tesseract.charWhitelist = @"01234567890";
    operation.tesseract.image = [[TiUtils image:image proxy:self] g8_blackAndWhite];
    
    // Apply whitelist if supplied
    if (charWhitelist != nil) {
        operation.tesseract.charWhitelist = [charWhitelist stringByAppendingString:@","];
    }
    
    // Apply blacklist if supplied
    if (charBlacklist != nil) {
        operation.tesseract.charBlacklist = [charBlacklist stringByAppendingString:@","];
    }
    
    // Apply rectangle if supplied
    if (rect != nil) {
        operation.tesseract.rect = [TiUtils rectValue:rect];
    }
    
    // Apply engine-mode if supplied
    if (engineMode != nil) {
        operation.tesseract.engineMode = [TiUtils intValue:engineMode];
    }
    
    // Setup the recognitionCompleteBlock to receive the Tesseract object
    // after text recognition. It will hold the recognized text.
    operation.recognitionCompleteBlock = ^(G8Tesseract *recognizedTesseract) {
        // Retrieve the recognized text upon completion
        [(KrollCallback *)callback call:@[@{
            @"recognizedText": NULL_IF_NIL([recognizedTesseract recognizedText])
        }] thisObject:self];
    };
    
    // Add operation to queue
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}

MAKE_SYSTEM_PROP(ENGINE_MODE_TESSERACT_ONLY, G8OCREngineModeTesseractOnly);
MAKE_SYSTEM_PROP(ENGINE_MODE_CUBE_ONLY, G8OCREngineModeCubeOnly);
MAKE_SYSTEM_PROP(ENGINE_MODE_CUBE_COMBINED, G8OCREngineModeTesseractCubeCombined);

@end
