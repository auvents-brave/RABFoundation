#if !os(Windows) && !os(Linux) && !os(Android)
    @testable import RabFoundation
    import Testing

    @Test("Intercepting StdOut") func Log() async throws {
        var output: any TextOutputStream = ""
        await InterceptingStdOut(to: &output) {
            print("Hello World!")
        }
        #expect((output as! String).contains("World"))
    }
#endif
