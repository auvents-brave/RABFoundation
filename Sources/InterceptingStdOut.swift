
/// Example usage:
/// ```swift
/// var output: any TextOutputStream = ""
/// await InterceptingStdOut(to: &output) {
///       FunctionUsingPrintToTraceThings()
/// }
/// #expect((output as! String).contains("wWhatever you expect to read in stdoutput"))
/// ```

import Foundation

#if os(Windows)
    #if NOTYETBUILDABLE
    #else
        import WinSDK

        /// Additionally writes any data written to standard output into the given
        /// output stream (Windows variant).
        ///
        /// - Parameters:
        ///   - output: An output stream to receive the standard output text
        ///   - encoding: The encoding to use when converting standard output into text.
        ///   - body: A closure that is executed immediately.
        /// - Returns: The return value, if any, of the `body` closure.
        public func InterceptingStdOut<T>(to output: inout TextOutputStream,
                                          encoding: String.Encoding = .utf8,
                                          body: () -> T) async -> T {
            // Setup pipes
            var readPipe: HANDLE?
            var writePipe: HANDLE?
            var sa = SECURITY_ATTRIBUTES(nLength: DWORD(MemoryLayout<SECURITY_ATTRIBUTES>.size), lpSecurityDescriptor: nil, bInheritHandle: 1)
            guard CreatePipe(&readPipe, &writePipe, &sa, 0) != 0 else {
                // Fallback: just run the body
                return body()
            }
            // Save original std output
            let originalStdOut = GetStdHandle(DWORD(STD_OUTPUT_HANDLE))
            SetStdHandle(DWORD(STD_OUTPUT_HANDLE), writePipe)

            var result: T?
            let queue = DispatchQueue(label: "stdout-capture")
            let group = DispatchGroup()
            group.enter()
            var captured = Data()

            queue.async {
                let bufferSize: DWORD = 4096
                var buffer = [UInt8](repeating: 0, count: Int(bufferSize))
                var bytesRead: DWORD = 0
                while true {
                    let success = ReadFile(readPipe, &buffer, bufferSize, &bytesRead, nil)
                    if !success || bytesRead == 0 { break }
                    captured.append(buffer[0 ..< Int(bytesRead)])
                }
                group.leave()
            }
            // Run body
            result = body()
            // Close write end to trigger EOF
            _ = CloseHandle(writePipe)
            group.wait()
            SetStdHandle(DWORD(STD_OUTPUT_HANDLE), originalStdOut)
            // Write captured output
            if let string = String(data: captured, encoding: encoding) {
                output.write(string)
            }
            return result!
        }
    #endif
#else
    /// Additionally writes any data written to standard output into the given
    /// output stream.
    ///
    /// - Parameters:
    ///   - output: An output stream to receive the standard output text
    ///   - encoding: The encoding to use when converting standard output into text.
    ///   - body: A closure that is executed immediately.
    /// - Returns: The return value, if any, of the `body` closure.
    public func InterceptingStdOut<T>(to output: inout TextOutputStream,
                                      encoding: String.Encoding = .utf8,
                                      body: () -> T) async -> T {
        var result: T?

        let consumer = Pipe() // reads from stdout
        let producer = Pipe() // writes to stdout

        let stream = AsyncStream<Data> { continuation in
            let clonedStandardOutput = dup(STDOUT_FILENO)
            defer {
                dup2(clonedStandardOutput, STDOUT_FILENO)
                close(clonedStandardOutput)
            }
            dup2(STDOUT_FILENO, producer.fileHandleForWriting.fileDescriptor)
            dup2(consumer.fileHandleForWriting.fileDescriptor, STDOUT_FILENO)

            consumer.fileHandleForReading.readabilityHandler = { fileHandle in
                let data = fileHandle.availableData
                if data.isEmpty {
                    continuation.finish()
                } else {
                    continuation.yield(data)
                    producer.fileHandleForWriting.write(data)
                }
            }

            result = body()
            try! consumer.fileHandleForWriting.close()
        }

        for await chunk in stream {
            output.write(String(data: chunk, encoding: encoding)!)
        }

        return result!
    }
#endif
