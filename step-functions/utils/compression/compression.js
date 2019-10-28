'use strict';
const zlib = require('zlib');

module.exports.compress = (data, callback) => {
    let candidate;
    let type = typeof data;

    switch(type) {
        case 'undefined':   candidate = '';                                   break;
        case 'number':      candidate = Number(data).toString(10);      break;
        case 'bigint':      candidate = BigInt(data).toString(10);      break;
        case 'boolean':     candidate = data.toString();                      break;
        case "string":      candidate = data;                                 break;
        case "object":
            if (data === null) {
                type = 'null';
                candidate = '';
            } else {
                candidate = JSON.stringify(data);
            }
            break;
        case "function":    throw "Cannot compress a function";
        default:            throw "Unknown data type sent for compression";
    }

    zlib.gzip(candidate, (err, result) => {
        if (err) { callback(err); return; }
        callback(null, { type, result });
    });
};

module.exports.decompress = ({type, result}, callback) => {
    let data;

    if (Buffer.isBuffer(result)) {
        data = result;
    } else if (!Buffer.isBuffer(result) && result.data) {
        data = Buffer.from(result.data);
    } else {
        throw "Result does not contain a buffer value to decompress.";
    }

    zlib.gunzip(data, (err, decompressed) => {
        if (err) { callback(err); return; }

        let retVal;
        switch(type) {
            case 'undefined':   retVal = undefined;                                    break;
            case 'null':        retVal = null;                                         break;
            case 'number':      retVal = Number.parseInt(decompressed, 10);      break;
            case 'bigint':      retVal = BigInt(decompressed);                         break;
            case 'boolean':     retVal = decompressed === 'true';                      break;
            case "string":      retVal = decompressed;                                 break;
            case "object":      retVal = JSON.parse(decompressed);                     break;
            case "function":    throw "Cannot decompress a function";
            default:            throw "Unknown data type sent for decompression";
        }

        callback(null, retVal);
    });
};