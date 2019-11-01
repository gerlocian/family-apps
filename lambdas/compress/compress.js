'use strict';
const compression = require(`${process.env.deployed ? './' : '../../utils/compression'}/compression`);

module.exports.service = function (event, context, callback) {
    compression.compress(event, (err, compressed) => {
        console.log(compressed);
        callback(err, compressed);
    });
};
