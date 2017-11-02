# InitFromStoryboard
A UIViewController extension to make instantiating from storyboards easier.

InitFromStoryboard allows safe and easy access to UIViewControllers within UIStoryboards without all of the boiler plate code or type checking.

#### Installation

Add the UIViewController+InitFromStoryboard.swift file to your project. 



#### Basic Usage:

Lets assume your have a UIViewController subclass named "SomeViewController" whose scene is defined in the Main.storyboard file with the storyboard identifier of "SomeViewController".  To instantiate SomeViewController you simply need to do the following.

```
let someVC = SomeViewController.initFromStoryboard()
```
This returns a new instance of SomeViewController, instead of UIViewController, so there is no need to cast it yourself.

Notice that the storyboard identifier is the same as the class name. This is required in order to find the correct scene.

But wait... What if you wanted a UINavigationController.  You could embed SomeViewController within a UINavigationController yourself in code, however, there are cases where you want the navCon from the storyboard.  For example, if you have set a custom, non-global barTintColor.  You could do this in code as well or you could do the following:

```
let someNC = SomeViewController.initNavigationControllerFromStoryboard()
```

**Note:** This requires that the Navigation Controller scene has the same storyboard identifier as the view controller scene with a suffix of ***NavigationController***. _SomeViewControllerNavigationController_ for the example above.

#### Multiple Storyboards:

The basic usage is great and all, but it assumes you are only working with one storyboard.  Specifically the Main.storyboard that Xcode creates by default.  In order to support multiple storyboards you simply need to provide a storyboard file name string to the ***storyboardName*** parameter in the example above.

```
let someVC = SomeViewController.initFromStoryboard(storyboardName: "OtherStoryboard")
```

This is cool but it requires us to type filename strings a lot and thats not safe, therefore not swift, and also wastes Xcode's handy code-completion feature.  Lets fix this by extending UIStoryboard in order to create filename constants.  Heres an example that assumes you have added an ***OtherStoryboard.storyboard*** file to your project.

```
import UIKit

extension UIStoryboard {
    @objc public static let other = "OtherStoryboard"
}
```

Now the above becomes this:
```
let someVC = SomeViewController.initFromStoryboard(storyboardName: UIStoryboard.other)
```

**Note:**  I have already created a UIStoryboard extension that declares the .main property for the ***Main*** storyboard.  This is the default storyboardName value.
