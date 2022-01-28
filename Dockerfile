FROM alpine:3.15.0 AS builder

RUN apk --no-cache add cmake clang clang-dev make gcc g++ libc-dev linux-headers git

WORKDIR /src

ENV VERSION v.3.1.0-39-ga1facf0

RUN git clone https://github.com/ntop/n2n . && git checkout ${VERSION}

RUN cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/build . && make -j$(nproc) && make install

FROM alpine:3.15.0

WORKDIR /opt

COPY --from=builder /build /opt/n2n


CMD /opt/n2n/sbin/edge
