import UIKit

var greeting = "What's New in Swift 5.9"


// MARK: SE-0380 - if and switch expressions
/*
 This proposal introduces the ability to use if and switch statements as expressions, for the purpose of returning values from functions, propertie and closures; assigning values to variables; and declaring variables
 */
let num = 3

let result = if num%2 == 0 { "Even" } else { "Odd" }

let switchResult = switch num {
case 0...10: "From 0 to 10"
case 10...20: "From 10 to 20"
case 20...30: "From 20 to 30"
default: "Out of Range"
}


// MARK: SE-0393, SE-0398 and SE-0399 - Value and Type Parameter Packs
/*
 This proposal allow us to use variadic generics in new Swift. They solve us significant problem in Swift, which is that generic functions required a specific number of type parameters
 
 These functions could still accept variadic parameters, but they still had to use the same type ultimately.
 */

struct Grade1 {
    var name: String
}

struct Grade2 {
    var name: String
}

func pairUpStudents<T, U>(list1: T..., list2: U...) -> ([(T, U)]) {
    assert(list1.count == list2.count, "You must provide equal numbers of students to pair.")
    
    var pairs:[(T,U)] = []
    
    for i in 0..<list1.count {
        pairs.append((list1[i], list2[i]))
    }
    
    return pairs
}

pairUpStudents(list1: Grade1(name: "Krishna"), Grade1(name: "Vivek"), list2: Grade2(name: "Naga"), Grade2(name: "Sai"))


// MARK: SE-0382, SE-0389 & SE-0397,  - MAcros
/*
 Swift Macros allow you to generate that repetitive code at compile time, making your app's codebases more expressive and easier to read
 */
/*
@freestanding(expression) public macro URL(_ stringLiteral: String) -> URL = #externalMacro(module: "MyMacrosPlugin", type: "URLMacro")
let url = #URL("https://swift.org")
print(url.absoluteString)
*/


// MARK: SE-0390 - Noncopyable structs and enums

/*
 All currently existing types in Swift are copyable, meaning it is possible to create multiple identical, interchangeable representations of any value of the type
 
 However, copyable structs and enums are not a great model for unique resources.

 Classes by contrast can represent a unique resource, since an object has a unique identity once initialized, and only references to that unique object get copied
 
 This imposes overhead in the form of heap allocation and reference counting
 
 Noncopyable also introduces few new keywords to remember: ~Copyable, consuming, consume, discard
 */
struct User:~Copyable {
    var name: String
}


// MARK: SE-0388 - Convenience Async[Throwing]Stream.makeStream methods
/*
 This proposal adds a new makeStream() method to both AsyncStream and AsyncThrowingStream that sends back both the stream itself alongside its continuation
 */
var continuation: AsyncStream<String>.Continuation!
let stream = AsyncStream<String> { continuation = $0 }

let(stream1, continuation1) = AsyncStream.makeStream(of: String.self)


// MARK: SE-0374 - Add sleep(for:) to Clock
/*
 This proposal adds a new extension method to Swift's Clock protocol that allows us to suspend execution for a set number of seconds, but also extends duration-based Task sleeping to support a specific tolerance
 */

try await Task.sleep(for: .seconds(1), tolerance: .seconds(0.5))
