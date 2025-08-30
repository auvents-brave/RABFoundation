FROM swift:latest

RUN git clone https://auvents-brave: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@github.com/auvents-brave/RABFoundation

RUN swift test

CMD ["/bin/bash"]
