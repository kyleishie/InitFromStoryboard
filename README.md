# InitFromStoryboard
InitFromStoryboard allows safe and easy access to UIViewControllers within UIStoryboards without all of the boiler plate code or type checking.

#### Boiler Plate

Here is the code that one could write without InitFromStoryboard.  While this isn't bad it can be easier.
```swift
let storyboard = UIStoryboard(name: "OtherStoryboard", bundle: nil)
if let viewController = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? SomeViewController {
    /// Do something with viewController
}
```


#### Installation

Add the UIViewController+InitFromStoryboard.swift file to your project. 


#### Basic Usage:

Lets assume your have a UIViewController subclass named "SomeViewController" whose scene is defined in the Main.storyboard file with the storyboard identifier of "SomeViewController".  To instantiate SomeViewController you simply need to do the following.

```swift
let someVC = SomeViewController.initFromStoryboard()
```
This returns a new instance of SomeViewController, instead of UIViewController, so there is no need to cast it yourself.

**Notice that the storyboard identifier is the same as the class name.** This is ***required*** in order to find the correct scene.

But wait... What if you wanted a UINavigationController.  You could embed SomeViewController within a UINavigationController yourself in code, however, there are cases where you want the navCon from the storyboard.  For example, if you have set a custom, non-global barTintColor.  You could do this in code as well or you could do the following:

```swift
let someNC = SomeViewController.initNavigationControllerFromStoryboard()
```

**Note:** This requires that the Navigation Controller scene has the same storyboard identifier as the view controller scene with a suffix of ***NavigationController***. _SomeViewControllerNavigationController_ for the example above.

#### Multiple Storyboards:

The basic usage is great and all, but it assumes you are only working with one storyboard.  Specifically the Main.storyboard that Xcode creates by default.  In order to support multiple storyboards you simply need to provide a storyboard file name string to the ***storyboardName*** parameter in the example above.

```swift
let someVC = SomeViewController.initFromStoryboard(storyboardName: "OtherStoryboard")
```

This is cool but it requires us to type filename strings a lot which is just asking for bugs.  Also wastes Xcode's handy code-completion feature.  Lets fix this by extending UIStoryboard in order to create filename constants.  Heres an example that assumes you have added an ***OtherStoryboard.storyboard*** file to your project.

```swift
import UIKit

extension UIStoryboard {
    @objc public static let other = "OtherStoryboard"
}
```

Now the above becomes this:
```swift
let someVC = SomeViewController.initFromStoryboard(storyboardName: UIStoryboard.other)
```

**Note:**  I have already created a UIStoryboard extension that declares the .main property for the ***Main*** storyboard.  This is the default storyboardName value.
