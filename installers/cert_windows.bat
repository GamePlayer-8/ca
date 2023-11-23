@echo on

mkdir "C:\XaviaMaCert"
Invoke-WebRequest https://ca.chimmie.k.vu/ca/certificate.crt -O "C:\XaviaMaCert\ca.crt"
certutil -addstore "Root" "C:\XaviaMaCert\ca.crt"
del "C:\XaviaMaCert\ca.crt"
del "C:\XaviaMaCert"
