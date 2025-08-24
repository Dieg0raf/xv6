# Dockerfile
FROM ubuntu:24.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential make gcc gdb-multiarch perl python3 bc \
    gcc-riscv64-unknown-elf binutils-riscv64-unknown-elf \
    qemu-system-misc \
  && rm -rf /var/lib/apt/lists/*

# Nice defaults
WORKDIR /xv6

