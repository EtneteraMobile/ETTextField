# ETTextField

_Last revision: 15.6.2020_

ETTextField is an extension of traditional UITextField which simplifies its customization and event handling. To get a quick idea jump to example section below!

![Example](Docs/example.png)

## Features
- Fully customizable UI (colors, borders, insets, etc.)
- Floating title when user starts typing
- Error messages below text field with custom tint color
- Observation of user interaction with ETBinding events

## Usage
Create style for your text field with `TextFieldStyle`:
```swift
let style = TextFieldStyle(
    background: UIColor(white: 245.0/255.0, alpha: 1),
    font: UIFont.systemFont(ofSize: 14, weight: .light),
    tintColor: .blue,
    cornerRadius: 5.0,
    insets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10),
    border: [.bottom],
    borderColor: .blue
)
```
Setup text field:
```swift
let textField = ETTextField()
textField.update(with: style)
textField.placeholder = "Enter your first name"
textField.title = "YOUR FIRST NAME:"
textField.titleOffset = -3.0
view.addSubview(textField)
```
Observe user interaction:
```swift
textField.onDidBeginEditing.observe(owner: label) {
    // When user starts editing
}
textField.onDidEndEditing.observe(owner: label) {
    // When user ends editing
}
textField.onDidChangeText.observe(owner: label) { text in
    // When input text changes
}
textField.onReturnKeyPressed.observe(owner: self) {
    // When user hits return
}
```
Show error messages:
```swift
textField.showError(message: "Error example")
```
For more info see included example project.

## Installation

### CocoaPods

Add `pod 'ETTextField'` to your Podfile.

### Carthage

Add `github "EtneteraMobile/ETTextField"` to your Cartfile.

### Swift Package Manager

In Xcode (>11.0) go to File -> Swift Packages -> Add Package Dependency. There insert `https://github.com/EtneteraMobile/ETTextField` in URL input and finish importing `ETTextField` to your project.

## Contributing

Contributions to ETTextField are welcomed and encouraged!

## License

ETTextField is available under the MIT license. See [LICENSE](LICENSE) for more information.
