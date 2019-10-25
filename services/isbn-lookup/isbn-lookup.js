'use strict';

const https = require('https');

module.exports.service = function (event, context, callback) {
    if (event && event.isbn) {
        https.get(`https://www.googleapis.com/books/v1/volumes?q=isbn%3D${event.isbn}`, (response) => {
            let fullData = '';
            response.on('error', (err) => callback(err));
            response.on('data', (data) => fullData += data);
            response.on('end', () => callback(null, { results: JSON.parse(fullData.toString()) }));
        });
    } else {
        callback(null, { message: 'No ISBN in EVENT' });
    }
};
