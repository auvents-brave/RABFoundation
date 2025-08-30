FROM swift:latest

WORKDIR /app

COPY . .

RUN swift build --configuration release

RUN swift test --parallel --skip-build
