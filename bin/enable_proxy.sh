#!/bin/sh

export http_proxy=socks5://127.0.0.1:10088
export https_proxy=socks5://127.0.0.1:10088
fish -C "echo 'proxy set to socks5://127.0.0.1:10088'"
