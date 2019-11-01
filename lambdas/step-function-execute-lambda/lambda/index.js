'use strict';
const AWS = require('aws-sdk');
const stepFunction = new AWS.StepFunctions();

module.exports.service = function(event, context, callback) {
    console.log(process.env);
};