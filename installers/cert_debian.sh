#!/bin/sh

curl https://chimmie.k.vu/ca/ca/certificate.crt --output ca.crt
sudo mv ca.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates
