FROM golang:1.23 AS builder
WORKDIR /build

COPY src/ .
RUN go build -v -o myserver

FROM gcr.io/distroless/base-debian12
EXPOSE 8080
WORKDIR /app

COPY --from=builder /build/myserver myserver

CMD ["/app/myserver"]