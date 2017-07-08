# 🔠 TesseractOCR in Titanium
Use the native TesseractOCR iOS-framework in Appcelerator Titanium.

| Input | Output |
|-------|--------|
|<img src="./example/image_sample_tr.png" width="300" alt="Example Image" />|<img src="https://abload.de/img/simulatorscreenshot04gtsct.png" width="300" />|

## Requirements
- [x] Titanium SDK 6.0.0 or later
- [x] A TesseractOCR language-file placed in `tessdata/*.traineddata`

## API's

### Methods

#### `recognize(args)`
- `image` (String - _Required_)
- `callback` (Function - _Required_)
- `languages` (Array<String> - _Optional_ - Default: `['eng']`)
- `charWhitelist` (Array<String> - _Optional_)
- `charBlacklist` (Array<String> - _Optional_)
- `engineMode` (`ENGINE_MODE_TESSERACT_ONLY`, `ENGINE_MODE_CUBE_ONLY`, `ENGINE_MODE_CUBE_COMBINED` - _Optional_)
- `rect` (Object - _Optional_)
  - `x`, `y`, `width`, `height`

## Example
```js
var Tesseract = require('ti.tesseract');

var win = Ti.UI.createWindow({
    backgroundColor: '#fff'
});

var btn = Ti.UI.createButton({
    title: 'Recognize Image'
});

btn.addEventListener('click', function() {
    Tesseract.recognize({
        image: 'image_sample_tr.png',
        callback: function(e) {
            alert('Text: ' + e.recognizedText);
        }
    });
});

win.add(btn);
win.open();
```

## Build
```js
cd iphone
appc ti build -p ios --build-only
```

## Legal

This module is Copyright (c) 2017-Present by Appcelerator, Inc. All Rights Reserved. 
Usage of this module is subject to the Terms of Service agreement with Appcelerator, Inc.  
