require! {
	io: \socket.io
	\livewire
	\http
	"./comms"
}

class exports.Server
	listen: (port,address)->
		@app.listen port,address

	->
		@app = http.create-server livewire.app

		io.listen @app
		.of "/comms"
		.on \connection (socket)->
			comms.init socket