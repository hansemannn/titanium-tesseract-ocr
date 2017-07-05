/**
 * ti.tesseract
 *
 * Created by Hans Knoechel
 * Copyright (c) 2017 Axway Appcelerator. All rights reserved.
 */

#import "TiModule.h"
#import "TesseractOCR.h"

@interface TiTesseractModule : TiModule

/**
 * Recognizes a given image and returns the result to a given callback.
 *
 * @param args The arguments passed to the recognition task.
 */
- (void)recognize:(id)args;

@end
