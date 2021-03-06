import PackageDescription

let package = Package(
    name: "HelloPersistance",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1, minor: 4),
        .Package(url: "https://github.com/vapor/postgresql-provider", majorVersion: 1, minor: 0)
        
        // .Package(url: "https://github.com/OpenKitten/MongoKitten.git", majorVersion: 3)
        
       // .Package(url: "https://github.com/vapor/mysql-provider.git", majorVersion: 1, minor: 0)
    ],
    exclude: [
        "Config",
        "Database",
        "Localization",
        "Public",
        "Resources",
        "Tests",
    ]
)

