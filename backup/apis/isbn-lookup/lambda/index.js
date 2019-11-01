'use strict';
const AWS = require('aws-sdk');
const Lambda = new AWS.Lambda();

class InvokeParams {
    constructor(payload) {
        this.FunctionName = 'StepFunctionExecutionLambda';
        this.Payload = JSON.stringify(payload);
    }
}

module.exports.service = function(event, context, callback) {
    if (event && event.queryStringParameters && event.queryStringParameters.q) {
        console.log(typeof event.queryStringParameters.q);
        const params = new InvokeParams({
            isbn: event.queryStringParameters.q,
            stateMachineArn: ''
        });
        Lambda.invoke(params, (err, data) => {
            if (err) {
                onFailure(err, callback);
            } else {
                onSuccess(data, callback);
            }
        });
    } else {
        callback(null, { statusCode: 403, body: 'Bad Request' });
    }
};

function onSuccess(data, callback) {
    callback(null, { statusCode: 200, body: data });
}

function onFailure(err, callback) {
    console.error(`Could not invoke lambda: ${err.stack}`);
    callback(null, { statusCode: 500, body: "Internal Service Error" });
}