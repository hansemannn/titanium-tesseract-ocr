var Tesseract = require('ti.tesseract');

var image = 'image_sample_tr.png';

var win = Ti.UI.createWindow({
    backgroundColor: '#fff'
});

var btn = Ti.UI.createButton({
    title: 'Recognize Image',
    top: 200
});

btn.addEventListener('click', function() {
    Tesseract.recognize({
        image: image,
        callback: function(e) {
            alert('Result: ' + e.recognizedText);
        }
    })
});

win.add(Ti.UI.createImageView({
    image: image,
    top: 50,
    width: 300
}));

win.add(btn);
win.open();
