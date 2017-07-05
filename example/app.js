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
            alert(e.recognizedText);
        }
    });
});

win.add(btn);
win.open();
