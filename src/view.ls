require! {
	"./oop".subclass-tracker
	"./oop".js-subclass
	"./utils".lift
	"./utils".into
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
				#TODO: what am i trying to do here
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

	tval = (k,v,data)->
		| v.values? => that
		| v instanceof Function => tval k,( v data),data
		| v instanceof Bacon.Observable => v.map into k
		| otherwise => lift (k):v

	collect: (data)->
		[tval k,v,data for k,v of this when k not of View.prototype]
		|> fold (++),[]
		|> Bacon.combine-with _, (import)

	render: (data = {})->
		@collect data .map (data import)
		|> @constructor.template.render