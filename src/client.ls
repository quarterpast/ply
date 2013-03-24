require \jquery-browserify

require! {
	io: \socket.io-client
	"./comms"
	"./view".View
}

global import require \prelude-ls

socket = io.connect "http://localhost/comms" #TODO: self URL
socket.on \connect ->
	comms.init socket

	new View.subclasses.Main!
	.render {}
	.assign ($ 'body'), "html"

(exports import) `each` [
	require "./view"
	require "./template"
	require "./comms"
]

