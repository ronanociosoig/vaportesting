import Vapor
import VaporPostgreSQL

// import VaporMySQL

let drop = Droplet(
    preparations: [Acronym.self],
    providers: [VaporPostgreSQL.Provider.self]
)
//try drop.addProvider(VaporPostgreSQL.Provider.self)
//try drop.addProvider(VaporMySQL.Provider.self)

drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "title"]
    ])
}

drop.get("version") { request in
    
    if let db = drop.database?.driver as? PostgreSQLDriver {
        let version = try db.raw("SELECT version()")
        return try JSON(node: version)
    } else {
        return "No DB connection"
    }
}

drop.get("model") { request in
    let acronym = Acronym.init(short: "AFK", long: "Away From Keyboard")
    return try acronym.makeJSON()
}

drop.get("test") { request in
    var acronym = Acronym.init(short: "AFK", long: "Away From Keyboard")
    try acronym.save()
    return try JSON(node: Acronym.all().makeNode())
}

drop.post("new") { request in
    var acronym = try Acronym(node: request.json)
    try acronym.save()
    return acronym
}

drop.get("all") { request in
    return try JSON(node: Acronym.all().makeNode())
}

drop.get("first") { request in
    return try JSON(node: Acronym.query().first()?.makeNode())
}

drop.get("afk") { request in
    return try JSON(node: Acronym.query().filter("short","afk").all().makeNode())
}

drop.get("not-afk") { request in
    return try JSON(node: Acronym.query().filter("short", .notEquals, "AFK").all().makeNode())
}

drop.get("update") { request in
    guard var first = try Acronym.query().first(),
    let long = request.data["long"]?.string else {
        throw Abort.badRequest
    }
    first.long = long
    try first.save()
    return first
}

drop.get("delete-afks") { request in
    let query = try Acronym.query().filter("short","AFK")
    try query.delete()
    return try JSON(node: Acronym.all().makeNode())
}

drop.resource("posts", PostController())

drop.run()
















