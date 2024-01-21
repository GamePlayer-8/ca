#!/bin/sh

curl https://ca.chimmie.k.vu/ca/certificate.crt --output ca.crt
sudo mv ca.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates
