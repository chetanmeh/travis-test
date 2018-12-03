// Licensed to the Apache Software Foundation (ASF) under one or more contributor
// license agreements; and to You under the Apache License, Version 2.0.

function eat(memoryMB) {
    var bytes = 1*1024*1024*memoryMB;
    var s = "foo";
    while(s.length < bytes) {
        s = s + s;
    }
    console.log('done.');
}

function main(msg) {
    console.log('helloEatMemory', 'memory ' + msg.payload + 'MB');
    //global.gc();
    eat(msg.payload);
    return {msg: 'OK, buffer of size ' + msg.payload + ' MB has been filled.'};
}

main({payload:256})