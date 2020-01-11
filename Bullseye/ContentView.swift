import SwiftUI

struct ContentView: View {
  
  @State var alertIsVisible: Bool = false
  @State var sliderValue: Double = 50.0
  @State var target: Int = Int.random(in: 1...100)
  @State var score = 0
  @State var round = 1
  
  let midnightBlue = Color(red: 0.0/255.0, green: 51.0 / 255.0, blue: 102.0 / 255.0)
  
  struct LabelStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.white)
        .shadow(color: Color.black, radius: 5, x:2, y: 2)
        .font(Font.custom("Arial Rounded MT Bold", size: 18))
    }
  }
  
  struct ValueStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.yellow)
        .shadow(color: Color.black, radius: 5, x:2, y: 2)
        .font(Font.custom("Arial Rounded MT Bold", size: 24))
    }
  }
  
  struct ButtonSmallTextStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.black)
        .shadow(color: Color.black, radius: 5, x:2, y: 2)
        .font(Font.custom("Arial Rounded MT Bold", size: 12))
    }
  }
  
  func styledText(text: String) -> some View {
    return Text(text).modifier(LabelStyle())
  }
  
  func styledValue(text: String) -> some View {
    return Text(text).modifier(ValueStyle())
  }
  
  func pointsForCurrentRound() -> Int {
    return abs(sliderValueRounded() - target)
  }
  
  func sliderValueRounded() -> Int {
    return Int(self.sliderValue.rounded())
  }
  
  func startNewGame() {
    sliderValue = 50.0
    target = Int.random(in: 1...100)
    score = 0
    round = 1
  }
  
  func alertTitle() -> String {
    let alert: String
    switch pointsForCurrentRound() {
    case 0:
      alert = "Perfect!"
    case 1..<5:
      alert = "You almost had it."
    case 5..<10:
      alert = "Not bad."
    default:
      alert = "Keep trying, looser."
    }
    return alert
  }
  
  var body: some View {
    VStack {
      Spacer()
      HStack {
        styledText(text: "Put bullseye as close as you can to:")
        styledValue(text: "\(target)")
      }
      Spacer()
      HStack {
        styledText(text: "1")
        Slider(value: self.$sliderValue, in: 1...100).accentColor(.green)
        styledText(text: "100")
      }
      Spacer()
      Button(action: {
        self.alertIsVisible = true
      }) {
        Text("Hit me")
      }
      .alert(isPresented: $alertIsVisible) { () ->
        Alert in
        return Alert(title: Text(alertTitle()),
                     message: Text("The sliders value is \(sliderValueRounded()).\n You scored \(pointsForCurrentRound())."),
                     dismissButton: .default(Text("Ok")) {
                      self.score += self.pointsForCurrentRound()
                      self.target = Int.random(in: 1...100)
                      self.round += 1
          })
      }.background(Image("Button"))
      Spacer()
      HStack {
        Button(action: {
          self.startNewGame()
        }) {
          HStack {
            Image("StartOverIcon")
            Text("Start over").modifier(ButtonSmallTextStyle())
          }
        }.background(Image("Button"))
        Spacer()
        styledText(text: "Score")
        styledValue(text: "\(score)")
        Spacer()
        styledText(text: "Round")
        styledValue(text: "\(round)")
        Spacer()
        NavigationLink(destination: AboutView()) {
          HStack {
            Image("InfoIcon")
            Text("Info").modifier(ButtonSmallTextStyle())
          }
        }.background(Image("Button"))
      }.padding(.bottom, 20)
    }
    .background(Image("Background"), alignment: .center)
    .accentColor(midnightBlue)
    .navigationBarTitle("Bullseye")
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().previewLayout(.fixed(width: 896, height: 414))
  }
}
