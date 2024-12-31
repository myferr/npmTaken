import Foundation

func checkNpmPackageName(_ packageName: String) {
    let url = URL(string: "https://registry.npmjs.org/\(packageName)")!
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode == 404 {
                print("The package name '\(packageName)' is available.")
                exit(0)
            } else {
                print("The package name '\(packageName)' is taken.")
                exit(1)
            }
        } else if let error = error {
            print("Error: \(error.localizedDescription)")
            exit(1)
        }
    }
    task.resume()
}

if CommandLine.argc < 2 {
    print("Usage: swift-cli <package-name>")
    exit(1)
} else {
    let packageName = CommandLine.arguments[1]
    checkNpmPackageName(packageName)
    RunLoop.main.run()
}