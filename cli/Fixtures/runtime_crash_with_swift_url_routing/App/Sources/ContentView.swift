import Lib
import SwiftUI

struct ContentView: View {
    init() {
        let router = ApiRoute.router()
        let request = try? router.print(.user)
        precondition(request?.method == nil)
    }

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
            Text("Hello, world!")
        }
        .padding()
    }
}
