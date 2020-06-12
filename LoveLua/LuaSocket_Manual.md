# The socket namespace  
The socket namespace contains the core functionality of LuaSocket.

To obtain the socket namespace, run:
```lua
-- loads the socket module 
local socket = require("socket")
```
### socket.bind(address, port [, backlog])

This function is a shortcut that creates and returns a TCP server object bound to a local address and port, ready to accept client connections. Optionally, user can also specify the backlog argument to the listen method (defaults to 32).

Note: The server object returned will have the option "reuseaddr" set to true.

### socket.connect(address, port [, locaddr, locport])

This function is a shortcut that creates and returns a TCP client object connected to a remote host at a given port. Optionally, the user can also specify the local address and port to bind (locaddr and locport).

### socket._DEBUG

This constant is set to true if the library was compiled with debug support.

### socket.newtry(finalizer)

Creates and returns a clean try function that allows for cleanup before the exception is raised.

Finalizer is a function that will be called before try throws the exception. It will be called in protected mode.

The function returns your customized try function.

Note: This idea saved a lot of work with the implementation of protocols in LuaSocket:
```lua
foo = socket.protect(function()
    -- connect somewhere
    local c = socket.try(socket.connect("somewhere", 42))
    -- create a try function that closes 'c' on error
    local try = socket.newtry(function() c:close() end)
    -- do everything reassured c will be closed 
    try(c:send("hello there?\r\n"))
    local answer = try(c:receive())
    ...
    try(c:send("good bye\r\n"))
    c:close()
end)
```
### socket.protect(func)

Converts a function that throws exceptions into a safe function. This function only catches exceptions thrown by the try and newtry functions. It does not catch normal Lua errors.

Func is a function that calls try (or assert, or error) to throw exceptions.

Returns an equivalent function that instead of throwing exceptions, returns nil followed by an error message.

Note: Beware that if your function performs some illegal operation that raises an error, the protected function will catch the error and return it as a string. This is because the try function uses errors as the mechanism to throw exceptions.

### socket.select(recvt, sendt [, timeout])

Waits for a number of sockets to change status.

Recvt is an array with the sockets to test for characters available for reading. Sockets in the sendt array are watched to see if it is OK to immediately write on them. Timeout is the maximum amount of time (in seconds) to wait for a change in status. A nil, negative or omitted timeout value allows the function to block indefinitely. Recvt and sendt can also be empty tables or nil. Non-socket values (or values with non-numeric indices) in the arrays will be silently ignored.

The function returns a list with the sockets ready for reading, a list with the sockets ready for writing and an error message. The error message is "timeout" if a timeout condition was met and nil otherwise. The returned tables are doubly keyed both by integers and also by the sockets themselves, to simplify the test if a specific socket has changed status.

**Important note**: a known bug in WinSock causes select to fail on non-blocking TCP sockets. The function may return a socket as writable even though the socket is not ready for sending.

**Another important note**: calling select with a server socket in the receive parameter before a call to accept does not guarantee accept will return immediately. Use the settimeout method or accept might block forever.

**Yet another note**: If you close a socket and pass it to select, it will be ignored.

### socket.sink(mode, socket)

Creates an LTN12 sink from a stream socket object.

Mode defines the behavior of the sink. The following options are available:

"http-chunked": sends data through socket after applying the chunked transfer coding, closing the socket when done;
"close-when-done": sends all received data through the socket, closing the socket when done;
"keep-open": sends all received data through the socket, leaving it open when done.
Socket is the stream socket object used to send the data.

The function returns a sink with the appropriate behavior.

### socket.skip(d [, ret1, ret2 ... retN])

Drops a number of arguments and returns the remaining.

D is the number of arguments to drop. Ret1 to retN are the arguments.

The function returns retd+1 to retN.

Note: This function is useful to avoid creation of dummy variables:
```lua
-- get the status code and separator from SMTP server reply 
local code, sep = socket.skip(2, string.find(line, "^(%d%d%d)(.?)"))
```
socket.sleep(time)
Freezes the program execution during a given amount of time.

Time is the number of seconds to sleep for.

### socket.source(mode, socket [, length])

Creates an LTN12 source from a stream socket object.

Mode defines the behavior of the source. The following options are available:

"http-chunked": receives data from socket and removes the chunked transfer coding before returning the data;
"by-length": receives a fixed number of bytes from the socket. This mode requires the extra argument length;
"until-closed": receives data from a socket until the other side closes the connection.
Socket is the stream socket object used to receive the data.

The function returns a source with the appropriate behavior.

### socket.gettime()

Returns the time in seconds, relative to the origin of the universe. You should subtract the values returned by this function to get meaningful values.
```lua
t = socket.gettime()
-- do stuff
print(socket.gettime() - t .. " seconds elapsed")
socket.try(ret1 [, ret2 ... retN])
```
Throws an exception in case of error. The exception can only be caught by the protect function. It does not explode into an error message.

Ret1 to retN can be arbitrary arguments, but are usually the return values of a function call nested with try.

The function returns ret1 to retN if ret1 is not nil. Otherwise, it calls error passing ret2.
```lua
-- connects or throws an exception with the appropriate error message
c = socket.try(socket.connect("localhost", 80))
socket._VERSION
```

This constant has a string describing the current LuaSocket version.