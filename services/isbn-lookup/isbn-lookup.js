'use strict';

const https = require('https');

module.exports.service = function ({isbn}, context, callback) {
    if (isbn) {
        https.get(`https://www.googleapis.com/books/v1/volumes?q=isbn%3D${isbn}`, (response) => {
            let fullData = '';
            response.on('error', (err) => callback(err));
            response.on('data', (data) => fullData += data);
            response.on('end', () => callback(null, { results: JSON.parse(fullData.toString()) }));
        });
    } else {
        callback(null, { message: 'No ISBN in EVENT' });
    }
};
