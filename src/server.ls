require! {
	io: \socket.io
	\livewire
	\http
	"./comms"
	"./view".View
	baconjs.Bacon
}

Bacon.Observable::pipe = (out)->
	@subscribe (event)->
		match event
		| (.has-value!) => out.write event.value!
		| (.is-error!)  => out.emit \error event.error
		| (.is-end!)    => out.end!
	return out

livewire.GET "/" (res)->
	new View.subclasses.Main!
	.render {}

	
class exports.Server
	listen: (port,address)->
		@app.listen port,address

	->
		@app = http.create-server livewire.app

		io.listen @app
		.of "/comms"
		.on \connection (socket)->
			comms.init socket
