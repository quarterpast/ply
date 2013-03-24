require! {
	"./oop".subclass-tracker
	"./oop".js-subclass
	baconjs.Bacon
}

class exports.View
	import subclass-tracker!
	import js-subclass!

	@event = (handler)->
		{prototype} = this
		out = new class event

		process.next-tick do
			:delorean ~>
				prototype
				|> filter (is out)
				|> keys
				|> head
				|> (.split ',')
				|> map (event-ptr)~>
					[type,...parts] = words event-ptr
					sel = unwords parts

					@bus.plug handler $ document .as-event-stream type,sel

		return out