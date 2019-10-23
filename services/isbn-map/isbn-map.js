'use strict';

module.exports.service = ({results: {items}}, context, callback) => {
    callback(null, items.map(mapItems));
};

function mapItems(item) {
    return {
        title: item.volumeInfo.title,
        subtitle: item.volumeInfo.subtitle,
        authors: item.volumeInfo.authors,
        thumbnail: item.volumeInfo.imageLinks.thumbnail
    }
}
