import Vapor

final class Acronym: Model {
    var id: Node?
    var exists: Bool = false
    var short: String
    var long: String
    
    init(short:String,long:String) {
        self.short = short
        self.long = long
        self.id = nil
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        long = try node.extract("long")
        short = try node.extract("short")
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "short":short,
            "long":long])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create("acronyms") { users in
            users.id()
            users.string("short")
            users.string("long")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("acronyms")
    }
}
