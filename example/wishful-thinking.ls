require! {
	Ply: "../"
	"../lib/utils".into
	handlebars
	baconjs.Bacon
}

{Template,Server,Comms,View} = Ply

Template.engine = handlebars.compile

class Main extends View
	"click h1": @event compose do
		(.map 1)
		(.scan 0 (+))
		(.map into \clicks)

	greeting: "Click me!"

	tick: Bacon.from-poll 200 ->new Bacon.Next Math.random!

	@template = new Template """<h1>{{greeting}}</h1><h2>clicked {{clicks}} times</h2><h3>{{tick}}</h3>"""

unless process.browser
	new Server!
	.listen 8000