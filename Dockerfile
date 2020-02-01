FROM golang:1.13-alpine AS builder

RUN apk add --no-cache git

WORKDIR /go/src/app
ADD . .

RUN GOOS=linux GOARCH=amd64 go build -i -ldflags "-s -w" -o /go/src/app/slack-webm-sentinel



FROM jrottenberg/ffmpeg:4.1-alpine

RUN apk add --no-cache ca-certificates ffmpeg

WORKDIR /app
COPY --from=builder /go/src/app/slack-webm-sentinel /app/slack-webm-sentinel

ENTRYPOINT ["/app/slack-webm-sentinel"]
