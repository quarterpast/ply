{Bacon} = require \baconjs

module.exports = Comms = init: (@socket)->

Comms import
	out: -> new Bacon.Bus .subscribe (event)-> match event
		| (.has-value!) => Comms.socket.emit \message event.value!
		| (.is-error!)  => Comms.socket.emit \error event.error
		| (.is-end!)    => #TODO: close connection?
	in: ->
		bus = new Bacon.Bus
		bus.plug Bacon.from-event-target Comms.socket,\message

		Comms.socket.on \error bus~error
		bus

Comms import if process.browser then up:Comms.out, down:Comms.in else up:Comms.in, down:Comms.out
