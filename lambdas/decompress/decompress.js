'use strict';
const compression = require(`${process.env.deployed ? './' : '../../utils/compression'}/compression`);

module.exports.service = function (event, context, callback) {
    compression.decompress(event, callback);
};
