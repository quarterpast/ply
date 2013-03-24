exports.subclass-tracker = ->
	subclasses: []
	extended: (sub)->
		process.next-tick ~> # if you're using .extend, display-name isn't defined right away
			@subclasses[sub.display-name] = sub

exports.js-subclass = ->
	extend: (name,proto)->
		class extends this implements spec
			@display-name = name
