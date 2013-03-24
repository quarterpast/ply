require! {
	"./lib".View
	"./lib".Template
	"./lib".Server
	"./lib/utils".into
	handlebars
}

Template.engine = handlebars.compile

class Main extends View
	"click h1": @event compose do
		(.map 1)
		(.scan 0 (+))
		(.map into \clicks)

	@template = new Template """<h1>Click me!</h1><h2>clicked {{clicks}} times</h2>"""

new Server!
.listen 8000