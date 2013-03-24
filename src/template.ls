{Bacon} = require \baconjs
{lift} = require "./utils"

class exports.Template
	@engine = (content)->->content
	render: (data)->
		@compiled.combine (lift data), (<|)
	(content)->
		@content = lift content
		@compiled = @content.map @@engine