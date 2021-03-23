## Swift Struct Memory Leak

Sample demonstration as of when struct can be allocated to heap and cause memory leak

### Preface

In principle, in Swift, structs are allocated in the stack and classes are allocated in the heap. 
Since the contents in the stack are cleared when not needed, in theory, they should not leak. 
But in real world, memory leak of structs could happen. 

And the reason is because Swift copies structs into the heap in some situation, including when struct is referenced from heap.
Another situation is when the struct is referenced from escaping block. Otherwise, if the struct is stored in the stack, 
when the escaping block executes, there is no guarantee that the struct exists.

### References, good to read/watch
- https://swiftrocks.com/memory-management-and-performance-of-value-types
- https://developer.apple.com/videos/play/wwdc2016/416/
- https://github.com/apple/swift/blob/main/docs/OptimizationTips.rst#advice-use-copy-on-write-semantics-for-large-values
