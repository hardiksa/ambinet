FROM golang:stretch AS build-env

WORKDIR /go/src/github.com/hardiksa/ambinet

RUN apt update
RUN apt install git -y

COPY . .

RUN make build

FROM golang:stretch

RUN apt update
RUN apt install ca-certificates jq -y

WORKDIR /root

COPY --from=build-env /go/src/github.com/hardiksa/ambinet/build/ambinetd /usr/bin/ambinetd

EXPOSE 26656 26657 1317 9090

CMD ["ambinetd"]