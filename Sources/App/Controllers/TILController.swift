import Vapor
import HTTP

final class TILController {
    
    func addRoutes(drop: Droplet) {
        drop.get("til", handler: indexView)
    }
    
    func indexView(request: Request) throws -> ResponseRepresentable {
        return try JSON(node: Acronym.all().makeNode())
    }
}
