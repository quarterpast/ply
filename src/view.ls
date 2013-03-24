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

					handler $ document .as-event-stream type,sel

		return out

	collect: ->
		values this
		|> concat-map (.values ? it!)
		|> Bacon.combine-all _, (import)

	render: (data)->
		@@template.render @collect!.map (data import)

