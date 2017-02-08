import Vapor
import HTTP
import VaporPostgreSQL

final class BasicController {
    
    func addRoutes(drop: Droplet) {
        let basic = drop.grouped("basic")
        basic.get("version", handler: version)
        basic.get("model", handler: model)
    }
    
    func version(request: Request) throws -> ResponseRepresentable {
        if let db = drop.database?.driver as? PostgreSQLDriver {
            let version = try db.raw("SELECT version()")
            return try JSON(node: version)
        } else {
            return "No DB connection"
        }
    }
    
    func model(request: Request) throws -> ResponseRepresentable {
        let acronym = Acronym.init(short: "AFK", long: "Away From Keyboard")
        return try acronym.makeJSON()
    }
}
