FROM golang:latest AS build-stage-server
COPY server.go server.go
RUN go build -ldflags "-linkmode external -extldflags -static" -a server.go

FROM scratch
COPY /src/ ./
COPY --from=build-stage-server /go/server ./server
CMD ["./server"]