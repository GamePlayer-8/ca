#!/bin/sh

curl https://ca.chimmie.k.vu/ca/certificate.crt --output ca.crt
sudo trust anchor --store ca.crt
rm -f ca.crt
