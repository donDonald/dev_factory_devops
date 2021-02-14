'use strict';

const assert = require('assert');
const fs = require('fs');

module.exports = function (options) {
    assert(options.prefix)

    let http_requests = 0;
    let timer;

    //fs.mkdirSync(`/var/${options.prefix}`, { recursive: true });

    const start = function() {
        if (!timer) {
            timer = setTimeout(write, 1000);
        }
    }

    const write = function() {
        //fs.writeFile(`/var/${options.prefix}/http_requests`, `${options.prefix}_http_requests:${ http_requests }`, (err)=>{
        fs.writeFile(`/var/${options.prefix}/http_requests`, `${http_requests}`, (err)=>{
            assert(!err, err);
            timer = undefined;
        });
    }

    return function (req, res, next) {
        ++http_requests;
        start();
        next();
    }
}

