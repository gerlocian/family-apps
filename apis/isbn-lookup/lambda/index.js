'use strict';
const AWS = require('aws-sdk');
const Lambda = new AWS.Lambda();

class InvokeParams {
    constructor(payload) {
        this.FunctionName = 'StepFunctionExecutionLambda';
        this.Payload = payload;
    }
}

module.exports.service = function(event, context, callback) {
    if (event && event.queryStringParameters && event.queryStringParameters.q) {
        const params = new InvokeParams({ isbn: event.queryStringParameters.q });
        Lambda.invoke(params, (err, data) => {
            /* TODO:
                 I'm done for the night. I can't stay awake. Do the thing to invoke the execution method and process the
                 results. I'm so tired...
            */
        });
        return;
    }
};

function onSuccess(callback) {

}

function onFailure(callback) {}