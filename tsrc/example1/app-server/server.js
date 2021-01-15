// index.js

// To ask the server: curl http://localhost:3000/

const http = require('http')
const os = require('os')
const port = 3000

const caption = '[' + os.hostname() + '@' + os.userInfo().username + '] ';
let reqCount = 0;

const requestHandler = (request, response) => {
    console.log(request.url)
    ++reqCount;
    response.end(caption + 'Hallo Node.js Server, reqs:' + reqCount + '\n')
}

const server = http.createServer(requestHandler)

server.listen(port, (err) => {
    if (err) {
        return console.log(caption + 'something bad happened', err)
    }
    console.log(caption + "Hallo Node.js server is listening on " + port)
    console.log(caption + `Try this:$ curl http://localhost:${port}`)
})
