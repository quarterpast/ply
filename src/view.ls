require! {
	"./oop".subclass-tracker
	"./oop".js-subclass
	baconjs.Bacon
}

class exports.View
	import subclass-tracker!
	import js-subclass!

	@template = render: ->Bacon.never!

	class event
		values: []
		(@handler)->

	@event = (handler)->
		{prototype} = this
		out = new event handler

		process.next-tick do
			:delorean ~>
				out.values = prototype
				|> filter (is out)
				|> keys
				|> head
				|> (.split ',')
				|> map (event-ptr)~>
					[type,...parts] = words event-ptr
					sel = unwords parts

					handler if process.browser
						$ document .as-event-stream type,sel
					else Bacon.constant 0

		return out

	collect: ->
		values this
		|> reject (in View::)
		|> concat-map ->
			if it.values? then that else []
		|> Bacon.combine-all _, (import)

	render: (data = {})->
		@constructor.template.render @collect!.map (data import)