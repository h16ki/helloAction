FROM rust:latest

RUN apt-get update && apt-get upgrade
RUN apt-get install git
RUN cargo install --git https://github.com/typst/typst
