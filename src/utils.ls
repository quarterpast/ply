{Bacon} = require \baconjs

exports.lift = (obj)-> if obj instanceof Bacon.Observable then obj else Bacon.constant obj
exports.into = (k,v)-->(k):v