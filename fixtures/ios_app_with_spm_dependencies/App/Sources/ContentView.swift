import ComposableArchitecture
import SwiftUI

struct ContentView: View {
    init() {
        _ = Effect<Int>.none
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

#Preview {
    ContentView()
}
