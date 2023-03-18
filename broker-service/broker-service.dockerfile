#base go image

FROM golang:1.18-apline as builder

RUN mkdir /app

COPY . /app

WORKDIR /app

RUN CGO_ENABLED=0 go build -o brokerapp ./cmd/api

RUN chmod +x /app/brokerapp

#build tiny docker image

FROM alpine:latest

RUN mkdir /app

COPY --from=builder /app/brokerApp /app

CMD ["/app/brokerApp"]