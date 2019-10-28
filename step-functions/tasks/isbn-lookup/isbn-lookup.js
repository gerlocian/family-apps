'use strict';
const https = require('https');
const compression = require(`${process.env.deployed ? './' : '../../utils/compression'}/compression`);

module.exports.service = function (event, context, callback) {
    compression.decompress(event, (err, request) => {
        if (err) { callback(err); return; }
        if (!request || !request.isbn) { callback("No ISBN in the request."); }

        https.get(`https://www.googleapis.com/books/v1/volumes?q=isbn%3D${request.isbn}`, (response) => {
            let fullData = '';
            response.on('error', (err) => callback(err));
            response.on('data', (data) => fullData += data);
            response.on('end', () => compression.compress(fullData, callback));
        });
    });
};
