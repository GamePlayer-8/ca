#!/bin/sh

curl https://chimmie.k.vu/ca/ca/certificate.crt --output ca.crt
sudo trust anchor --store ca.crt
rm -f ca.crt
