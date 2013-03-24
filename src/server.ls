require! {
	io: \socket.io
	\livewire
	\http
	"./comms"
	"./view".View
	baconjs.Bacon
	\browserify
	\liveify
	\require-folder
	path
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
	.take 1

bundle = browserify [require.main.filename]

require.main.filename
|> path.dirname
|> require-folder _, callback: (filename)->
	return if filename is require.main.filename
	bundle.require filename
	require filename

livewire.GET "/bundle.js" (res)->
	res{}headers.content-type = "application/javascript"
	bundle
	.transform liveify
	.bundle!


class exports.Server
	listen: (port,address)->
		@app.listen port,address

	->
		@app = http.create-server livewire.app

		io.listen @app
		.of "/comms"
		.on \connection (socket)->
			comms.init socket
