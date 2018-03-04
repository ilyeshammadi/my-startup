FROM golang:1.7.3
WORKDIR /go/src/github.com/Ilyes-Hammadi/my-startup/
RUN go get -d -v golang.org/x/net/html  
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY ./static static
COPY --from=0 /go/src/github.com/Ilyes-Hammadi/my-startup/main .
CMD ["./main"]  