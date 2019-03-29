# What is `SwiftBonaFideCharacterSet`?

`BonaFideCharacterSet` defined in this library "`SwiftBonaFideCharacterSet`" is a set of `Character`s.

## Is it different from `Foundation.CharacterSet`?

Yes, we have already `CharacterSet` that is defined in `Foundation` framework.
However, [as Apple also says](http://j.mp/strmanifesto-cset-swift-4_1), `Foundation.CharacterSet` is *NOT* a set of `Character`s but of `UnicodeScalar`s.   
See the following code:

```Swift
let jpFlag: Character = "🇯🇵" // Flag of Japan
let amFlag: Character = "🇦🇲" // Flag of Armenia
let paFlag: Character = "🇵🇦" // Flag of Panama

let japanAndArmenia: String = "\(jpFlag)\(amFlag)"
let paFlagSet = CharacterSet(charactersIn:"\(paFlag)")

let whichFlag = japanAndArmenia.components(separatedBy:paFlagSet).joined()
print(whichFlag) // Prints "🇯🇲" (Flag of Jamaica)
```

The result is extremely strange if `Foundation.CharacterSet` is truly a set of `Character`s.
`BonaFideCharacterSet` may be useful when you want a genuine set of `Character`s:

```Swift
let jpFlag: Character = "🇯🇵" // Flag of Japan
let amFlag: Character = "🇦🇲" // Flag of Armenia
let paFlag: Character = "🇵🇦" // Flag of Panama

let japanAndArmenia: String = "\(jpFlag)\(amFlag)"
let jpAndAmSet = BonaFideCharacterSet(charactersIn:japanAndArmenia)

print(jpAndAmSet.contains(jpFlag)) // Prints "true"
print(jpAndAmSet.contains(amFlag)) // Prints "true"
print(jpAndAmSet.contains(paFlag)) // Prints "false"

let invertedSet = jpAndAmSet.inverted
print(invertedSet.contains(jpFlag)) // Prints "false"
print(invertedSet.contains(amFlag)) // Prints "false"
print(invertedSet.contains(paFlag)) // Prints "true"
```

## Character Comparison

Comparison of `Character`s depends on the version of Swift:

```Swift
// Unicode Character "Ä" is...
// * U+00C4 when it is normalized using NFC
// * U+0041 U+0308 when it is normalized using NFD

print(Character("\u{00C4}") < Character("B"))
  // Prints "true" in Swift 4.1.2
  // Prints "false" in Swift 4.1.50
  
print(Character("\u{0041}\u{0308}") < Character("B"))
  // Prints "true" in Swift 4.1.2
  // Prints "false" in Swift 4.1.50
```

### Normalized Character

This library also provides `DecomposedCharacter` and `PrecomposedCharacter`.
`DecomposedCharacter` represents a character that is always normalized using NFD.
`PrecomposedCharacter` represents a character that is always normalized using NFC.
They are compared as arrays of Unicode scalars.

```Swift
print(DecomposedCharacter("Ä") < DecomposedCharacter("B"))
// Always prints "true"

print(PrecomposedCharacter("Ä") < PrecomposedCharacter("B"))
// Always prints "false"
```

There are `DecomposedCharacterSet` and `PrecomposedCharacterSet`
provided by this library.

```Swift
let dset = DecomposedCharacterSet(charactersIn:"A"..<"B")
print(dset.contains("Ä")) // Prints "true"

let pset = PrecomposedCharacterSet(charactersIn:"A"..<"B")
print(pset.contains("Ä")) // Prints "false"
```


# Requirements

- Swift 5 (Compatibility mode for Swift 4 or 4.2 is also OK.)
- macOS or Linux

## Dependencies

- [SwiftRanges](https://github.com/YOCKOW/SwiftRanges)
- [SwiftPredicate](https://github.com/YOCKOW/SwiftPredicate)


# License

MIT License.  
See "LICENSE.txt" for more information.

