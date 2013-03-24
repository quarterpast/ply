require! {
	vader.View
	vader.Template
	vader.Server
}

class Main extends vader.View
	"click h1": @event compose do
		(.map 1)
		(.scan 0 (+))
		(.map into \clicks)

	@template = new vader.Template """<h1>Click me!</h1><h2>clicked {{clicks}} times</h2>"""

new vader.Server
.listen 8000