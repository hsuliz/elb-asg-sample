FROM golang:1.23 AS builder
WORKDIR /build

COPY src/go.mod src/go.sum ./
RUN go mod download

COPY src ./
RUN CGO_ENABLED=0 go build -ldflags="-X 'main.Version=1.2.3'" -v -o myserver

FROM gcr.io/distroless/static-debian12:latest
EXPOSE 8080
WORKDIR /app

COPY --from=builder /build/myserver myserver

CMD ["/app/myserver"]