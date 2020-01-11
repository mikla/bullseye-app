import SwiftUI

struct AboutView: View {
  var body: some View {
    VStack {
      Text("☃ Bullseye ☃")
      Text("This bullseye. The game.")
      Text("Enjoy!")
    }
    .navigationBarTitle("About")
    .background(Image("Background"), alignment: .center)
  }
}

struct AboutView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().previewLayout(.fixed(width: 896, height: 414))
  }
}
