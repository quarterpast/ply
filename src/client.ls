io = require \socket.io-client
comms = require "./comms"

socket = io.connect "http://localhost/comms" #TODO: self URL
socket.on \connect ->
	comms.init socket