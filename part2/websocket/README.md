var ws = new WebSocket("ws://localhost:9090/chat");
ws.onmessage = function(frame) {console.log(frame.data)};
ws.onclose = function(frame) {console.log(frame)};
ws.send("Hi");
