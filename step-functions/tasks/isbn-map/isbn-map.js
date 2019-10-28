'use strict';
const compression = require(`${process.env.deployed ? './' : '../../utils/compression'}/compression`);

module.exports.service = (event, context, callback) => {
    compression.decompress(event, (err, decompressed) => {
        if (err) { callback(err); return; }
        const mapped = JSON.parse(decompressed.toString()).items.map(mapItems);
        compression.compress(mapped, callback);
    });
};

function mapItems(item) {
    return {
        title: item.volumeInfo.title,
        subtitle: item.volumeInfo.subtitle,
        authors: item.volumeInfo.authors,
        thumbnail: item.volumeInfo.imageLinks.thumbnail
    }
}
