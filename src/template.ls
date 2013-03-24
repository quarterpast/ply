{Bacon} = require \baconjs
{lift} = require "./utils"

class exports.Template
	@engine = (content)-> render: ->content
	render: (data)->
		@compiled.combine (lift data), \.render
	(content)->
		@content = lift content
		@compiled = @content.map @@engine