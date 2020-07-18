FROM golang:alpine as builder
WORKDIR $GOPATH/workdir
COPY . .
RUN go get -d -v
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build \
      -ldflags='-w -s -extldflags "-static"' -a \
      -o /go/bin/htmlparser .
FROM scratch
COPY --from=builder /go/bin/htmlparser /htmlparser
ENTRYPOINT ["/htmlparser"]
