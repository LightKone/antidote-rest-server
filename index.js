// configure
var ANTIDOTE_REST_API_HOST_NAME = 'localhost'; // antidote hostname
var ANTIDOTE_REST_API_HOST_PORT = 8087; // antidote port
var ANTIDOTE_REST_API_PORT = 3000; // web server port

var express = require('express');
var antidoteClient = require('antidote_ts_client');
// debug
var util = require('util');

var antidote = antidoteClient.connect(ANTIDOTE_REST_API_HOST_PORT, ANTIDOTE_REST_API_HOST_NAME);
var server = express();
server.listen(ANTIDOTE_REST_API_PORT);
var numRequests = 0;

console.log('Using Antidote on ' + ANTIDOTE_REST_API_HOST_NAME + ':' + ANTIDOTE_REST_API_HOST_PORT);
console.log('Listening on port ' + ANTIDOTE_REST_API_PORT);







// COUNTER

server.get('/counter/read/:bucket/:key', function(req, res) {
	var requestID = numRequests++;
	console.log('['+requestID+'] REQ /counter/read/' + req.params.bucket + "/" + req.params.key);
	antidote.defaultBucket = req.params.bucket;
	antidote.counter(req.params.key).read().then(value => {
		console.log('['+requestID+'] RES ' + value);
		res.send(""+value); // cast to string
	});
});

server.get('/counter/increment/:bucket/:key/:amount?', function(req, res) {
	var requestID = numRequests++;
	var amount = parseInt(req.params.amount) || 1; // cast to integer
	console.log('['+requestID+'] REQ /counter/increment/' + req.params.bucket + '/' + req.params.key + '/' + amount);
	antidote.defaultBucket = req.params.bucket;
	antidote.update(antidote.counter(req.params.key).increment(amount)).then(updateResponse => {
		console.log('['+requestID+'] RES ' + 'ok');
		res.send('ok'); // is it always ok?
	});
});



// INTEGER

server.get('/integer/read/:bucket/:key', function(req, res) {
	var requestID = numRequests++;
	console.log('['+requestID+'] REQ /integer/read/' + req.params.bucket + "/" + req.params.key);
	antidote.defaultBucket = req.params.bucket;
	antidote.integer(req.params.key).read().then(value => {
		console.log('['+requestID+'] RES ' + value);
		res.send(""+value); // cast to string
	});
});

server.get('/integer/increment/:bucket/:key/:amount?', function(req, res) {
	var requestID = numRequests++;
	var amount = parseInt(req.params.amount) || 1; // cast to integer
	console.log('['+requestID+'] REQ /integer/increment/' + req.params.bucket + '/' + req.params.key + '/' + amount);
	antidote.defaultBucket = req.params.bucket;
	antidote.update(antidote.integer(req.params.key).increment(amount)).then(updateResponse => {
		console.log('['+requestID+'] RES ' + 'ok');
		res.send('ok'); // is it always ok?
	});
});

server.get('/integer/set/:bucket/:key/:value', function(req, res) {
	var requestID = numRequests++;
	console.log('['+requestID+'] REQ /integer/set/' + req.params.bucket + '/' + req.params.key + '/' + req.params.value);
	antidote.defaultBucket = req.params.bucket;
	antidote.update(antidote.integer(req.params.key).set(parseInt(req.params.value))).then(updateResponse => {
		console.log('['+requestID+'] RES ' + 'ok');
		res.send('ok'); // is it always ok?
	});
});



// SET

server.get('/set/read/:bucket/:key', function(req, res) {
	var requestID = numRequests++;
	console.log('['+requestID+'] REQ /set/read/' + req.params.bucket + "/" + req.params.key);
	antidote.defaultBucket = req.params.bucket;
	antidote.set(req.params.key).read().then(value => {
		console.log('['+requestID+'] RES ' + value);
		res.send(value); // cast to string
	});
});

server.get('/set/add/:bucket/:key/:elem', function(req, res) {
	var requestID = numRequests++;
	console.log('['+requestID+'] REQ /set/add/' + req.params.bucket + '/' + req.params.key + '/' + req.params.elem);
	antidote.defaultBucket = req.params.bucket;
	antidote.update(antidote.set(req.params.key).add(req.params.elem)).then(updateResponse => {
		console.log('['+requestID+'] RES ' + 'ok');
		res.send('ok'); // is it always ok?
	});
});

server.get('/set/remove/:bucket/:key/:elem', function(req, res) {
	var requestID = numRequests++;
	console.log('['+requestID+'] REQ /set/remove/' + req.params.bucket + '/' + req.params.key + '/' + req.params.elem);
	antidote.defaultBucket = req.params.bucket;
	antidote.update(antidote.set(req.params.key).remove(req.params.elem)).then(updateResponse => {
		console.log('['+requestID+'] RES ' + 'ok');
		res.send('ok'); // is it always ok?
	});
});











// list all routes
for(var route in server._router.stack) {
	var route = server._router.stack[route].route;
	if(route) {
		console.log(" > " + route.path);
	}
}


