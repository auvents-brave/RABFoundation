FROM swift:latest

WORKDIR /app

COPY . .

# Install swift-doc
# RUN git clone https://github.com/SwiftDocOrg/swift-doc.git && \
#     cd swift-doc && \
#     swift build -c release && \
#     mv .build/release/swift-doc /usr/local/bin/swift-doc && \
#     cd .. && \
#     rm -rf swift-doc

RUN swift test --enable-swift-testing --parallel

